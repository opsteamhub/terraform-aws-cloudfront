resource "aws_cloudfront_response_headers_policy" "default_behavior_response_headers_policy" {

  #
  # Generate Map using hash sha1 from a string generated from the the 
  # Terraform CloudFront ID and the Target Origin ID. There is one if 
  # condition checking whether there is at least one of the mandatory 
  # attributes to the response header policy to define.
  #
  #
  for_each = zipmap(
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in [x["default_cache_behavior"]] :
          merge(z, { "response_headers_policy_id" : sha1(format("%s-default-%s", x["id"], z["target_origin_id"])) }) if length(
            concat(
              compact(
                flatten(
                  [
                    z["response_headers_policy"]["cors_config"]["access_control_allow_headers"]["items"],
                    z["response_headers_policy"]["cors_config"]["access_control_allow_origins"]["items"],
                  ]
                )
              ),
              compact(
                flatten(
                  z["response_headers_policy"]["custom_headers_config"][*]["header"]
                )
              ),
              compact(
                flatten(
                  [
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_security_policy"]["content_security_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_type_options"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["frame_options"]["frame_option"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["referrer_policy"]["referrer_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["access_control_max_age_sec"], [], ),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["mode_block"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["protection"], []),
                  ]
                )
              ),
              compact(
                [
                  z["response_headers_policy"]["server_timing_headers_config"]["enabled"],
                  z["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"],
                ]
              )
            ),
          ) > 0
        ]
      ]
    )[*]["response_headers_policy_id"],
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in [x["default_cache_behavior"]] :
          z["response_headers_policy"] if length(
            concat(
              compact(
                flatten(
                  [
                    z["response_headers_policy"]["cors_config"]["access_control_allow_headers"]["items"],
                    z["response_headers_policy"]["cors_config"]["access_control_allow_origins"]["items"]
                  ]
                )
              ),
              compact(
                flatten(
                  z["response_headers_policy"]["custom_headers_config"][*]["header"]
                )
              ),
              compact(
                flatten(
                  [
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_security_policy"]["content_security_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_type_options"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["frame_options"]["frame_option"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["referrer_policy"]["referrer_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["access_control_max_age_sec"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["mode_block"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["protection"], []),
                  ]
                )

              ),
              compact(
                [
                  z["response_headers_policy"]["server_timing_headers_config"]["enabled"],
                  z["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"],
                ]
              )
            )
          ) > 0
        ]
      ]
    )
  )

  name    = each.key
  comment = each.value["comment"]

  dynamic "cors_config" {
    for_each = length(
      concat(
        compact(
          coalesce(each.value["cors_config"]["access_control_allow_headers"]["items"], [])
        ),
        compact(
          coalesce(each.value["cors_config"]["access_control_allow_methods"]["items"], [])
        ),
        compact(
          coalesce(each.value["cors_config"]["access_control_allow_origins"]["items"], [])
        ),
      )
    ) > 0 ? tomap({ "cors_config" = each.value["cors_config"] }) : {}
    content {

      access_control_allow_credentials = coalesce(
        cors_config.value["access_control_allow_credentials"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_credentials"]
      )

      access_control_allow_headers {
        items = cors_config.value["access_control_allow_headers"]["items"]
      }

      access_control_allow_methods {
        items = coalesce(
          cors_config.value["access_control_allow_methods"]["items"],
          local.default_cloudfront_distribution_config["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_methods"]["items"]
        )
      }

      access_control_allow_origins {
        items = cors_config.value["access_control_allow_origins"]["items"]
      }

      dynamic "access_control_expose_headers" {
        for_each = cors_config.value["access_control_expose_headers"]["items"] != null ? [cors_config.value["access_control_expose_headers"]] : []
        content {
          items = access_control_expose_headers.value["items"]
        }
      }

      access_control_max_age_sec = coalesce(
        cors_config.value["access_control_max_age_sec"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_max_age_sec"]
      )

      origin_override = coalesce(
        cors_config.value["origin_override"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["response_headers_policy"]["cors_config"]["origin_override"]
      )
    }
  }

  dynamic "custom_headers_config" {
    for_each = length(each.value["custom_headers_config"]) > 0 ? tomap({ "custom_headers_config" = each.value["custom_headers_config"] }) : {}
    content {
      dynamic "items" {
        for_each = custom_headers_config.value
        content {
          header   = items.value["header"]
          override = items.value["override"]
          value    = items.value["value"]
        }
      }
    }
  }

  dynamic "security_headers_config" {
    #for_each = coalesce(toset([each.value["security_headers_config"]]), [])
    for_each = length(
      compact(
        [
          each.value["security_headers_config"]["content_security_policy"]["content_security_policy"],
          each.value["security_headers_config"]["content_type_options"]["override"],
          each.value["security_headers_config"]["frame_options"]["frame_option"],
          each.value["security_headers_config"]["referrer_policy"]["referrer_policy"],
          each.value["security_headers_config"]["strict_transport_security"]["access_control_max_age_sec"],
          each.value["security_headers_config"]["strict_transport_security"]["override"],
          each.value["security_headers_config"]["xss_protection"]["mode_block"],
          each.value["security_headers_config"]["xss_protection"]["override"],
          each.value["security_headers_config"]["xss_protection"]["protection"]
        ]
      )
    ) > 0 ? each.value["security_headers_config"] : {}
    content {
      dynamic "content_security_policy" {
        for_each = security_headers_config.value["content_security_policy"]["content_security_policy"] != null ? [security_headers_config.value["content_security_policy"]] : []
        content {
          content_security_policy = content_security_policy.value["content_security_policy"]
          override                = content_security_policy.value["override"]
        }
      }
      dynamic "content_type_options" {
        for_each = security_headers_config.value["content_type_options"]["override"] != null ? [security_headers_config.value["content_type_options"]] : []
        content {
          override = content_type_options.value["override"]
        }
      }
      dynamic "frame_options" {
        for_each = security_headers_config.value["frame_options"]["frame_option"] != null ? [security_headers_config.value["frame_options"]] : []
        content {
          frame_option = frame_options.value["frame_option"]
          override     = frame_options.value["override"]
        }
      }
      dynamic "referrer_policy" {
        for_each = security_headers_config.value["referrer_policy"]["referrer_policy"] != null ? [security_headers_config.value["referrer_policy"]] : []
        content {
          referrer_policy = referrer_policy.value["referrer_policy"]
          override        = referrer_policy.value["override"]
        }
      }
      dynamic "strict_transport_security" {
        for_each = security_headers_config.value["strict_transport_security"]["access_control_max_age_sec"] != null ? [security_headers_config.value["strict_transport_security"]] : []
        content {
          access_control_max_age_sec = strict_transport_security.value["access_control_max_age_sec"]
          include_subdomains         = strict_transport_security.value["include_subdomains"]
          override                   = strict_transport_security.value["override"]
          preload                    = strict_transport_security.value["preload"]
        }
      }
    }
  }

  dynamic "server_timing_headers_config" {
    for_each = length(compact(
      [
        each.value["server_timing_headers_config"]["enabled"],
        each.value["server_timing_headers_config"]["sampling_rate"]
      ]
      )) > 0 ? tomap(
      {
        "server_timing_headers_config" = each.value["server_timing_headers_config"]
      }
    ) : {}
    content {
      enabled = coalesce(
        server_timing_headers_config.value["enabled"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["response_headers_policy"]["server_timing_headers_config"]["enabled"]
      )
      sampling_rate = coalesce(
        server_timing_headers_config.value["sampling_rate"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"]
      )
    }
  }

}

###################################################################################################################################################################
###################################################################################################################################################################
###################################################################################################################################################################

resource "aws_cloudfront_response_headers_policy" "ordered_behavior_response_headers_policy" {


  #
  # Generate Map using hash sha1 from a string generated from the the 
  # Terraform CloudFront ID, Path Pattern and the Target Origin ID. 
  # There is one if condition checking whether there is at least one 
  # of the mandatoryattributes to the response header policy to define.
  #
  #
  for_each = zipmap(
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in x["ordered_cache_behavior"] :
          merge(z, { "response_headers_policy_id" : sha1(format("%s-%s-%s", x["id"], z["path_pattern"], z["target_origin_id"])) }) if length(
            concat(
              compact(
                flatten(
                  [
                    z["response_headers_policy"]["cors_config"]["access_control_allow_headers"]["items"],
                    z["response_headers_policy"]["cors_config"]["access_control_allow_origins"]["items"],
                  ]
                )
              ),
              compact(
                flatten(
                  z["response_headers_policy"]["custom_headers_config"][*]["header"]
                )
              ),
              compact(
                flatten(
                  [
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_security_policy"]["content_security_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_type_options"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["frame_options"]["frame_option"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["referrer_policy"]["referrer_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["access_control_max_age_sec"], [], ),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["mode_block"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["protection"], []),
                  ]
                )
              ),
              compact(
                [
                  z["response_headers_policy"]["server_timing_headers_config"]["enabled"],
                  z["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"],
                ]
              )
            ),
          ) > 0
        ]
      ]
    )[*]["response_headers_policy_id"],
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in x["ordered_cache_behavior"] :
          z["response_headers_policy"] if length(
            concat(
              compact(
                flatten(
                  [
                    z["response_headers_policy"]["cors_config"]["access_control_allow_headers"]["items"],
                    z["response_headers_policy"]["cors_config"]["access_control_allow_origins"]["items"],
                  ]
                )
              ),
              compact(
                flatten(
                  z["response_headers_policy"]["custom_headers_config"][*]["header"]
                )
              ),
              compact(
                flatten(
                  [
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_security_policy"]["content_security_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["content_type_options"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["frame_options"]["frame_option"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["referrer_policy"]["referrer_policy"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["access_control_max_age_sec"], [], ),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["strict_transport_security"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["mode_block"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["override"], []),
                    coalesce(z["response_headers_policy"]["security_headers_config"]["xss_protection"]["protection"], []),
                  ]
                )
              ),
              compact(
                [
                  z["response_headers_policy"]["server_timing_headers_config"]["enabled"],
                  z["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"],
                ]
              )
            ),
          ) > 0
        ]
      ]
    )
  )

  name    = each.key
  comment = each.value["comment"]

  dynamic "cors_config" {
    for_each = length(
      concat(
        compact(
          coalesce(each.value["cors_config"]["access_control_allow_headers"]["items"], [])
        ),
        compact(
          coalesce(each.value["cors_config"]["access_control_allow_methods"]["items"], [])
        ),
        compact(
          coalesce(each.value["cors_config"]["access_control_allow_origins"]["items"], [])
        ),
      )
    ) > 0 ? tomap({ "cors_config" = each.value["cors_config"] }) : {}
    content {

      access_control_allow_credentials = coalesce(
        cors_config.value["access_control_allow_credentials"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_credentials"]
      )

      access_control_allow_headers {
        items = cors_config.value["access_control_allow_headers"]["items"]
      }

      access_control_allow_methods {
        items = coalesce(
          cors_config.value["access_control_allow_methods"]["items"],
          local.default_cloudfront_distribution_config["ordered_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_allow_methods"]["items"]
        )
      }

      access_control_allow_origins {
        items = cors_config.value["access_control_allow_origins"]["items"]
      }

      dynamic "access_control_expose_headers" {
        for_each = cors_config.value["access_control_expose_headers"]["items"] != null ? [cors_config.value["access_control_expose_headers"]] : []
        content {
          items = access_control_expose_headers.value["items"]
        }
      }

      access_control_max_age_sec = coalesce(
        cors_config.value["access_control_max_age_sec"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["response_headers_policy"]["cors_config"]["access_control_max_age_sec"]
      )

      origin_override = coalesce(
        cors_config.value["origin_override"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["response_headers_policy"]["cors_config"]["origin_override"]
      )
    }
  }

  dynamic "custom_headers_config" {
    for_each = length(each.value["custom_headers_config"]) > 0 ? tomap({ "custom_headers_config" = each.value["custom_headers_config"] }) : {}
    content {
      dynamic "items" {
        for_each = custom_headers_config.value
        content {
          header   = items.value["header"]
          override = items.value["override"]
          value    = items.value["value"]
        }
      }
    }
  }

  dynamic "security_headers_config" {
    #for_each = coalesce(toset([each.value["security_headers_config"]]), [])
    for_each = length(
      compact(
        [
          each.value["security_headers_config"]["content_security_policy"]["content_security_policy"],
          each.value["security_headers_config"]["content_type_options"]["override"],
          each.value["security_headers_config"]["frame_options"]["frame_option"],
          each.value["security_headers_config"]["referrer_policy"]["referrer_policy"],
          each.value["security_headers_config"]["strict_transport_security"]["access_control_max_age_sec"],
          each.value["security_headers_config"]["strict_transport_security"]["override"],
          each.value["security_headers_config"]["xss_protection"]["mode_block"],
          each.value["security_headers_config"]["xss_protection"]["override"],
          each.value["security_headers_config"]["xss_protection"]["protection"]
        ]
      )
    ) > 0 ? each.value["security_headers_config"] : {}
    content {
      dynamic "content_security_policy" {
        for_each = security_headers_config.value["content_security_policy"]["content_security_policy"] != null ? [security_headers_config.value["content_security_policy"]] : []
        content {
          content_security_policy = content_security_policy.value["content_security_policy"]
          override                = content_security_policy.value["override"]
        }
      }
      dynamic "content_type_options" {
        for_each = security_headers_config.value["content_type_options"]["override"] != null ? [security_headers_config.value["content_type_options"]] : []
        content {
          override = content_type_options.value["override"]
        }
      }
      dynamic "frame_options" {
        for_each = security_headers_config.value["frame_options"]["frame_option"] != null ? [security_headers_config.value["frame_options"]] : []
        content {
          frame_option = frame_options.value["frame_option"]
          override     = frame_options.value["override"]
        }
      }
      dynamic "referrer_policy" {
        for_each = security_headers_config.value["referrer_policy"]["referrer_policy"] != null ? [security_headers_config.value["referrer_policy"]] : []
        content {
          referrer_policy = referrer_policy.value["referrer_policy"]
          override        = referrer_policy.value["override"]
        }
      }
      dynamic "strict_transport_security" {
        for_each = security_headers_config.value["strict_transport_security"]["access_control_max_age_sec"] != null ? [security_headers_config.value["strict_transport_security"]] : []
        content {
          access_control_max_age_sec = strict_transport_security.value["access_control_max_age_sec"]
          include_subdomains         = strict_transport_security.value["include_subdomains"]
          override                   = strict_transport_security.value["override"]
          preload                    = strict_transport_security.value["preload"]
        }
      }
    }
  }

  dynamic "server_timing_headers_config" {
    for_each = length(compact(
      [
        each.value["server_timing_headers_config"]["enabled"],
        each.value["server_timing_headers_config"]["sampling_rate"]
      ]
      )) > 0 ? tomap(
      {
        "server_timing_headers_config" = each.value["server_timing_headers_config"]
      }
    ) : {}
    content {
      enabled = coalesce(
        server_timing_headers_config.value["enabled"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["response_headers_policy"]["server_timing_headers_config"]["enabled"]
      )
      sampling_rate = coalesce(
        server_timing_headers_config.value["sampling_rate"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["response_headers_policy"]["server_timing_headers_config"]["sampling_rate"]
      )
    }
  }

}