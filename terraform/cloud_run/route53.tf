
data "aws_route53_zone" "uselessnerd_zone_public" {
  provider     = aws.route53
  name         = "uselessnerd.com"
  private_zone = false
}

resource "aws_route53_record" "a_record_gcp_global_lb" {
  provider = aws.route53
  type     = "A"
  zone_id  = data.aws_route53_zone.uselessnerd_zone_public.id
  records  = [google_compute_global_address.lb_address.address]
  name     = "coder"
  ttl      = 3600
}
