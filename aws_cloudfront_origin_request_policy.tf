
resource "aws_cloudfront_origin_request_policy" "default_behavior_origin_request_policy" {

  #
  # Generate Map using hash sha1 from a string generated from the the 
  # Terraform CloudFront ID and the Target Origin ID. There is one if 
  # condition checking whether there is at least one of the mandatory 
  # attributes to the origin request policy to define.
  #
  #
  for_each = zipmap(
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in [x["default_cache_behavior"]] :
          merge(z, { "origin_request_policy_id" : sha1(format("%s-default-%s", x["id"], z["target_origin_id"])) }) if length(
            compact(
              [
                z["origin_request_policy"]["cookies_config"]["cookie_behavior"],
                z["origin_request_policy"]["headers_config"]["header_behavior"],
                z["origin_request_policy"]["query_strings_config"]["query_string_behavior"]
              ]
            )
          ) > 0
        ]
      ]
    )[*]["origin_request_policy_id"],
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in [x["default_cache_behavior"]] :
          z if length(
            compact(
              [
                z["origin_request_policy"]["cookies_config"]["cookie_behavior"],
                z["origin_request_policy"]["headers_config"]["header_behavior"],
                z["origin_request_policy"]["query_strings_config"]["query_string_behavior"]
              ]
            )
          ) > 0
        ]
      ]
    )
  )

  name    = each.key
  comment = try(each.value["origin_request_policy"]["comment"], null)

  cookies_config {
    cookie_behavior = coalesce(
      each.value["origin_request_policy"]["cookies_config"]["cookie_behavior"],
      local.default_cloudfront_distribution_config["default_cache_behavior"]["origin_request_policy"]["cookies_config"]["cookie_behavior"]
    )
    dynamic "cookies" {
      for_each = each.value["origin_request_policy"]["cookies_config"]["cookies"]["items"] != null ? tomap({ "items" = each.value["origin_request_policy"]["cookies_config"]["cookies"]["items"] }) : {}
      content {
        items = cookies.value
      }
    }
  }

  headers_config {
    header_behavior = coalesce(
      each.value["origin_request_policy"]["headers_config"]["header_behavior"],
      local.default_cloudfront_distribution_config["default_cache_behavior"]["origin_request_policy"]["headers_config"]["header_behavior"]
    )
    dynamic "headers" {
      for_each = each.value["origin_request_policy"]["headers_config"]["headers"]["items"] != null ? tomap({ "items" = each.value["origin_request_policy"]["headers_config"]["headers"]["items"] }) : {}
      content {
        items = headers.value
      }
    }
  }

  query_strings_config {
    query_string_behavior = coalesce(
      each.value["origin_request_policy"]["query_strings_config"]["query_string_behavior"],
      local.default_cloudfront_distribution_config["default_cache_behavior"]["origin_request_policy"]["query_strings_config"]["query_string_behavior"]
    )
    dynamic "query_strings" {
      for_each = each.value["origin_request_policy"]["query_strings_config"]["query_strings"]["items"] != null ? tomap({ "items" = each.value["origin_request_policy"]["query_strings_config"]["query_strings"]["items"] }) : {}
      content {
        items = query_strings.value
      }
    }
  }

}



resource "aws_cloudfront_origin_request_policy" "ordered_behavior_origin_request_policy" {

  #
  # Generate Map using hash sha1 from a string generated from the the 
  # Terraform CloudFront ID, Path Pattern and the Target Origin ID. 
  # There is one if condition checking whether there is at least one 
  # of the mandatoryattributes to the origin request policy to define.
  #
  #
  for_each = zipmap(
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in coalesce(x["ordered_cache_behavior"], []) :
          merge(z, { "origin_request_policy_id" : sha1(format("%s-%s-%s", x["id"], z["path_pattern"], z["target_origin_id"])) }) if length(compact([z["origin_request_policy"]["cookies_config"]["cookie_behavior"], z["origin_request_policy"]["headers_config"]["header_behavior"], z["origin_request_policy"]["query_strings_config"]["query_string_behavior"]])) > 0
        ]
      ]
    )[*]["origin_request_policy_id"],
    flatten(
      [
        for x in local.cloudfront_distribution_config_normalized :
        [for z in coalesce(x["ordered_cache_behavior"], []) :
          z if length(compact([z["origin_request_policy"]["cookies_config"]["cookie_behavior"], z["origin_request_policy"]["headers_config"]["header_behavior"], z["origin_request_policy"]["query_strings_config"]["query_string_behavior"]])) > 0
        ]
      ]
    )
  )

  name    = each.key
  comment = try(each.value["origin_request_policy"]["comment"], null)

  cookies_config {
    cookie_behavior = coalesce(
      each.value["origin_request_policy"]["cookies_config"]["cookie_behavior"],
      local.default_cloudfront_distribution_config["ordered_cache_behavior"]["origin_request_policy"]["cookies_config"]["cookie_behavior"]
    )
    dynamic "cookies" {
      for_each = each.value["origin_request_policy"]["cookies_config"]["cookies"]["items"] != null ? tomap({ "items" = each.value["origin_request_policy"]["cookies_config"]["cookies"]["items"] }) : {}
      content {
        items = cookies.value
      }
    }
  }

  headers_config {
    header_behavior = coalesce(
      each.value["origin_request_policy"]["headers_config"]["header_behavior"],
      local.default_cloudfront_distribution_config["ordered_cache_behavior"]["origin_request_policy"]["headers_config"]["header_behavior"]
    )
    dynamic "headers" {
      for_each = each.value["origin_request_policy"]["headers_config"]["headers"]["items"] != null ? tomap({ "items" = each.value["origin_request_policy"]["headers_config"]["headers"]["items"] }) : {}
      content {
        items = headers.value
      }
    }
  }

  query_strings_config {
    query_string_behavior = coalesce(
      each.value["origin_request_policy"]["query_strings_config"]["query_string_behavior"],
      local.default_cloudfront_distribution_config["ordered_cache_behavior"]["origin_request_policy"]["query_strings_config"]["query_string_behavior"]
    )
    dynamic "query_strings" {
      for_each = each.value["origin_request_policy"]["query_strings_config"]["query_strings"]["items"] != null ? tomap({ "items" = each.value["origin_request_policy"]["query_strings_config"]["query_strings"]["items"] }) : {}
      content {
        items = query_strings.value
      }
    }
  }

}
