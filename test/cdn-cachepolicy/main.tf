module "opsteam-testecase-01-cloudfront-s3origin-cachepolicy" {
  source = "../.././"
  cloudfront_distribution_config = [
    {
      id = "f98n3-cdn-s3-origin-defaultbehavior_withoutcachepolicy"
      default_cache_behavior = {
        target_origin_id = "5553472939"
      }
      enabled = false
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "5553472939"
        },
      ]
    },
    #######################################################################################
    {
      id = "jhnds-cdn-regular-origin-defaultbehavior_withoutcachepolicy"
      default_cache_behavior = {
        target_origin_id = "ernvns794moasfwe"
      }
      enabled = false
      origin = [
        {
          domain_name = "google.com"
          origin_id   = "ernvns794moasfwe"
        },
      ]
    },
    #######################################################################################
    {
      id = "mfd7j3-cdn-s3-origin-with_orderedbehavior_withoutcachepolicy"
      default_cache_behavior = {
        target_origin_id = "0837420973"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          path_pattern     = "/test_orderedbehavior_withoutcachepolicy"
          target_origin_id = "0837420973"
        }
      ]
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "0837420973"
        },
      ]
    },
    #######################################################################################    
    {
      id = "cnsdnf023nfd_cdn_regular_backed_defaultcachepolicy"
      default_cache_behavior = {
        cache_policy = {
          id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        }
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name = "google.com"
          origin_id   = "4rwfe932nf9d"
        },
      ]
    },
    #######################################################################################
    {
      id = "jhnds-cdn-regular-origin-with_orderedbehavior_withoutcachepolicy"
      default_cache_behavior = {
        target_origin_id = "ernvns794moasfwe"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          path_pattern     = "/test_orderedbehavior_withoutcachepolicy"
          target_origin_id = "ernvns794moasfwe"
        }
      ]
      origin = [
        {
          domain_name = "google.com"
          origin_id   = "ernvns794moasfwe"
        },
      ]
    },


    #######################################################################################
    {
      id = "fsdf3dfsd42d_cdn_s3_backed_cachepolicy"
      default_cache_behavior = {
        cache_policy = {
          id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        }
        target_origin_id = "4rwfe932nf9d"
      }
      enabled = false
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "4rwfe932nf9d"
        },
      ]
    },
    #######################################################################################
    {
      id = "njds8i2nifd_cdn_s3_backed_customcachepolicy_any_whitelist"
      default_cache_behavior = {
        cache_policy = {
          name = "custom_cachepolicy_any_whitelist"
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
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "4rwfe932nf9d"
        },
      ]
    },
    #######################################################################################
    {
      id = "njds8i2nifd_cdn_s3_backed_customcachepolicy_any_all"
      default_cache_behavior = {
        cache_policy = {
          name = "custom_cachepolicy_any_all"
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
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "4rwfe932nf9d"
        },
      ]
    },
    #######################################################################################
    {
      id = "njds_cdn_s3_backed_customcachepolicy_querystring_allexcept"
      default_cache_behavior = {
        cache_policy = {
          name = "custom_cachepolicy_querystring_allexcept"
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
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "4rwfe932nf9d"
        },
      ]
    },
    #######################################################################################
    {
      id = "5nidsh297_cdn_s3_backed_with_orderbehavior_with_cachepolicyid"
      default_cache_behavior = {
        target_origin_id = "mfds9hr2n9hfdskas73765h"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
            id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/orderbehavior_with_cachepolicyid"
          target_origin_id = "mfds9hr2n9hfdskas73765h"
        }
      ]
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "mfds9hr2n9hfdskas73765h"
        },
      ]
    },
    #######################################################################################
    {
      id = "48kf9s-cdn-regular-origin-with_orderedbehavior_cachepolicy"
      default_cache_behavior = {
        target_origin_id = "i567odsht12no09p"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          cache_policy = {
            id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
          }
          path_pattern     = "/orderedbehavior_cachepolicy"
          target_origin_id = "i567odsht12no09p"
        }
      ]
      origin = [
        {
          domain_name = "google.com"
          origin_id   = "i567odsht12no09p"
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