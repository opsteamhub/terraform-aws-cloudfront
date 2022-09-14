variable "cloudfront_distribution_config" {
  description = "Variable to define Cloud Front Distribution configs" 
  type = list(
    object(
      {
        id             = string
        aliases        = optional(set(string))
        comment        = optional(string)

        custom_error_response = optional(
          set(
            object(
              {
                error_caching_min_ttl        = optional(number)
                error_code                   = optional(number)
                response_code                = optional(number)
                response_page_path           = optional(string)
              }
            )
          )
        )

        default_cache_behavior = optional(
          object(
            {
              allowed_methods                  = optional(set(string))
              cached_methods                   = optional(set(string))
              cache_policy_id                  = optional(string)
              compress                         = optional(bool)
              default_ttl                      = optional(number)
              field_level_encryption_id        = optional(string)             
              forwarded_values                 = optional(
                object(
                  {
                    cookies = optional(
                      object(
                        {
                          forward                  = optional(string)
                          whitelisted_names        = optional(set(string))
                        }
                      )
                    )
                    headers                        = optional(set(string))
                    query_string                   = optional(bool)
                    query_string_cache_keys        = optional(set(string))
                  }
                )
              )
              function_association = optional(
                set(
                  object(
                    {
                      event_type    = optional(string)
                      function_arn  = optional(string)
                    }
                  )
                )
              )
              lambda_function_association = optional(
                set(
                  object(
                    {
                      event_type          = optional(string)
                      lambda_arn          = optional(string)
                      include_body        = optional(string)
                    }
                  )
                )
              )
              max_ttl                        = optional(number)
              min_ttl                        = optional(number)
              origin_request_policy_id       = optional(string)           
              #realtime_log_config_arn        = optional(string)   
              #response_headers_policy_id     = optional(string)              
              smooth_streaming               = optional(string)
              target_origin_id               = optional(string)
              #trusted_key_groups             = optional(string)
              #trusted_signers                = optional(string)
              viewer_protocol_policy         = optional(string)
            }
          )
        )

        default_root_object        = optional(string)
        enabled                    = optional(string)
        is_ipv6_enabled            = optional(bool)
        http_version               = optional(string)
        
        logging_config = optional(
          object(
            {
              bucket                 = optional(string)
              include_cookies        = optional(string)
              prefix                 = optional(string)
            }
          )
        )

        ordered_cache_behavior = optional(
          set(
            object(
              {
                allowed_methods                  = optional(set(string))
                cached_methods                   = optional(set(string))
                cache_policy_id                  = optional(string)
                compress                         = optional(bool)
                default_ttl                      = optional(number)
                field_level_encryption_id        = optional(string)             
                forwarded_values                 = optional(
                  object(
                    {
                      cookies = optional(
                        object(
                          {
                            forward                  = optional(string)
                            whitelisted_names        = optional(set(string))
                          }
                        )
                      )
                      headers                        = optional(set(string))
                      query_string                   = optional(bool)
                      query_string_cache_keys        = optional(set(string))
                    }
                  )
                )
                function_association = optional(
                  set(
                    object(
                      {
                        event_type    = optional(string)
                        function_arn  = optional(string)
                      }
                    )
                  )
                )
                lambda_function_association = optional(
                  set(
                    object(
                      {
                        event_type          = optional(string)
                        lambda_arn          = optional(string)
                        include_body        = optional(string)
                      }
                    )
                  )
                )
                max_ttl                        = optional(number)
                min_ttl                        = optional(number)
                origin_request_policy_id       = optional(string)           
                path_pattern                   = optional(string)
                #realtime_log_config_arn        = optional(string)   
                #response_headers_policy_id     = optional(string)              
                smooth_streaming               = optional(string)
                target_origin_id               = optional(string)
                #trusted_key_groups             = optional(string)
                #trusted_signers                = optional(string)
                viewer_protocol_policy         = optional(string)
              }
            )
          )
        )

        origin = optional(
          set(
            object(
              {
                connection_attempts      = optional(string)
                connection_timeout       = optional(string)
                custom_origin_config = optional(
                  object(
                    {
                      http_port                       = optional(number)
                      https_port                      = optional(number)
                      origin_protocol_policy          = optional(string)
                      origin_ssl_protocols            = optional(set(string))
                      origin_keepalive_timeout        = optional(number)
                      origin_read_timeout             = optional(number)
                    }
                  )
                )
                domain_name                     = string
                custom_header                   = optional(
                  list(
                    object(
                      {
                        name  = optional(string)
                        value = optional(string)
                      }
                    )
                  )
                )
                origin_access_control_id        = optional(string)
                origin_id                       = string
                origin_path                     = optional(string)
                origin_shield = optional(
                  object(
                    {
                      enabled                = optional(string)
                      origin_shield_region   = optional(string)
                    }
                  )
                )
                s3_origin_config = optional(
                  object(
                    {
                      origin_access_identity = optional(string)
                    }
                  )
                )
              }
            )
          )
        )

        origin_group = optional(
          set(
            object(
              {
                origin_id = optional(string)
                failover_criteria = optional(
                  object( 
                    {
                      status_codes = optional(set(string))
                    }
                  )
                )
                member = optional(
                  set(
                    object(
                      {
                        origin_id = optional(string)
                      }
                    )
                  )
                )
              }
            )
          )
        )

        price_class         = optional(string)
        restrictions        = optional(object({
          geo_restriction = optional(
            object(
              {
                restriction_type        = optional(string)
                locations               = optional(set(string))
              }
            )
          )
        }))
        retain_on_delete          = optional(string)
        viewer_certificate = optional(
          object(
              {
                acm_certificate_arn                   = optional(string)
                cloudfront_default_certificate        = optional(string)
                iam_certificate_id                    = optional(string)
                minimum_protocol_version              = optional(string)
                ssl_support_method                    = optional(string)
              }
          )
        )
        wait_for_deployment        = optional(string)
        web_acl_id                 = optional(string)
      }
    )
  )
}
