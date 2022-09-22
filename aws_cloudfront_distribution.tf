resource "aws_cloudfront_origin_request_policy" "origin_request_policy" {
  for_each = zipmap(    
    flatten(
      [
        for x in var.cloudfront_distribution_config:
          [ for z in x["ordered_cache_behavior"]: 
            merge(z, { "origin_request_policy_id": format("%s-%s-%s", x["id"], z["path_pattern"], z["target_origin_id"]) }) if z["origin_request_policy"]["name"] != null
          ]
      ]
    )[*]["origin_request_policy_id"],
    flatten(
      [
        for x in var.cloudfront_distribution_config:
          [ for z in x["ordered_cache_behavior"]: 
            z if z["origin_request_policy"]["name"] != null
          ]
      ]
    )
  )

  #for_each = { for k,v in zipmap(local.cloudfront_distribution_config[*]["ordered_cache_behavior"][*]["distribution_id"], 
  #                               local.cloudfront_distribution_config[*]["ordered_cache_behavior"]):
  #  k => v if z["origin_request_policy"]["name"] != null
  #}

  name           = each.value["origin_request_policy"]["name"]
  comment        = try(each.value["origin_request_policy"]["comment"], null)

  cookies_config {
    cookie_behavior = try(
                            each.value["origin_request_policy"]["cookies_config"]["cookie_behavior"],
                            local.default_cloudfront_distribution_config["origin_request_policy"]["cookies_config"]["cookie_behavior"]
                          )
    cookies {
      items        = try(each.value["origin_request_policy"]["cookies_config"]["cookies"]["items"], null)
    }
  }

  headers_config {
    header_behavior = try(
                            each.value["origin_request_policy"]["headers_config"]["header_behavior"],
                            local.default_cloudfront_distribution_config["ordered_cache_behavior"]["origin_request_policy"]["headers_config"]["header_behavior"]
                          )
    headers {
      items        = try(each.value["origin_request_policy"]["headers_config"]["headers"]["items"], null)
    }
  }
  
  query_strings_config {
    query_string_behavior = try(
                              each.value["origin_request_policy"]["query_strings_config"]["query_string_behavior"], 
                              local.default_cloudfront_distribution_config["ordered_cache_behavior"]["origin_request_policy"]["query_strings_config"]["query_string_behavior"]
                            )
    query_strings {
      items        = try(each.value["origin_request_policy"]["query_strings_config"]["query_strings"]["items"], null)
    }
  }

}

