module "opsteam-testecase-01-cloudfront-s3origin" {
  source = "../.././"
  cloudfront_distribution_config = [
    {
      id      = "Wja7S2MxWI-cdn-s3-origin"
      enabled = false
      default_cache_behavior = {
        target_origin_id = "pQYucvOKtL"
      }
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "pQYucvOKtL"
        },
      ]
    },
    {
      id      = "Wja7S2MxWI-cdn-regular-origin"
      enabled = false
      default_cache_behavior = {
        target_origin_id = "AGITaM4EOI"
      }
      origin = [
        {
          domain_name = "opsteam-testecase-001-bucketpolicy.s3.amazonaws.com"
          origin_id   = "AGITaM4EOI"
        },
      ]
    }


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

