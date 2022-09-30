module "opsteam-testecase-01-cloudfront-s3origin-cachepolicy" {
  source = "/Users/brunopaiuca/projects/opsteam/terraform-modules/terraform-aws-cloudfront"
  cloudfront_distribution_config = [
    {
      id = "fsdf3dfsd42d_cdn_s3_backed_cachepolicy"
      default_cache_behavior = {
        cache_policy = {
          id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        }        
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "4rwfe932nf9d"
        },
      ]
    },
    {
      id = "njds8i2nifd_cdn_s3_backed_customcachepolicy_any_whitelist"
      default_cache_behavior = {
        cache_policy = {
          name  = "custom_cachepolicy_any_whitelist"
          parameters_in_cache_key_and_forwarded_to_origin = {
    
            cookies_config = {
              cookie_behavior = "whitelist"
              cookies = {
                items = ["example"] 
              }
            }
    
            headers_config = {
              header_behavior = "whitelist"
              headers = {
                items = ["example"] 
              }
            }
    
            query_strings_config = {
              query_string_behavior = "whitelist"
              query_strings = {
                items = ["example"] 
              }
            }
          }
        }
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "4rwfe932nf9d"
        },
      ]
    },
    {
      id = "njds8i2nifd_cdn_s3_backed_customcachepolicy_any_all"
      default_cache_behavior = {
        cache_policy = {
          name  = "custom_cachepolicy_any_all"
          parameters_in_cache_key_and_forwarded_to_origin = {
    
            cookies_config = {
              cookie_behavior = "all"
            }
    
            query_strings_config = {
              query_string_behavior = "all"
            }
          }
        }
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "4rwfe932nf9d"
        },
      ]
    },
    {
      id = "njds_cdn_s3_backed_customcachepolicy_querystring_allexcept"
      default_cache_behavior = {
        cache_policy = {
          name  = "custom_cachepolicy_querystring_allexcept"
          parameters_in_cache_key_and_forwarded_to_origin = {
            query_strings_config = {
              query_string_behavior = "allExcept"
              query_strings = {
                items = ["example"] 
              }
            }
          }
        }
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "4rwfe932nf9d"
        },
      ]
    },
    {
      id = "cnsdnf023nfd_cdn_regular_backed_cachepolicy"
      default_cache_behavior = {
        cache_policy = {
          id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        }    
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "4rwfe932nf9d"
        },
      ]
    },
    
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
      id = "8h7bc6d329-cdn-regular-origin-defaultbehavior-customcachepolicy"
      enabled = false
      default_cache_behavior = {
        cache_policy = {
          id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        }
        target_origin_id = "9kfds9j94fdbvc"
        origin_request_policy = {
          id = "59781a5b-3903-41f3-afcb-af62929ccde1"
        }
      }
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "9kfds9j94fdbvc"
        },
      ]
    },
    
    {
      id = "fsdf3dfsd42d_cdn_s3_backed_defaultconfig"
      default_cache_behavior = {
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "4rwfe932nf9d"
        },
      ]
    },
    {
      id = "48kf9s-cdn-regular-origin-defaultconfig"
      default_cache_behavior = {
        target_origin_id = "i567odsht12no09p"
      }
      enabled = false
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "i567odsht12no09p"
        },
      ]
    }, 
    {
      id = "fsd98n3jfds83n_cdn_s3_backed_cachepolicy"
      default_cache_behavior = {
        target_origin_id = "sc02344jrowf98d"
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
      }
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "sc02344jrowf98d"
        },
      ]
    },
    
    {
      id = "3mdfw9h49dsf_cdn_s3_backed_with_ordered_behavior"
      default_cache_behavior = {
        target_origin_id = "4roded0cn5posyn6234c"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          target_origin_id = "4roded0cn5posyn6234c"
          path_pattern = "/teste"
        }
      ]
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "4roded0cn5posyn6234c"
        },
      ]
    },
    {
      id = "5nidsh297_cdn_s3_backed_with_orderbehavior_with_cachepolicyid"
      default_cache_behavior = {
        target_origin_id = "mfds9hr2n9hfdskas73765h"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
           id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/teste2"
          target_origin_id = "mfds9hr2n9hfdskas73765h"
        }
      ]
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "mfds9hr2n9hfdskas73765h"
        },
      ]
    },
    {
      id = "48kf9s-cdn-regular-origin-with_orderedbehavior_cachepolicy"
      default_cache_behavior = {
        target_origin_id = "i567odsht12no09p"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = { 
            id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/teste3"
          target_origin_id = "i567odsht12no09p"
        }
      ]
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "i567odsht12no09p"
        },
      ]
    },
    {
      id = "jhnds-cdn-regular-origin-with_orderedbehavior_withoutcachepolicy"
      default_cache_behavior = {
        target_origin_id = "ernvns794moasfwe"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          path_pattern     = "/teste3"
          target_origin_id = "ernvns794moasfwe"
        }
      ]
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "ernvns794moasfwe"
        },
      ]
    },
    {
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
      id = "8h7bc6d329-cdn-regular-origin-orderedbehavior-customcachepolicy"
      default_cache_behavior = {
        target_origin_id = "9kfds9j94fdbvc"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
            name  = "custom_cachepolicy_querystring_whitelist2"
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
          target_origin_id = "9kfds9j94fdbvc"
          origin_request_policy = {
            id = "59781a5b-3903-41f3-afcb-af62929ccde1"
          }
        }
      ]
      origin = [
        {
          domain_name              = "google.com"
          origin_id                = "9kfds9j94fdbvc"
        },
      ]
    },

  ]
}


output "teste" {
  value = module.opsteam-testecase-01-cloudfront-s3origin-cachepolicy.teste
}
#output "inputvar" {
#  value = module.opsteam-testecase-01-cloudfront-s3origin-cachepolicy.inputvar
#}
#
#output "bucketnames" {
#  value = module.opsteam-testecase-01-cloudfront-s3origin-cachepolicy.bucketnames
#}
#
#output "for_input" {
#  value = module.opsteam-testecase-01-cloudfront-s3origin-cachepolicy.for_input
#}
#
#output "finalconfig" {
#value = module.opsteam-testecase-01-cloudfront-s3origin-cachepolicy.finalconfig
#}

