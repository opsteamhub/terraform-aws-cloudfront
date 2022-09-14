module "opsteam-testecase-01-cloudfront-s3origin-cachepolicy" {
  source = "/Users/brunopaiuca/projects/opsteam/terraform-modules/terraform-aws-cloudfront"
  cloudfront_distribution_config = [
    {
      id = "dfdsfsdfs"
      enabled = false
      origin = [
        {
          domain_name              = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id                = "teste"
        },
      ]
      #default_cache_behavior = {
      #  compress = true
      #}
    }
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

