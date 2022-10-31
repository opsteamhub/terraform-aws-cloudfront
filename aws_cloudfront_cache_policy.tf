resource "aws_cloudfront_cache_policy" "default_behavior_cache_policy" {


  #
  # Generate Map using hash sha1 from a string generated from the the 
  # Terraform CloudFront ID and the Target Origin ID. There is one if 
  # condition checking whether there is at least one of the mandatory 
  # attributes to the cache policy to define.
  #
  #
  for_each = zipmap(
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in [x["default_cache_behavior"]] :
          merge(z, { "cache_policy_id" : sha1(format("%s-default-%s", x["id"], z["target_origin_id"])) }) if length(
            compact(
              [
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"]
              ]
            )
          ) > 0
        ]
      ]
    )[*]["cache_policy_id"],
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in [x["default_cache_behavior"]] :
          z["cache_policy"] if length(
            compact(
              [
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"]
              ]
            )
          ) > 0
        ]
      ]
    )
  )

  name        = each.key
  comment     = each.value["comment"]
  default_ttl = coalesce(each.value["default_ttl"], local.default_cloudfront_distribution_config["default_cache_behavior"]["cache_policy"]["default_ttl"])
  max_ttl     = each.value["max_ttl"]
  min_ttl     = each.value["min_ttl"]
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = coalesce(
        each.value["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"]
      )
      dynamic "cookies" {
        for_each = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookies"]["items"] != null ? tomap({ "items" = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookies"]["items"] }) : {}
        content {
          items = cookies.value
        }
      }
    }
    headers_config {
      header_behavior = coalesce(
        each.value["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"]
      )
      dynamic "headers" {
        for_each = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["headers"]["items"] != null ? tomap({ "items" = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["headers"]["items"] }) : {}
        content {
          items = headers.value
        }
      }
    }
    query_strings_config {
      query_string_behavior = coalesce(
        each.value["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"],
        local.default_cloudfront_distribution_config["default_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"]
      )
      dynamic "query_strings" {
        for_each = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_strings"]["items"] != null ? tomap({ "items" = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_strings"]["items"] }) : {}
        content {
          items = query_strings.value
        }
      }
    }
  }
}



#
# Generate Map using hash sha1 from a string generated from the the 
# Terraform CloudFront ID, Path Pattern and the Target Origin ID. 
# There is one if condition checking whether there is at least one 
# of the mandatoryattributes to the cache policy to define.
#
#
resource "aws_cloudfront_cache_policy" "ordered_behavior_cache_policy" {
  for_each = zipmap(
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in x["ordered_cache_behavior"] :
          merge(z, { "cache_policy_id" : sha1(format("%s-%s-%s", x["id"], z["path_pattern"], z["target_origin_id"])) }) if length(
            compact(
              [
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"]
              ]
            )
          ) > 0
        ]
      ]
    )[*]["cache_policy_id"],
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in x["ordered_cache_behavior"] :
          z["cache_policy"] if length(
            compact(
              [
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"],
                z["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"]
              ]
            )
          ) > 0
        ]
      ]
    )
  )

  name        = each.key
  comment     = each.value["comment"]
  default_ttl = each.value["default_ttl"]
  max_ttl     = each.value["max_ttl"]
  min_ttl     = each.value["min_ttl"]
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = coalesce(
        each.value["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookie_behavior"]
      )
      dynamic "cookies" {
        for_each = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookies"]["items"] != null ? tomap({ "items" = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["cookies_config"]["cookies"]["items"] }) : {}
        content {
          items = cookies.value
        }
      }
    }
    headers_config {
      header_behavior = coalesce(
        each.value["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["header_behavior"]
      )
      dynamic "headers" {
        for_each = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["headers"]["items"] != null ? tomap({ "items" = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["headers_config"]["headers"]["items"] }) : {}
        content {
          items = headers.value
        }
      }
    }
    query_strings_config {
      query_string_behavior = coalesce(
        each.value["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"],
        local.default_cloudfront_distribution_config["ordered_cache_behavior"]["cache_policy"]["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_string_behavior"]
      )
      dynamic "query_strings" {
        for_each = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_strings"]["items"] != null ? tomap({ "items" = each.value["parameters_in_cache_key_and_forwarded_to_origin"]["query_strings_config"]["query_strings"]["items"] }) : {}
        content {
          items = query_strings.value
        }
      }
    }
  }
}