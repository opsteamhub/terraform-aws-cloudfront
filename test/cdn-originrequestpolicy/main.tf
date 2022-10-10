module "opsteam-testecase-01-cloudfront-originreqpolicy-cachepolicy" {
  source = "/Users/brunopaiuca/projects/opsteam/terraform-modules/terraform-aws-cloudfront"
  cloudfront_distribution_config = [
    {
      #
      # CDN to Regular Endpoint Origin using defaults already existants 
      # CachePolicy and OriginRequestPolicy. 
      #  
      id = "bmsd8-cdn-regular-with_origin_req_policy"
      default_cache_behavior = {
        target_origin_id = "a934thertret"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/teste"
          target_origin_id = "a934thertret"
          origin_request_policy = {
            id = "59781a5b-3903-41f3-afcb-af62929ccde1"
          }
        }
      ]
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "a934thertret"
        },
      ]
    },
    #######################################################################################
    {
      id = "dmfds9me-cdn-regular-origin-custom-origin-req-policy-whitelist"
      enabled = false
      default_cache_behavior = {
        cache_policy = {
          id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        }
        target_origin_id = "4rms9n23n09nc6"
        origin_request_policy = {      
          name    = "cookiestest_whitelist"
          comment = "cookies test"
          cookies_config = {
            cookie_behavior = "whitelist"
            cookies = {
              items = ["example"]
            }
          }
        }
      }
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "4rms9n23n09nc6"
        },
      ]
    },
    {
      id = "dmfds9me-cdn-regular-origin-custom-origin-req-policy"
      default_cache_behavior = {
        target_origin_id = "4rms9n23n09nc6"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/cookiestest_whitelist"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "cookiestest_whitelist"
            comment = "cookies test"
            cookies_config = {
              cookie_behavior = "whitelist"
              cookies = {
                items = ["example"]
              }
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/cookiestest_all"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            cookies_config = {
              cookie_behavior = "all"
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/cookiestest_none"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "cookiestest_none"
            comment = "cookies test"
            cookies_config = {
              cookie_behavior = "none"
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/cookietest_default"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "cookiestest_default"
            comment = "cookies test"
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/headerstest_whitelist"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "headerstest_whitelist"
            comment = "headers test"
            headers_config = {
              header_behavior = "whitelist"
              headers = {
                items = ["example"]
              }
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/headerstest_none"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "headerstest_none"
            comment = "headers test"
            headers_config = {
              header_behavior = "none"
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }        
          path_pattern     = "/headertest_allviewer"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "headerstest_allviewer"
            comment = "headers test"
            headers_config = {
              header_behavior = "allViewer"
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/headertest_allviewer_and_whitelist_cfront"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "headertest_allviewer_and_whitelist_cfront"
            comment = "headers test"
            headers_config = {
              header_behavior = "allViewerAndWhitelistCloudFront"
              headers = {
                items = ["CloudFront-Viewer-City"]
              }
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/query_strings_default"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {
            name    = "query_strings_default"
            comment = "query strings test"
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/query_strings_none"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {
            name    = "query_strings_none"
            comment = "query strings test"
            query_strings_config = {
              query_string_behavior = "none"
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/query_strings_all"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {
            name    = "query_strings_all"
            comment = "query strings test"
            query_strings_config = {
              query_string_behavior = "all"
            }
          }
        },
        {
          cache_policy = {
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/query_strings_whitelist"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {
            name    = "query_strings_whitelist"
            comment = "query strings test"
            query_strings_config = {
              query_string_behavior = "whitelist"
              query_strings = {
                items = ["example"]
              }
            }
          }
        },
      ]
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "4rms9n23n09nc6"
        },
      ]
    },
    {
      id = "8hc6-cdn-reg-origin-orderedbehavior-customcachepolicy_whitelist"
      default_cache_behavior = {
        target_origin_id = "7bfsd8nir2"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
            name  = "custom_cachepolicy_querystring_whitelist"
            parameters_in_cache_key_and_forwarded_to_origin = {
              query_strings_config= {
                query_string_behavior = "whitelist"
                query_strings = {
                  items = ["example"] 
                }
              }
            }
          }
          path_pattern     = "/customcachepolicy_querystringwhitelist"
          target_origin_id = "7bfsd8nir2"
          origin_request_policy = {
            id = "59781a5b-3903-41f3-afcb-af62929ccde1"
          }
        }
      ]
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "7bfsd8nir2"
        },
      ]
    },

  ]
}
