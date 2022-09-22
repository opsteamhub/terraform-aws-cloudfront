module "opsteam-testecase-01-cloudfront-s3origin-cachepolicy" {
  source = "/Users/brunopaiuca/projects/opsteam/terraform-modules/terraform-aws-cloudfront"
  cloudfront_distribution_config = [
    #{
    #  id = "dfdsfsdfs"
    #  default_cache_behavior = {
    #    target_origin_id = "sc02344jrowf98d"
    #    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    #  }
    #  enabled = false
    #  origin = [
    #    {
    #      domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #      origin_id                = "sc02344jrowf98d"
    #    },
    #  ]
    #},
    #{
    #  id = "fsdf3dfsd42d"
    #  default_cache_behavior = {
    #    target_origin_id = "4rwfe932nf9d"
    #  }
    #  enabled = false
    #  origin = [
    #    {
    #      domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #      origin_id                = "4rwfe932nf9d"
    #    },
    #  ]
    #},
    #{
    #  id = "3mdfw9h49dsf"
    #  default_cache_behavior = {
    #    target_origin_id = "4roded0cn5posyn6234c"
    #  }
    #  enabled = false
    #  ordered_cache_behavior = [
    #    {
    #      target_origin_id = "4roded0cn5posyn6234c"
    #      path_pattern = "/teste"
    #    }
    #  ]
    #  origin = [
    #    {
    #      domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #      origin_id                = "4roded0cn5posyn6234c"
    #    },
    #  ]
    #},
    #{
    #  id = "5nidsh297df8j4mnbqw"
    #  default_cache_behavior = {
    #    target_origin_id = "mfds9hr2n9hfdskas73765h"
    #  }
    #  enabled = false
    #  ordered_cache_behavior = [
    #    {
    #      cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    #      path_pattern     = "/teste2"
    #      target_origin_id = "mfds9hr2n9hfdskas73765h"
    #    }
    #  ]
    #  origin = [
    #    {
    #      domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #      origin_id                = "mfds9hr2n9hfdskas73765h"
    #    },
    #  ]
    #},
    #{
    #  id = "48kf93nvdr043mjas"
    #  default_cache_behavior = {
    #    target_origin_id = "i567odsht12no09p"
    #  }
    #  enabled = false
    #  ordered_cache_behavior = [
    #    {
    #      cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    #      path_pattern     = "/teste3"
    #      target_origin_id = "i567odsht12no09p"
    #    }
    #  ]
    #  origin = [
    #    {
    #      domain_name              = "uol.com.br"
    #      origin_id                = "i567odsht12no09p"
    #    },
    #  ]
    #},
    #{
    #  id = "jhnds932noas8nd52jk"
    #  default_cache_behavior = {
    #    target_origin_id = "ernvns794moasfwe"
    #  }
    #  enabled = false
    #  ordered_cache_behavior = [
    #    {
    #      path_pattern     = "/teste3"
    #      target_origin_id = "ernvns794moasfwe"
    #    }
    #  ]
    #  origin = [
    #    {
    #      domain_name              = "uol.com.br"
    #      origin_id                = "ernvns794moasfwe"
    #    },
    #  ]
    #},
    {
      id = "bmsd8n3rn9dfh"
      default_cache_behavior = {
        target_origin_id = "a934thertret"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          path_pattern     = "/teste"
          target_origin_id = "a934thertret"
          origin_request_policy = {
            id = "59781a5b-3903-41f3-afcb-af62929ccde1"
          }
        },
        {
          path_pattern     = "/teste2"
          target_origin_id = "a934thertret"
          origin_request_policy = {
            id = "59781a5b-3903-41f3-afcb-af62929ccde1"
          }
        }
      ]
      origin = [
        {
          domain_name              = "terra.com.br"
          origin_id                = "a934thertret"
        },
      ]
    },
    {
      id = "dmfds9meads8n4"
      default_cache_behavior = {
        target_origin_id = "4rms9n23n09nc6"
      }
      enabled = false
      ordered_cache_behavior = [
        {
          path_pattern     = "/teste*"
          target_origin_id = "4rms9n23n09nc6"
          origin_request_policy = {      
            name    = "cookiestest"
            comment = "cookies test"
            cookies_config = {
              cookie_behavior = "whitelist"
              cookies = {
                items = ["example"]
              }
            }
          }
        },
        #{
        #  path_pattern     = "/teste2"
        #  target_origin_id = "4rms9n23n09nc6"
        #  origin_request_policy = {      
        #    name    = "headers test"
        #    comment = "headers test"
        #    headers_config = {
        #      header_behavior = "whitelist"
        #      headers = {
        #        items = ["example"]
        #      }
        #    }
        #  }
        #},
        #{
        #  path_pattern     = "/teste3"
        #  target_origin_id = "4rms9n23n09nc6"
        #  origin_request_policy = {      
        #    name    = "query_strings test"
        #    comment = "query_strings test"
        #    query_strings_config = {
        #      query_string_behavior = "whitelist"
        #      query_strings = {
        #        items = ["example"]
        #      }
        #    }
        #  }
        #},
      ]
      origin = [
        {
          domain_name              = "r7.com.br"
          origin_id                = "4rms9n23n09nc6"
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

