locals {

  cloudfront_distribution_config_normalized = [for x in var.cloudfront_distribution_config :
    {
      id      = x["id"]
      aliases = try(x["aliases"], null)
      comment = try(x["comment"], null)

      custom_error_response = [for y in coalesce(x["custom_error_response"], []) :
        {
          error_caching_min_ttl = try(y["error_caching_min_ttl"], null)
          error_code            = try(y["error_code"], null)
          response_code         = try(y["response_code"], null)
          response_page_path    = try(y["response_page_path"], null)
        }
      ]

      default_root_object = try(x["default_root_object"], null)
      enabled             = try(x["enabled"], null)
      is_ipv6_enabled     = try(x["is_ipv6_enabled"], null)
      http_version        = try(x["http_version"], null)

      logging_config = {
        bucket          = try(x["logging_config"]["bucket"], null)
        include_cookies = try(x["logging_config"]["include_cookies"], null)
        prefix          = try(x["logging_config"]["prefix"], null)
      }

      default_cache_behavior = {
        allowed_methods = try(x["default_cache_behavior"]["allowed_methods"], null)
        cached_methods  = try(x["default_cache_behavior"]["cached_methods"], null)
        cache_policy = {
          name        = try(x["default_cache_behavior"]["cache_policy"]["name"], null)
          comment     = try(x["default_cache_behavior"]["cache_policy"]["comment"], null)
          default_ttl = try(x["default_cache_behavior"]["cache_policy"]["default_ttl"], null)
          id          = try(x["default_cache_behavior"]["cache_policy"]["id"], null)
          max_ttl     = try(x["default_cache_behavior"]["cache_policy"]["max_ttl"], null)
          min_ttl     = try(x["default_cache_behavior"]["cache_policy"]["min_ttl"], null)
          parameters_in_cache_key_and_forwarded_to_origin = {
            cookies_config = {
              cookie_behavior = try(x["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"], null)
              cookies = {
                items = try(x["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookies"]["items"], null)
              }
            }
            headers_config = {
              header_behavior = try(x["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"], null)
              headers = {
                items = try(x["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["headers"]["items"], null)
              }
            }
            query_strings_config = {
              query_string_behavior = try(x["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"], null)
              query_strings = {
                items = try(x["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_strings"]["items"], null)
              }
            }
          }
        }
        compress                  = try(x["default_cache_behavior"]["compress"], null)
        default_ttl               = try(x["default_cache_behavior"]["default_ttl"], null)
        field_level_encryption_id = try(x["default_cache_behavior"]["field_level_encryption_id"], null)
        forwarded_values = {
          cookies                 = try(x["default_cache_behavior"]["forwarded_values"]["cookies"], null)
          headers                 = try(x["default_cache_behavior"]["forwarded_values"]["headers"], null)
          query_string            = try(x["default_cache_behavior"]["forwarded_values"]["query_string"], null)
          query_string_cache_keys = try(x["default_cache_behavior"]["forwarded_values"]["query_string_cache_keys"], null)
        }
        function_association = [for y in coalesce(x["default_cache_behavior"]["function_association"], []) :
          {
            event_type   = try(y["event_type"], null)
            function_arn = try(y["function_arn"], null)
          }
        ]
        lambda_function_association = [for y in coalesce(x["default_cache_behavior"]["lambda_function_association"], []) :
          {
            event_type   = try(y["event_type"], null)
            lambda_arn   = try(y["lambda_arn"], null)
            include_body = try(y["include_body"], null)
          }
        ]
        max_ttl = try(x["default_cache_behavior"]["max_ttl"], null)
        min_ttl = try(x["default_cache_behavior"]["min_ttl"], null)
        origin_request_policy = {
          id      = try(x["default_cache_behavior"]["origin_request_policy"]["id"], null)
          comment = try(x["default_cache_behavior"]["origin_request_policy"]["comment"], null)
          cookies_config = {
            cookie_behavior = try(x["default_cache_behavior"]["origin_request_policy"]["cookies_config"]["cookie_behavior"], null)
            cookies = {
              items = try(x["default_cache_behavior"]["origin_request_policy"]["cookies_config"]["cookies"]["items"], null)
            }
          }
          headers_config = {
            header_behavior = try(x["default_cache_behavior"]["origin_request_policy"]["headers_config"]["header_behavior"], null)
            headers = {
              items = try(x["default_cache_behavior"]["origin_request_policy"]["header_behavior"]["headers"]["items"], null)
            }
          }
          query_strings_config = {
            query_string_behavior = try(x["default_cache_behavior"]["origin_request_policy"]["query_strings_config"]["query_string_behavior"], null)
            query_strings = {
              items = try(x["default_cache_behavior"]["origin_request_policy"]["query_strings_config"]["query_strings"]["items"], null)
            }
          }
        }
        #realtime_log_config_arn        =
        response_headers_policy = {
          comment = try(
            x["default_cache_behavior"]["response_headers_policy"]["comments"],
            null
          )
          cors_config = {
            access_control_allow_credentials = try(
              x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_credentials"],
              null
            )
            access_control_allow_headers = {
              items = try(
                x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_headers"]["items"],
                null
              )
            }
            access_control_allow_methods = {
              items = try(
                x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_methods"]["items"],
                null
              )
            }
            access_control_allow_origins = {
              items = try(
                x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_origins"]["items"],
                null
              )
            }
            access_control_expose_headers = {
              items = try(
                x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_expose_headers"]["items"],
                null
              )
            }
            access_control_max_age_sec = try(
              x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_max_age_sec"],
              null
            )
            origin_override = try(
              x["default_cache_behavior"]["response_headers_policy"]["cors_config"]["origin_override"],
              null
            )
          }
          custom_headers_config = [ for z in coalesce(try(x["default_cache_behavior"]["response_headers_policy"]["custom_headers_config"], null), []):
            {
              header = try(
                z["header"],
                null
              )
              override = try(
                z["override"],
                null
              )
              value = try(
                z["value"],
                null
              )
            }
          ]
          id = try(
            x["default_cache_behavior"]["response_headers_policy"]["id"],
            null
          )
          security_headers_config = {
            content_security_policy = {
              content_security_policy = try(
                x["default_cache_behavior"]["response_headers_policy"]["security_headers_config"]["content_security_policy"]["content_security_policy"],
                null
              ) 
              override = try(
                x["default_cache_behavior"]["response_headers_policy"]["security_headers_config"]["content_security_policy"]["override"],
                null
              )
            }
            content_type_options = {
              override = try(
                x["default_cache_behavior"]["response_headers_policy"]["content_type_options"]["override"],
                null
              )
            }
            frame_options = {
              frame_option = try(
                x["default_cache_behavior"]["response_headers_policy"]["frame_options"]["frame_options"],
                null
              )
              override = try(
                x["default_cache_behavior"]["response_headers_policy"]["frame_options"]["override"],
                null
              )
            }
            referrer_policy = {
              referrer_policy = try(
                x["default_cache_behavior"]["response_headers_policy"]["referrer_policy"]["referrer_policy"],
                null
              )
              override        = try(
                x["default_cache_behavior"]["response_headers_policy"]["referrer_policy"]["override"],
                null
              )
            }
            strict_transport_security = {
              access_control_max_age_sec = try(
                x["default_cache_behavior"]["response_headers_policy"]["strict_transport_security"]["access_control_max_age_sec"],
                null
              )
              include_subdomains         = try(
                x["default_cache_behavior"]["response_headers_policy"]["strict_transport_security"]["include_subdomains"],
                null
              )
              override                   = try(
                x["default_cache_behavior"]["response_headers_policy"]["strict_transport_security"]["override"],
                null
              )
              preload                    = try(
                x["default_cache_behavior"]["response_headers_policy"]["strict_transport_security"]["preload"],
                null
              )
            }
            xss_protection = {
              mode_block = try(
                x["default_cache_behavior"]["response_headers_policy"]["xss_protection"]["mode_block"],
                null
              )
              override   = try(
                x["default_cache_behavior"]["response_headers_policy"]["xss_protection"]["override"],
                null
              )
              protection = try(
                x["default_cache_behavior"]["response_headers_policy"]["xss_protection"]["protection"],
                null
              )
              report_uri = try(
                x["default_cache_behavior"]["response_headers_policy"]["xss_protection"]["report_uri"],
                null
              )
            }
          }
          server_timing_headers_config = {
            enabled = try(
              x["default_cache_behavior"]["response_headers_policy"]["server_timing_headers_config"]["enabled"],
              null
            )
            sampling_rate = try(
              x["default_cache_behavior"]["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"],
              null
            )
          }
        }
        smooth_streaming = try(x["default_cache_behavior"]["smooth_streaming"], null)
        target_origin_id = x["default_cache_behavior"]["target_origin_id"]
        #trusted_key_groups             = 
        #trusted_signers                = 
        viewer_protocol_policy = try(
          x["default_cache_behavior"]["viewer_protocol_policy"],
          null
        )
      }

      ordered_cache_behavior = [for z in coalesce(x["ordered_cache_behavior"], []) :
        {
          allowed_methods = try(z["allowed_methods"], null)
          cached_methods  = try(z["cached_methods"], null)

          cache_policy = {
            name        = try(z["cache_policy"]["name"], null)
            comment     = try(z["cache_policy"]["comment"], null)
            default_ttl = try(z["cache_policy"]["default_ttl"], null)
            id          = try(z["cache_policy"]["id"], null)
            max_ttl     = try(z["cache_policy"]["max_ttl"], null)
            min_ttl     = try(z["cache_policy"]["min_ttl"], null)
            parameters_in_cache_key_and_forwarded_to_origin = {
              cookies_config = {
                cookie_behavior = try(z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"], null)
                cookies = {
                  items = try(z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookies"]["items"], null)
                }
              }
              headers_config = {
                header_behavior = try(z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"], null)
                headers = {
                  items = try(z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["headers"]["items"], null)
                }
              }
              query_strings_config = {
                query_string_behavior = try(z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"], null)
                query_strings = {
                  items = try(z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_strings"]["items"], null)
                }
              }
            }
          }
          compress                  = try(z["compress"], null)
          default_ttl               = try(z["default_ttl"], null)
          field_level_encryption_id = try(z["field_level_encryption_id"], null)
          forwarded_values = {
            cookies                 = try(z["forwarded_values"]["cookies"], null)
            headers                 = try(z["forwarded_values"]["headers"], null)
            query_string            = try(z["forwarded_values"]["query_string"], null)
            query_string_cache_keys = try(z["forwarded_values"]["query_string_cache_keys"], null)
          }
          function_association = [for y in coalesce(z["function_association"], []) :
            {
              event_type   = try(y["event_type"], null)
              function_arn = try(y["function_arn"], null)
            }
          ]
          lambda_function_association = [for y in coalesce(z["lambda_function_association"], []) :
            {
              event_type   = try(y["event_type"], null)
              lambda_arn   = try(y["lambda_arn"], null)
              include_body = try(y["include_body"], null)
            }
          ]
          max_ttl = try(z["max_ttl"], null)
          min_ttl = try(z["min_ttl"], null)
          origin_request_policy = {
            id      = try(z["origin_request_policy"]["id"], null)
            comment = try(z["origin_request_policy"]["comment"], null)
            cookies_config = {
              cookie_behavior = try(z["origin_request_policy"]["cookies_config"]["cookie_behavior"], null)
              cookies = {
                items = try(z["origin_request_policy"]["cookies_config"]["cookies"]["items"], null)
              }
            }
            headers_config = {
              header_behavior = try(z["origin_request_policy"]["headers_config"]["header_behavior"], null)
              headers = {
                items = try(z["origin_request_policy"]["header_behavior"]["headers"]["items"], null)
              }
            }
            query_strings_config = {
              query_string_behavior = try(z["origin_request_policy"]["query_strings_config"]["query_string_behavior"], null)
              query_strings = {
                items = try(z["origin_request_policy"]["query_strings_config"]["query_strings"]["items"], null)
              }
            }
          }
          path_pattern = try(z["path_pattern"], null)
          #realtime_log_config_arn        =    
          response_headers_policy = {
            comment = try(
              z["response_headers_policy"]["comments"],
              null
            )
            cors_config = {
              access_control_allow_credentials = try(
                z["response_headers_policy"]["cors_config"]["access_control_allow_credentials"],
                null
              )
              access_control_allow_headers = {
                items = try(
                  z["response_headers_policy"]["cors_config"]["access_control_allow_headers"]["items"],
                  null
                )
              }
              access_control_allow_methods = {
                items = try(
                  z["response_headers_policy"]["cors_config"]["access_control_allow_methods"]["items"],
                  null
                )
              }
              access_control_allow_origins = {
                items = try(
                  z["response_headers_policy"]["cors_config"]["access_control_allow_origins"]["items"],
                  null
                )
              }
              access_control_expose_headers = {
                items = try(
                  z["response_headers_policy"]["cors_config"]["access_control_expose_headers"]["items"],
                  null
                )
              }
              access_control_max_age_sec = try(
                z["response_headers_policy"]["cors_config"]["access_control_max_age_sec"],
                null
              )
              origin_override = try(
                z["response_headers_policy"]["cors_config"]["origin_override"],
                null
              )
            }
            custom_headers_config = [ for w in coalesce(try(z["response_headers_policy"]["custom_headers_config"], null), []):
              {
                header = try(
                  w["header"],
                  null
                )
                override = try(
                  w["override"],
                  null
                )
                value = try(
                  w["value"],
                  null
                )
              }
            ]
            id = try(
              z["response_headers_policy"]["id"],
              null
            )
            security_headers_config = {
              content_security_policy = {
                content_security_policy = try(
                  z["response_headers_policy"]["security_headers_config"]["content_security_policy"]["content_security_policy"],
                  null
                ) 
                override = try(
                  z["response_headers_policy"]["security_headers_config"]["content_security_policy"]["override"],
                  null
                )
              }
              content_type_options = {
                override = try(
                  z["response_headers_policy"]["content_type_options"]["override"],
                  null
                )
              }
              frame_options = {
                frame_option = try(
                  z["response_headers_policy"]["frame_options"]["frame_options"],
                  null
                )
                override = try(
                  z["response_headers_policy"]["frame_options"]["override"],
                  null
                )
              }
              referrer_policy = {
                referrer_policy = try(
                  z["response_headers_policy"]["referrer_policy"]["referrer_policy"],
                  null
                )
                override        = try(
                  z["response_headers_policy"]["referrer_policy"]["override"],
                  null
                )
              }
              strict_transport_security = {
                access_control_max_age_sec = try(
                  z["response_headers_policy"]["strict_transport_security"]["access_control_max_age_sec"],
                  null
                )
                include_subdomains         = try(
                  z["response_headers_policy"]["strict_transport_security"]["include_subdomains"],
                  null
                )
                override                   = try(
                  z["response_headers_policy"]["strict_transport_security"]["override"],
                  null
                )
                preload                    = try(
                  z["response_headers_policy"]["strict_transport_security"]["preload"],
                  null
                )
              }
              xss_protection = {
                mode_block = try(
                  z["response_headers_policy"]["xss_protection"]["mode_block"],
                  null
                )
                override   = try(
                  z["response_headers_policy"]["xss_protection"]["override"],
                  null
                )
                protection = try(
                  z["response_headers_policy"]["xss_protection"]["protection"],
                  null
                )
                report_uri = try(
                  z["response_headers_policy"]["xss_protection"]["report_uri"],
                  null
                )
              }
            }
            server_timing_headers_config = {
              enabled = try(
                z["response_headers_policy"]["server_timing_headers_config"]["enabled"],
                null
              )
              sampling_rate = try(
                z["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"],
                null
              )
            }
          }          
          smooth_streaming = try(z["smooth_streaming"], null)
          target_origin_id = z["target_origin_id"]
          #trusted_key_groups             = 
          #trusted_signers                = 
          viewer_protocol_policy = try(z["viewer_protocol_policy"], null)
        }
      ]

      origin = [for y in coalesce(x["origin"], []) :
        {
          connection_attempts = try(y["connection_attempts"], null)
          custom_header       = try(y["custom_header"], null)
          custom_origin_config = {
            http_port                = try(y["custom_origin_config"]["http_port"], null)
            https_port               = try(y["custom_origin_config"]["https_port"], null)
            origin_protocol_policy   = try(y["custom_origin_config"]["origin_protocol_policy"], null)
            origin_ssl_protocols     = try(y["custom_origin_config"]["origin_ssl_protocols"], null)
            origin_keepalive_timeout = try(y["custom_origin_config"]["origin_keepalive_timeout"], null)
            origin_read_timeout      = try(y["custom_origin_config"]["origin_read_timeout"], null)
          }
          connection_timeout       = try(y["connection_timeout"], null)
          domain_name              = y["domain_name"]
          origin_access_control_id = try(y["origin_access_control_id"], null)
          origin_id                = y["origin_id"]
          origin_path              = try(y["origin_path"], null)
          origin_shield = {
            enabled              = try(y["origin_shield"]["enabled"], null)
            origin_shield_region = try(y["origin_shield"]["origin_shield_region"], null)
          }
          s3_origin_config = {
            origin_access_identity = try(y["s3_origin_config"]["origin_access_identity"], null)
          }
        }
      ]

      origin_group = [for y in coalesce(x["origin_group"], []) :
        {
          origin_id = y["origin_id"]
          failover_criteria = {
            status_codes = y["failover_criteria"]["status_code"]
          }
          member = [for z in y["member"] :
            {
              origin_id = z["origin_id"]
            }
          ]
        }
      ]

      price_class = try(x["price_class"], null)

      restrictions = {
        geo_restriction = {
          restriction_type = try(x["restrictions"]["geo_restriction"]["restriction_type"], null)
          locations        = try(x["restrictions"]["geo_restriction"]["locations"], null)
        }
      }

      retain_on_delete = try(x["retain_on_delete"], null)
      viewer_certificate = {
        acm_certificate_arn            = try(x["viewer_certificate"]["acm_certificate_arn"], null)
        cloudfront_default_certificate = try(x["viewer_certificate"]["cloudfront_default_certificate"], null)
        iam_certificate_id             = try(x["viewer_certificate"]["iam_certificate_id"], null)
        minimum_protocol_version       = try(x["viewer_certificate"]["minimum_protocol_version"], null)
        ssl_support_method             = try(x["viewer_certificate"]["ssl_support_method"], null)

      }

      wait_for_deployment = try(x["wait_for_deployment"], null)
      web_acl_id          = try(x["web_acl_id"], null)
    }
  ]
}