
resource "aws_cloudfront_origin_access_control" "oac" {
  for_each = { for k, v in zipmap(var.cloudfront_distribution_config[*]["id"], var.cloudfront_distribution_config) :
    k => v
  }
  name                              = each.key
  description                       = format("OAC to manage permittion from the related distribution %s to S3", each.key)
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