resource "aws_cloudfront_origin_access_control" "oac" {
  for_each = { for k,v in zipmap(var.cloudfront_distribution_config[*]["id"] ,var.cloudfront_distribution_config):
    k => v
  } 
  name                              = each.key
  description                       = format("OAC to manage permittion from the related distribution %s to S3", each.key)
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


resource "aws_cloudfront_distribution" "distribution" {
  for_each = { for k,v in zipmap(local.cloudfront_distribution_config[*]["id"] ,local.cloudfront_distribution_config):
    k => v
  } 
  #for_each = {}

  aliases                   = each.value["aliases"]
  enabled                   = each.value["enabled"]
  is_ipv6_enabled           = each.value["is_ipv6_enabled"]
  comment                   = each.value["comment"]

  dynamic default_cache_behavior {
    for_each = [each.value["default_cache_behavior"]]
    content {
      allowed_methods         = default_cache_behavior.value["allowed_methods"]
      cached_methods          = default_cache_behavior.value["cached_methods"]
      cache_policy_id         = default_cache_behavior.value["cache_policy_id"]
      default_ttl             = default_cache_behavior.value["default_ttl"]
  
      dynamic forwarded_values {
        for_each = default_cache_behavior.value["forwarded_values"] != null ? toset([default_cache_behavior.value["forwarded_values"]]) : []
        
        content {
          cookies {
            forward                  = forwarded_values.value["cookies"]["forward"]
            whitelisted_names        = forwarded_values.value["cookies"]["whitelisted_names"]
          }
          headers                       = forwarded_values.value["headers"]
          query_string                  = forwarded_values.value["query_string"]
          query_string_cache_keys       = forwarded_values.value["query_string_cache_keys"]
        }
      }

      max_ttl                       = default_cache_behavior.value["max_ttl"]
      min_ttl                       = default_cache_behavior.value["min_ttl"]
      smooth_streaming              = default_cache_behavior.value["smooth_streaming"]
      target_origin_id              = default_cache_behavior.value["target_origin_id"]
      viewer_protocol_policy        = default_cache_behavior.value["viewer_protocol_policy"]

    }
  }

  default_root_object       = each.value["default_root_object"]

  dynamic logging_config {
    for_each = each.value["logging_config"]["bucket"] != null ? toset([each.value["logging_config"]]) : []
    content {
      include_cookies        = logging_config.value["include_cookies"]
      bucket                 = logging_config.value["bucket"]
      prefix                 = logging_config.value["prefix"]
    }
  }  

  dynamic ordered_cache_behavior {
    for_each = each.value["ordered_cache_behavior"] != null ? each.value["ordered_cache_behavior"] : []
    #for_each = []
    content {
      allowed_methods         = ordered_cache_behavior.value["allowed_methods"]
      cached_methods          = ordered_cache_behavior.value["cached_methods"]
      cache_policy_id         = ordered_cache_behavior.value["cache_policy_id"]
      default_ttl             = ordered_cache_behavior.value["default_ttl"]
      dynamic forwarded_values {
        for_each = ordered_cache_behavior.value["forwarded_values"] != null ? toset([ordered_cache_behavior.value["forwarded_values"]]) : []
        
        content {
          cookies {
            forward                  = forwarded_values.value["cookies"]["forward"]
            whitelisted_names        = forwarded_values.value["cookies"]["whitelisted_names"]
          }
          headers                        = forwarded_values.value["headers"]
          query_string                   = forwarded_values.value["query_string"]
          query_string_cache_keys        = forwarded_values.value["query_string_cache_keys"]
        }
      }
      max_ttl                       = ordered_cache_behavior.value["max_ttl"]
      min_ttl                       = ordered_cache_behavior.value["min_ttl"]
      origin_request_policy_id      = ordered_cache_behavior.value["origin_request_policy"]["id"]
      path_pattern                  = ordered_cache_behavior.value["path_pattern"]
      target_origin_id              = ordered_cache_behavior.value["target_origin_id"]
      viewer_protocol_policy        = ordered_cache_behavior.value["viewer_protocol_policy"]
    }
  }

  dynamic origin {
    for_each = each.value["origin"]
    content {
      connection_attempts              = origin.value["connection_attempts"]

      dynamic custom_header {
        for_each = coalesce(origin.value["custom_header"], [])
        content {
          name         = custom_header.value["name"]
          value        = custom_header.value["value"] 
        }
      }

      dynamic custom_origin_config {
        for_each = contains(regexall("s3.amazonaws.com", origin.value["domain_name"]), "s3.amazonaws.com") ? [] : toset([origin.value["custom_origin_config"]])
        content {
          http_port                       = custom_origin_config.value["http_port"]
          https_port                      = custom_origin_config.value["https_port"]
          origin_protocol_policy          = custom_origin_config.value["origin_protocol_policy"]
          origin_ssl_protocols            = custom_origin_config.value["origin_ssl_protocols"]
          origin_keepalive_timeout        = custom_origin_config.value["origin_keepalive_timeout"]
          origin_read_timeout             = custom_origin_config.value["origin_read_timeout"]
        }
      }

      connection_timeout               = origin.value["connection_timeout"]
      domain_name                      = origin.value["domain_name"]
      #origin_access_control_id         = origin.value["origin_access_control_id"]
      origin_id                        = origin.value["origin_id"]
      origin_path                      = origin.value["origin_path"]
      
      dynamic origin_shield {
        for_each = origin.value["origin_shield"]["origin_shield_region"] != null ? tomap( { "origin_shield" = origin.value["origin_shield"] }) : {}
        content {
          enabled                     = origin_shield.value["enabled"]
          origin_shield_region        = origin_shield.value["origin_shield_region"]
        }
      }

      #dynamic s3_origin_config {
      #  for_each = contains(regexall("s3.amazonaws.com", origin.value["domain_name"]), "s3.amazonaws.com") ? tomap( { "s3_origin_config" = origin.value["s3_origin_config"] }) : {}
      #  content {
      #    origin_access_identity        = coalesce(s3_origin_config.value["origin_access_identity"], aws_cloudfront_origin_access_control.oac[each.key].id)
      #  }
      #}

    }
  }

  price_class        = each.value["price_class"]

  restrictions {
    geo_restriction {
      restriction_type        = each.value["restrictions"]["geo_restriction"]["restriction_type"]
      locations               = each.value["restrictions"]["geo_restriction"]["locations"]
    }
  }

  #tags = {
  #  Environment = "production"
  #}

  viewer_certificate {
    cloudfront_default_certificate        = each.value["viewer_certificate"]["cloudfront_default_certificate"]
  }
}