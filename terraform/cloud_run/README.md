## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.route53"></a> [aws.route53](#provider\_aws.route53) | n/a |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.a_record_gcp_global_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [google_cloud_run_service.ide_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_policy.noauth](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_policy) | resource |
| [google_compute_backend_service.code_ide_backend](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service) | resource |
| [google_compute_global_address.lb_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_forwarding_rule.default_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_global_forwarding_rule.http_redirect](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_managed_ssl_certificate.site_cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_region_network_endpoint_group.cloud_run_ide_neg](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_network_endpoint_group) | resource |
| [google_compute_target_http_proxy.http_redirect](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy) | resource |
| [google_compute_target_https_proxy.default_proxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_url_map.code_service_urlmap](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |
| [google_compute_url_map.http_redirect](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |
| [aws_route53_zone.uselessnerd_zone_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [google_iam_policy.noauth](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_run_url_internal"></a> [cloud\_run\_url\_internal](#output\_cloud\_run\_url\_internal) | n/a |
