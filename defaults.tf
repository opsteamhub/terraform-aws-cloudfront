locals {

  default_cloudfront_distribution_config = {

    default_cache_behavior = {
      allowed_methods                = toset(["GET", "HEAD", "OPTIONS"])
      cached_methods                 = toset(["GET", "HEAD", "OPTIONS"])
  
      compress                       = true

      custom_error_response = {
        error_caching_min_ttl        = 10
      }

      default_ttl                    = 86400
      forwarded_values = {
        cookies = {
          forward                  = "all"
          whitelisted_names        = null
        }
        headers                       = toset(["*"])
        query_string                  = true
      }
      max_ttl                        = 31536000
      min_ttl                        = 0
      smooth_streaming               = false
      viewer_protocol_policy        = "redirect-to-https"
    }

    enabled                = true
    is_ipv6_enabled        = true
    http_version           = "http2and3"

    ordered_cache_behavior = {
      allowed_methods                = toset(["GET", "HEAD", "OPTIONS"])
      cached_methods                 = toset(["GET", "HEAD", "OPTIONS"])
      compress                       = true
      default_ttl                    = 3600
      forwarded_values = {
        cookies = {
          forward                  = "all"
          whitelisted_names        = null
        }
        headers                       = toset(["*"])
        headers_for_s3                = toset([])
        query_string                  = true
      }
      max_ttl                        = 86400
      min_ttl                        = 0
      
      origin_request_policy = {
        cookies_config = {
          cookie_behavior        = "all"
        }
        headers_config = {
          header_behavior        = "allViewer"
        }
        query_strings_config = {
          query_string_behavior        = "all"
        }
      }

      smooth_streaming               = false
      viewer_protocol_policy        = "redirect-to-https"
    }

    origin = {
      connection_attempts        = 3
      connection_timeout         = 10
      custom_origin_config = {
        http_port                       = 80
        https_port                      = 443
        origin_protocol_policy          = "match-viewer"
        origin_ssl_protocols            = toset(["TLSv1.2"])
        origin_keepalive_timeout        = 10
        origin_read_timeout             = 60
      }
    }

    price_class             = "PriceClass_All"

    restrictions = {
      geo_restriction = {
        restriction_type        = "none"
      }
    }

    retain_on_delete        = true

    viewer_certificate = { 
      cloudfront_default_certificate        = true 
      minimum_protocol_version              = "TLSv1.2_2021"
      ssl_support_method                    = "sni-only"
    }
    wait_for_deployment        = false
  }


  cloudfront_distribution_config = [ for x in local.cloudfront_distribution_config_normalized:
    {
      id             = x["id"]

      aliases        = x["aliases"]
      comment        = x["comment"]

      custom_error_response = [ for y in coalesce(x["custom_error_response"], []):
        {
          error_caching_min_ttl        = try(y["error_caching_min_ttl"], local.default_cloudfront_distribution_config["custom_error_response"]["error_caching_min_ttl"])
          error_code                   = y["error_code"]
          response_code                = y["response_code"]
          response_page_path           = y["response_page_path"]
        }
      ]

      default_cache_behavior = {
        allowed_methods                  = coalesce(x["default_cache_behavior"]["allowed_methods"], local.default_cloudfront_distribution_config["default_cache_behavior"]["allowed_methods"])
        cached_methods                   = coalesce(x["default_cache_behavior"]["cached_methods"], local.default_cloudfront_distribution_config["default_cache_behavior"]["cached_methods"])
        cache_policy_id                  = x["default_cache_behavior"]["cache_policy_id"]
        compress                         = coalesce(x["default_cache_behavior"]["compress"], local.default_cloudfront_distribution_config["default_cache_behavior"]["compress"])
        default_ttl                      = x["default_cache_behavior"]["cache_policy_id"] == null ? coalesce(x["default_cache_behavior"]["default_ttl"], local.default_cloudfront_distribution_config["default_cache_behavior"]["default_ttl"]) : null
        field_level_encryption_id        = x["default_cache_behavior"]["field_level_encryption_id"]
        forwarded_values = x["default_cache_behavior"]["cache_policy_id"] == null ? {
          cookies                       = coalesce(x["default_cache_behavior"]["forwarded_values"]["cookies"], local.default_cloudfront_distribution_config["default_cache_behavior"]["forwarded_values"]["cookies"])
          #headers                       = coalesce(x["default_cache_behavior"]["forwarded_values"]["headers"], local.default_cloudfront_distribution_config["default_cache_behavior"]["forwarded_values"]["headers"])
          headers                       = contains(regexall("s3.amazonaws.com", zipmap(x["origin"][*]["origin_id"], x["origin"][*]["domain_name"])[x["default_cache_behavior"]["target_origin_id"]]), "s3.amazonaws.com") ? null : x["default_cache_behavior"]["forwarded_values"]["headers"]
          query_string                  = coalesce(x["default_cache_behavior"]["forwarded_values"]["query_string"], local.default_cloudfront_distribution_config["default_cache_behavior"]["forwarded_values"]["query_string"])
          query_string_cache_keys       = x["default_cache_behavior"]["forwarded_values"]["query_string_cache_keys"]
        } : null
        function_association = [ for y in coalesce(x["default_cache_behavior"]["function_association"], []):
          {
            event_type          = try(y["event_type"], null)
            function_arn        = try(y["function_arn"], null)
          }
        ]
        lambda_function_association = [ for y in coalesce(x["default_cache_behavior"]["lambda_function_association"], []):
          {
            event_type          = try(y["event_type"], null)
            lambda_arn          = try(y["lambda_arn"], null)
            include_body        = try(y["include_body"], null)
          }
        ]
        max_ttl                         = x["default_cache_behavior"]["cache_policy_id"] == null ? coalesce(x["default_cache_behavior"]["max_ttl"], local.default_cloudfront_distribution_config["default_cache_behavior"]["max_ttl"]) : null
        min_ttl                         = x["default_cache_behavior"]["cache_policy_id"] == null ? coalesce(x["default_cache_behavior"]["min_ttl"], local.default_cloudfront_distribution_config["default_cache_behavior"]["min_ttl"]) : null
        origin_request_policy_id        = x["default_cache_behavior"]["origin_request_policy_id"]
        #realtime_log_config_arn        =    
        #response_headers_policy_id     =               
        smooth_streaming                = coalesce(x["default_cache_behavior"]["smooth_streaming"], local.default_cloudfront_distribution_config["default_cache_behavior"]["smooth_streaming"])
        target_origin_id                = x["default_cache_behavior"]["target_origin_id"]
        #trusted_key_groups             = 
        #trusted_signers                = 
        viewer_protocol_policy          = coalesce(x["default_cache_behavior"]["viewer_protocol_policy"], local.default_cloudfront_distribution_config["default_cache_behavior"]["viewer_protocol_policy"])
      }

      default_root_object        = x["default_root_object"]
      enabled                    = coalesce(x["enabled"], local.default_cloudfront_distribution_config["enabled"])
      is_ipv6_enabled            = coalesce(x["is_ipv6_enabled"], local.default_cloudfront_distribution_config["is_ipv6_enabled"])
      http_version               = coalesce(x["http_version"], local.default_cloudfront_distribution_config["http_version"])
      
      logging_config = {
        bucket                 = x["logging_config"]["bucket"]
        include_cookies        = x["logging_config"]["include_cookies"]
        prefix                 = x["logging_config"]["prefix"]
      }

      ordered_cache_behavior = [ for z in x["ordered_cache_behavior"]:
        {
          allowed_methods                  = coalesce(z["allowed_methods"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["allowed_methods"])
          cached_methods                   = coalesce(z["cached_methods"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["cached_methods"])
          cache_policy_id                  = z["cache_policy_id"]
          compress                         = coalesce(z["compress"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["compress"])
          default_ttl                      = z["cache_policy_id"] == null ? coalesce(z["default_ttl"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["default_ttl"]) : null
          field_level_encryption_id        = z["field_level_encryption_id"]
          forwarded_values = z["cache_policy_id"] == null ? { 
            cookies                       = coalesce(z["forwarded_values"]["cookies"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["forwarded_values"]["cookies"])
            headers                       = contains(regexall("s3.amazonaws.com", zipmap(x["origin"][*]["origin_id"], x["origin"][*]["domain_name"])[z["target_origin_id"]]), "s3.amazonaws.com") ? coalesce(z["forwarded_values"]["headers"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["forwarded_values"]["headers_for_s3"]) : coalesce(z["forwarded_values"]["headers"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["forwarded_values"]["headers"])
            query_string                  = coalesce(z["forwarded_values"]["query_string"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["forwarded_values"]["query_string"])
            query_string_cache_keys       = z["forwarded_values"]["query_string_cache_keys"]
          } : null
          function_association = [ for y in coalesce(z["function_association"], []):
            {
              event_type          = try(y["event_type"], null)
              function_arn        = try(y["function_arn"], null)
            }
          ]
          lambda_function_association = [ for y in coalesce(z["lambda_function_association"], []):
            {
              event_type          = try(y["event_type"], null)
              lambda_arn          = try(y["lambda_arn"], null)
              include_body        = try(y["include_body"], null)
            }
          ]
          max_ttl                         = z["cache_policy_id"] == null ? coalesce(z["max_ttl"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["max_ttl"]) : null
          min_ttl                         = z["cache_policy_id"] == null ? coalesce(z["min_ttl"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["min_ttl"]) : null

          origin_request_policy = {
            id             = try(aws_cloudfront_origin_request_policy.origin_request_policy[format("%s-%s-%s", x["id"], z["path_pattern"], z["target_origin_id"])].id, z["origin_request_policy"]["id"])
            name           = try(z["origin_request_policy"]["name"], null)
            comment        = try(z["origin_request_policy"]["comment"], null)
            cookies_config = {
              cookie_behavior        = try(z["origin_request_policy"]["cookies_config"]["cookie_behavior"], null)
              cookies = {
                items         = try(z["origin_request_policy"]["cookies_config"]["cookies"]["items"], null)
              }
            }
            headers_config = {
              header_behavior = try(z["origin_request_policy"]["cookies_config"]["cookie_behavior"], null)
              headers = {
                items =  try(z["origin_request_policy"]["header_behavior"]["headers"]["items"], null)
              }
            }
            query_strings_config = {
              query_string_behavior = try(z["origin_request_policy"]["query_strings_config"]["query_string_behavior"], null)
              query_strings = {
                items =  try(z["origin_request_policy"]["query_strings_config"]["query_strings"]["items"], null)
              }
            }
            origin_request_policy_id = format("%s-%s-%s", x["id"], z["path_pattern"], z["target_origin_id"])
          }          

          path_pattern                    = z["path_pattern"]
          #realtime_log_config_arn        =    
          #response_headers_policy_id     =               
          smooth_streaming                = coalesce(z["smooth_streaming"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["smooth_streaming"])
          target_origin_id                = z["target_origin_id"]
          #trusted_key_groups             = 
          #trusted_signers                = 
          viewer_protocol_policy          = coalesce(z["viewer_protocol_policy"], local.default_cloudfront_distribution_config["ordered_cache_behavior"]["viewer_protocol_policy"])
        }
      ]

      origin = [ for y in x["origin"]:
        {
          connection_attempts              = coalesce(y["connection_attempts"], local.default_cloudfront_distribution_config["origin"]["connection_attempts"])
          custom_header                    = y["custom_header"]
          custom_origin_config = {
            http_port                       = coalesce(y["custom_origin_config"]["http_port"], local.default_cloudfront_distribution_config["origin"]["custom_origin_config"]["http_port"])
            https_port                      = coalesce(y["custom_origin_config"]["https_port"], local.default_cloudfront_distribution_config["origin"]["custom_origin_config"]["https_port"])
            origin_protocol_policy          = coalesce(y["custom_origin_config"]["origin_protocol_policy"], local.default_cloudfront_distribution_config["origin"]["custom_origin_config"]["origin_protocol_policy"])
            origin_ssl_protocols            = coalesce(y["custom_origin_config"]["origin_ssl_protocols"], local.default_cloudfront_distribution_config["origin"]["custom_origin_config"]["origin_ssl_protocols"])
            origin_keepalive_timeout        = coalesce(y["custom_origin_config"]["origin_keepalive_timeout"], local.default_cloudfront_distribution_config["origin"]["custom_origin_config"]["origin_keepalive_timeout"])
            origin_read_timeout             = coalesce(y["custom_origin_config"]["origin_read_timeout"], local.default_cloudfront_distribution_config["origin"]["custom_origin_config"]["origin_read_timeout"])
          }
          connection_timeout               = coalesce(y["connection_timeout"], local.default_cloudfront_distribution_config["origin"]["connection_timeout"])
          domain_name                      = y["domain_name"]
          origin_access_control_id         = contains(regexall("s3.amazonaws.com", zipmap(y[*]["origin_id"], y[*]["domain_name"])[x["default_cache_behavior"]["target_origin_id"]]), "s3.amazonaws.com") ? coalesce(y["origin_access_control_id"], aws_cloudfront_origin_access_control.oac[x["id"]].id) : null
          origin_id                        = y["origin_id"]
          origin_path                      = y["origin_path"]
          origin_shield = {
            enabled                     = y["origin_shield"]["enabled"]
            origin_shield_region        = y["origin_shield"]["origin_shield_region"]
          }
          s3_origin_config = {
            origin_access_identity        = y["s3_origin_config"]["origin_access_identity"]
          }
        }
      ]

      origin_group = [ for y in x["origin_group"]:
        {
          origin_id = y["origin_id"]
          failover_criteria = {
            status_codes = y["failover_criteria"]["status_code"]
          }
          member = [ for z in y["member"]:
            {
              origin_id = z["origin_id"]
            }
          ]
        }
      ]

      price_class             = coalesce(x["price_class"], local.default_cloudfront_distribution_config["price_class"])
      retain_on_delete        = coalesce(x["retain_on_delete"], local.default_cloudfront_distribution_config["retain_on_delete"])
      
      restrictions = {
        geo_restriction = {
          restriction_type        = coalesce(x["restrictions"]["geo_restriction"]["restriction_type"], local.default_cloudfront_distribution_config["restrictions"]["geo_restriction"]["restriction_type"])
          locations               = x["restrictions"]["geo_restriction"]["locations"]
        }
      }

      viewer_certificate = {
          acm_certificate_arn                   = x["viewer_certificate"]["acm_certificate_arn"]
          cloudfront_default_certificate        = coalesce( x["viewer_certificate"]["cloudfront_default_certificate"], local.default_cloudfront_distribution_config["viewer_certificate"]["cloudfront_default_certificate"])
          iam_certificate_id                    = x["viewer_certificate"]["iam_certificate_id"]
          minimum_protocol_version              = x["viewer_certificate"]["cloudfront_default_certificate"] == false ? coalesce(x["viewer_certificate"]["minimum_protocol_version"], local.default_cloudfront_distribution_config["viewer_certificate"]["minimum_protocol_version"]) : null
          ssl_support_method                    = coalesce(x["viewer_certificate"]["ssl_support_method"], local.default_cloudfront_distribution_config["viewer_certificate"]["ssl_support_method"] )
      }      

      wait_for_deployment        = coalesce(x["wait_for_deployment"], local.default_cloudfront_distribution_config["wait_for_deployment"])
      web_acl_id                 = x["web_acl_id"]
    }
  ]

}



output "teste" {
  value = local.cloudfront_distribution_config[*]["ordered_cache_behavior"]

#value = flatten([ 
#  for x in var.cloudfront_distribution_config:
#    [ for z in x["ordered_cache_behavior"]: 
#      merge(z, { "distribution_id": x["id"]}) if z["origin_request_policy"]["name"] != null
#    ]
#])

#value = [ for x in var.cloudfront_distribution_config:
  #{ for v in x["ordered_cache_behavior"]: 
  #  format("%s-%s-%s", x["id"], v["path_pattern"], v["target_origin_id"]) => v["origin_request_policy"]
  #}
#]

#{ for k,v in zipmap(var.cloudfront_distribution_config[*]["ordered_cache_behavior"][*]["path_pattern"], var.cloudfront_distribution_config[*]["ordered_cache_behavior"][*]["target_origin_id"]):
 # k => v
  #{ for y,z in zipmap(x["ordered_cache_behavior"][*]["path_pattern"], x["ordered_cache_behavior"]):
  #   format("%s-%s", x["id"], z["path_pattern"]) => "a"
  #}
#}

  #value = [ for k,v in zipmap(var.cloudfront_distribution_config[*]["id"] ,var.cloudfront_distribution_config):
  # { for y,z in v["ordered_cache_behavior"]:
  #   k => z["origin_request_policy"] if z["origin_request_policy"]["name"] != null
  # }
  #]
}