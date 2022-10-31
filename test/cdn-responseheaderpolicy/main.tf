module "opsteam-testecase-01-cloudfront-s3origin" {
  source = "../.././"
  cloudfront_distribution_config = [
    ############################################################################################################################  
    #  {
    #    id      = "1COm0CBzap-cdn-s3-without-response-header"
    #    enabled = false
    #    default_cache_behavior = {
    #      target_origin_id = "ClkFmFyMqi"
    #    }
    #    origin = [
    #      {
    #        domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #        origin_id                = "ClkFmFyMqi"
    #      },
    #    ]
    #  },
    #  {
    #    id      = "YGeytCjVBf-cdn-reg-without-response-header"
    #    enabled = false
    #    default_cache_behavior = {
    #      target_origin_id = "jMpOEbDWi3"
    #    }
    #    origin = [
    #      {
    #        domain_name              = "gmail.com"
    #        origin_id                = "jMpOEbDWi3"
    #      },
    #    ]
    #  },
    #  {
    #    id      = "FpeQMl1wpb-cdn-s3-orderedbehavior-without-response-header"
    #    enabled = false
    #    default_cache_behavior = {
    #      target_origin_id = "mqeHMU5TTt"
    #    }
    #    ordered_cache_behavior = [
    #      {
    #        cache_policy = {
    #         id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    #        }
    #        path_pattern     = "/orderedbehavior-without-response-header"
    #        target_origin_id = "mqeHMU5TTt"
    #      }
    #    ]
    #    origin = [
    #      {
    #        domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #        origin_id   = "mqeHMU5TTt"
    #      },
    #    ]
    #  },
    #  {
    #    id      = "q5O3VattqU-cdn-reg-orderedbehavior-without-response-header"
    #    enabled = false
    #    default_cache_behavior = {
    #      target_origin_id = "6N1WoIh7ms"
    #    }
    #    ordered_cache_behavior = [
    #      {
    #        cache_policy = {
    #         id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    #        }
    #        path_pattern     = "/orderedbehavior-without-response-header"
    #        target_origin_id = "6N1WoIh7ms"
    #      }
    #    ]
    #    origin = [
    #      {
    #        domain_name              = "gmail.com"
    #        origin_id                = "6N1WoIh7ms"
    #      },
    #    ]
    #  },
    ############################################################################################################################
    #  {
    #    id = "QCL1AFeqAp-cdn-default-response-header"
    #    enabled = false
    #    default_cache_behavior = {
    #      target_origin_id = "pI6lKdeZdI"
    #      response_headers_policy = {
    #        id = "60669652-455b-4ae9-85a4-c4c02393f86c"
    #      }
    #    }
    #    origin = [
    #      {
    #        domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #        origin_id                = "pI6lKdeZdI"
    #      },
    #    ]
    #  },

    #  {
    #    id = "2mgIX4Blw8-orderedcachebehave-default-response-header"
    #    enabled = false
    #    default_cache_behavior = {
    #      target_origin_id = "A18dYFe4bB"
    #    }
    #    origin = [
    #      {
    #        domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    #        origin_id                = "A18dYFe4bB"
    #      },
    #    ]
    #    ordered_cache_behavior = [
    #      {
    #        path_pattern = "/cdn-s3-without-response-header"
    #        response_headers_policy = {
    #          id = "60669652-455b-4ae9-85a4-c4c02393f86c"
    #        }        
    #        target_origin_id = "A18dYFe4bB"
    #      }
    #    ]
    #  },

    ############################################################################################################################
    {
      id      = "Cpx3ZoN3EU-cdn-defaultcachebehave-custom-response-header-cors"
      enabled = false
      default_cache_behavior = {
        response_headers_policy = {
          cors_config = {
            access_control_allow_headers = {
              items = ["test"]
            }
            access_control_allow_origins = {
              items = ["test.example.com"]
            }
          }
        }
        target_origin_id = "2ZoRcAsP8A"
      }
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "2ZoRcAsP8A"
        },
      ]
    },


    ####################################################################################################
    {
      id      = "2mw8-cdn-defaultcachebehave-custom-response-header-servertiming"
      enabled = false
      default_cache_behavior = {
        target_origin_id = "PtH4xSynIh"
        response_headers_policy = {
          server_timing_headers_config = {
            enabled       = true
            sampling_rate = 10
          }
        }
      }
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "PtH4xSynIh"
        },
      ]
    },
    {
      id      = "Y4DN-cdn-defaultcachebehave-custom-response-header-servertiming"
      enabled = false
      default_cache_behavior = {
        target_origin_id = "PtH4xSynIh"
        response_headers_policy = {
          server_timing_headers_config = {
            enabled = true
          }
        }
      }
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "PtH4xSynIh"
        },
      ]
    },
    {
      id      = "1i3sp-cdn-defaultcachebehave-custom-response-header-servertiming"
      enabled = false
      default_cache_behavior = {
        target_origin_id = "PtH4xSynIh"
        response_headers_policy = {
          server_timing_headers_config = {
            sampling_rate = 20
          }
        }
      }
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "PtH4xSynIh"
        },
      ]
    },



    ##########################################################################################################  
    ##    {
    ##      id = "2mgIX4Blw8-cdn-orderedcachebehave-custom-response-header-cors"
    ##      enabled = false
    ##      default_cache_behavior = {
    ##        target_origin_id = "PtH4xSynIh"
    ##      }
    ##      origin = [
    ##        {
    ##          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    ##          origin_id                = "PtH4xSynIh"
    ##        },
    ##      ]
    ##      ordered_cache_behavior = [
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header"
    ##          response_headers_policy = {
    ##            cors_config = {
    ##               access_control_allow_headers = {
    ##                 items = ["test"]
    ##               }
    ##               access_control_allow_origins = {
    ##                 items = ["test.example.com"]
    ##               }              
    ##            }
    ##          }        
    ##          target_origin_id = "PtH4xSynIh"
    ##        },
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header2"
    ##          response_headers_policy = {
    ##            cors_config = {
    ##              access_control_allow_headers = {
    ##                items = ["test"]
    ##              }
    ##              access_control_allow_methods = {
    ##                items = ["GET"]
    ##              }
    ##              access_control_allow_origins = {
    ##                items = ["test.example.com"]
    ##              }
    ##              access_control_expose_headers = {
    ##                items = ["Content-Type"]
    ##              }
    ##              access_control_max_age_sec = 60
    ##              origin_override            = true
    ##            }
    ##          }        
    ##          target_origin_id = "PtH4xSynIh"
    ##        },
    ##      ]
    ##    
    ##    },
    ##
    ##  ##########################################################################################################  
    ##    {
    ##      id = "24mw8-cdn-orderedcachebehave-custom-response-header-customheader"
    ##      enabled = false
    ##      default_cache_behavior = {
    ##        target_origin_id = "GfMWnZfiIP"
    ##      }
    ##      origin = [
    ##        {
    ##          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    ##          origin_id                = "GfMWnZfiIP"
    ##        },
    ##      ]
    ##      ordered_cache_behavior = [
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header-customheader"
    ##          response_headers_policy = {
    ##            custom_headers_config = [
    ##              {
    ##                header   = "X-Permitted-Cross-Domain-Policies"
    ##                override = true
    ##                value    = "none"
    ##              }           
    ##            ]
    ##          }        
    ##          target_origin_id = "GfMWnZfiIP"
    ##        },
    ##      ]
    ##    },
    ##  
    ##  ##########################################################################################################  
    ##    {
    ##      id = "hGW8-cdn-orderedcachebehave-custom-resp-header-securityheader"
    ##      enabled = false
    ##      default_cache_behavior = {
    ##        target_origin_id = "apXVH9KJ7B"
    ##      }
    ##      origin = [
    ##        {
    ##          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    ##          origin_id                = "apXVH9KJ7B"
    ##        },
    ##      ]
    ##      ordered_cache_behavior = [
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header-securityheader-frameoptions"
    ##          response_headers_policy = {
    ##            security_headers_config = {
    ##              frame_options = {
    ##                frame_option = "SAMEORIGIN" 
    ##              }
    ##            }
    ##          }        
    ##          target_origin_id = "apXVH9KJ7B"
    ##        },
    ##      ]
    ##    },
    ##    ####################################################################################################
    ##    {
    ##      id = "2mw8-cdn-orderedcachebehave-custom-response-header-servertiming"
    ##      enabled = false
    ##      default_cache_behavior = {
    ##        target_origin_id = "PtH4xSynIh"
    ##      }
    ##      origin = [
    ##        {
    ##          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
    ##          origin_id                = "PtH4xSynIh"
    ##        },
    ##      ]
    ##      ordered_cache_behavior = [
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header3"
    ##          response_headers_policy = {
    ##            server_timing_headers_config = {
    ##              enabled       = true
    ##              sampling_rate = 10
    ##            }
    ##          }
    ##          target_origin_id = "PtH4xSynIh"
    ##        },
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header5"
    ##          response_headers_policy = {
    ##            server_timing_headers_config = {
    ##              enabled       = true
    ##            }
    ##          }        
    ##          target_origin_id = "PtH4xSynIh"
    ##        },
    ##        {
    ##          path_pattern = "/cdn-s3-custom-response-header6"
    ##          response_headers_policy = {
    ##            server_timing_headers_config = {
    ##              sampling_rate    = 20
    ##            }
    ##          }        
    ##          target_origin_id = "PtH4xSynIh"
    ##        },
    ##      ]
    ##    },
  ]
}


output "teste" {
  value = module.opsteam-testecase-01-cloudfront-s3origin.teste
}
#output "inputvar" {
#  value = module.opsteam-testecase-01-cloudfront-s3origin.inputvar
#}
#
#output "bucketnames" {
#  value = module.opsteam-testecase-01-cloudfront-s3origin.bucketnames
#}
#
#output "for_input" {
#  value = module.opsteam-testecase-01-cloudfront-s3origin.for_input
#}
#
#output "finalconfig" {
#value = module.opsteam-testecase-01-cloudfront-s3origin.finalconfig
#}

