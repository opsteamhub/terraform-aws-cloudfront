resource "aws_cloudfront_cache_policy" "example" {
  for_each = { for k,v in zipmap(local.cloudfront_distribution_config[*]["id"] ,local.cloudfront_distribution_config):
    k => v
  } 
  name        = "example-policy"
  comment     = "test comment"
  default_ttl = 50
  max_ttl     = 100
  min_ttl     = 1
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "whitelist"
      cookies {
        items = ["example"]
      }
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["example"]
      }
    }
    query_strings_config {
      query_string_behavior = "whitelist"
      query_strings {
        items = ["example"]
      }
    }
  }
}

#resource "aws_cloudfront_distribution" "distribution" {
#  for_each = { for k,v in zipmap(local.cloudfront_distribution_config[*]["id"] ,local.cloudfront_distribution_config):
#    k => v
#  } 
#
#  aliases                   = each.value["aliases"]
#  enabled                   = each.value["enabled"]
#  is_ipv6_enabled           = each.value["is_ipv6_enabled"]
#  comment                   = each.value["comment"]
#
#  dynamic default_cache_behavior {
#    for_each = [each.value["default_cache_behavior"]]
#    content {
#      allowed_methods         = default_cache_behavior.value["allowed_methods"]
#      cached_methods          = default_cache_behavior.value["cached_methods"]
#      #cache_policy_id         = "b684417b-a295-4702-a838-3abe73aa7fcb"
#      default_ttl             = default_cache_behavior.value["default_ttl"]
#      target_origin_id        = "teste"
#  
#      forwarded_values {
#        cookies {
#          forward                  = default_cache_behavior.value["forwarded_values"]["cookies"]["forward"]
#          whitelisted_names        = default_cache_behavior.value["forwarded_values"]["cookies"]["whitelisted_names"]
#        }
#        headers                       = default_cache_behavior.value["forwarded_values"]["headers"]
#        query_string                  = default_cache_behavior.value["forwarded_values"]["query_string"]
#        query_string_cache_keys       = default_cache_behavior.value["forwarded_values"]["query_string_cache_keys"]
#      }
#      viewer_protocol_policy        = default_cache_behavior.value["viewer_protocol_policy"]
#      max_ttl                       = default_cache_behavior.value["max_ttl"]
#      min_ttl                       = default_cache_behavior.value["min_ttl"]
#    }
#  }
#
#  default_root_object       = each.value["default_root_object"]
#
#  dynamic logging_config {
#    for_each = each.value["logging_config"]["bucket"] != null ? toset([each.value["logging_config"]]) : []
#    content {
#      include_cookies        = logging_config.value["include_cookies"]
#      bucket                 = logging_config.value["bucket"]
#      prefix                 = logging_config.value["prefix"]
#    }
#  }
#
#  dynamic ordered_cache_behavior {
#    for_each = each.value["ordered_cache_behavior"]
#    content {
#      allowed_methods         = ordered_cache_behavior.value["allowed_methods"]
#      cached_methods          = ordered_cache_behavior.value["cached_methods"]
#      default_ttl             = ordered_cache_behavior.value["default_ttl"]
#      forwarded_values {
#        cookies {
#          forward                  = ordered_cache_behavior.value["forwarded_values"]["cookies"]["forward"]
#          whitelisted_names        = ordered_cache_behavior.value["forwarded_values"]["cookies"]["whitelisted_names"]
#        }
#        headers                       = ordered_cache_behavior.value["forwarded_values"]["headers"]
#        query_string                  = ordered_cache_behavior.value["forwarded_values"]["query_string"]
#        query_string_cache_keys       = ordered_cache_behavior.value["forwarded_values"]["query_string_cache_keys"]
#      }
#      max_ttl                       = ordered_cache_behavior.value["max_ttl"]
#      min_ttl                       = ordered_cache_behavior.value["min_ttl"]
#      path_pattern                  = ordered_cache_behavior.value["path_pattern"]
#      smooth_streaming              = ordered_cache_behavior.value["smooth_streaming"]
#      target_origin_id              = ordered_cache_behavior.value["target_origin_id"]
#      viewer_protocol_policy        = ordered_cache_behavior.value["viewer_protocol_policy"]
#    }
#  }
#
#
#  dynamic logging_config {
#    for_each = each.value["logging_config"]["bucket"] != null ? toset([each.value["logging_config"]]) : []
#    content {
#      include_cookies        = logging_config.value["include_cookies"]
#      bucket                 = logging_config.value["bucket"]
#      prefix                 = logging_config.value["prefix"]
#    }
#  }  
#
#  dynamic origin {
#    for_each = each.value["origin"]
#    content {
#      connection_attempts              = origin.value["connection_attempts"]
#
#      dynamic custom_header {
#        for_each = coalesce(origin.value["custom_header"], [])
#        content {
#          name         = custom_header.value["name"]
#          value        = custom_header.value["value"] 
#        }
#      }
#
#      dynamic custom_origin_config {
#        for_each = toset([origin.value["custom_origin_config"]])
#        content {
#          http_port                       = custom_origin_config.value["http_port"]
#          https_port                      = custom_origin_config.value["https_port"]
#          origin_protocol_policy          = custom_origin_config.value["origin_protocol_policy"]
#          origin_ssl_protocols            = custom_origin_config.value["origin_ssl_protocols"]
#          origin_keepalive_timeout        = custom_origin_config.value["origin_keepalive_timeout"]
#          origin_read_timeout             = custom_origin_config.value["origin_read_timeout"]
#        }
#      }
#
#      connection_timeout               = origin.value["connection_timeout"]
#      domain_name                      = origin.value["domain_name"]
#      origin_access_control_id         = origin.value["origin_access_control_id"]
#      origin_id                        = origin.value["origin_id"]
#      origin_path                      = origin.value["origin_path"]
#      
#      dynamic origin_shield {
#        for_each = origin.value["origin_shield"]["origin_shield_region"] != null ? tomap( { "origin_shield" = origin.value["origin_shield"] }) : {}
#        content {
#          enabled                     = origin_shield.value["enabled"]
#          origin_shield_region        = origin_shield.value["origin_shield_region"]
#        }
#      }
#
#      dynamic s3_origin_config {
#        for_each = origin.value["s3_origin_config"]["origin_access_identity"] != null ? tomap( { "s3_origin_config" = origin.value["s3_origin_config"] }) : {}
#        content {
#          origin_access_identity        = s3_origin_config.value["origin_access_identity"]
#        }
#      }
#
#    }
#  }
#
#  price_class        = each.value["price_class"]
#
#  restrictions {
#    geo_restriction {
#      restriction_type        = each.value["restrictions"]["geo_restriction"]["restriction_type"]
#      locations               = each.value["restrictions"]["geo_restriction"]["locations"]
#    }
#  }
##
#  #tags = {
#  #  Environment = "production"
#  #}
#
#  viewer_certificate {
#    cloudfront_default_certificate        = each.value["viewer_certificate"]["cloudfront_default_certificate"]
#  }
#}