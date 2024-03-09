

<!-- markdownlint-disable -->
# terraform-aws-utils <a href="https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content="><img align="right" src="https://cloudposse.com/logo-300x69.svg" width="150" /></a>
<a href="https://github.com/cloudposse/terraform-aws-utils/commits"><img src="https://img.shields.io/github/last-commit/cloudposse/terraform-aws-utils.svg?style=for-the-badge" alt="Last Updated"/></a><a href="https://github.com/cloudposse/terraform-aws-utils/releases/latest"><img src="https://img.shields.io/github/release/cloudposse/terraform-aws-utils.svg?style=for-the-badge" alt="Latest Release"/></a><a href="https://github.com/cloudposse/terraform-aws-utils/commits"><img src="https://img.shields.io/github/last-commit/cloudposse/terraform-aws-utils.svg?style=for-the-badge" alt="Last Updated"/></a><a href="https://slack.cloudposse.com"><img src="https://slack.cloudposse.com/for-the-badge.svg" alt="Slack Community"/></a>
<!-- markdownlint-restore -->

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `cloudposse/build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

This `terraform-aws-utils` module provides some simple utilities to use when working in AWS.


> [!TIP]
> #### 👽 Use Atmos with Terraform
> Cloud Posse uses [`atmos`](https://atmos.tools) to easily orchestrate multiple environments using Terraform. <br/>
> Works with [Github Actions](https://atmos.tools/integrations/github-actions/), [Atlantis](https://atmos.tools/integrations/atlantis), or [Spacelift](https://atmos.tools/integrations/spacelift).
>
> <details>
> <summary><strong>Watch demo of using Atmos with Terraform</strong></summary>
> <img src="https://github.com/cloudposse/atmos/blob/master/docs/demo.gif?raw=true"/><br/>
> <i>Example of running <a href="https://atmos.tools"><code>atmos</code></a> to manage infrastructure from our <a href="https://atmos.tools/quick-start/">Quick Start</a> tutorial.</i>
> </detalis>


## Introduction

This `terraform-aws-utils` module provides some simple utilities to use when working in AWS.
More complex utilities are available through Cloud Posse's `utils` Terraform provider
[terraform-provider-utils](https://github.com/cloudposse/terraform-provider-utils).

### Compact Alternative Codes (Abbreviations)
This module's primary function is to provide compact alternative codes for Regions, Availability Zones,
and Local Zones, codes which are guaranteed to use only digits and lower case letters: no hyphens.
Conversions to and from official codes and alternative codes are handled via lookup maps.

- The `short` abbreviations for regions are variable length (generally 4-6 characters, but length limits not guaranteed)
and strictly algorithmically derived so that people can more easily interpret them. The `short` region
code abbreviations typically match the prefix of the Availability Zone IDs in that region, but this is
not guaranteed. The `short` abbreviations for local regions are generally of the form AWS uses, with
the region prefix and dashes removed.
- The `fixed` abbreviations are always exactly 3 characters for regions and 4 characters
for availability zones and local zones, but have some exceptional cases (China, Africa, Asia-Pacific South, US GovCloud)
that have non-obvious abbreviations. If a future new region causes a conflict with an established local zone
abbreviation, we may change the local zone abbreviation to keep the region mappings consistent. For example,
the local zone `us-east-1-mci-1a` would have been abbreviated `mc1a` had we released it earlier, and that would have
conflicted with the new (in 2022) `me-central-1a` which would also be abbreviated `mc1a` in keeping with the general
pattern of using the first letter of each of the first 2 parts. We might have chosen to change the abbreviation
for `us-east-1-mci-1` so we could use `mc1a` for `me-central-1a`. (As it happens, we added them both at the same
time and avoided this collision.) If we were to make such a change, this
would be a breaking change for people using the affected local zone, so we recommend using the `short`
abbreviations if you are using local zones, which are far less likely to have conflicts in the future.
- The `identity` "abbreviations" are not abbreviations but are instead the official codes (output equals input,
which is why it is called "identity"). This map is provided to simplify algorithmic choice of region code
abbreviation when you want to include a "no abbreviation" option.

We currently support Local Zones but not Wavelength Zones. If we support Wavelength Zones in the future,
it is likely that the fixed-length abbreviations for them will be non-intuitive, or we may only provide
`short` and not `fixed` abbreviations for them.

The intention is that existing region mappings will never change, and if new regions or zones are created that
conflict with existing ones, they will be given non-standard mappings so as not to conflict. However, as
stated above, we may choose to change a local region abbreviation if it conflicts with the obvious abbreviation
for a newly created region. We have picked abbreviations for local zones with avoiding such future
collisions in mind, but we cannot predict the future. (Both `bos` and `den` fit the pattern for region abbreviations,
but we do not envision a future `bo-south-1` or `de-north-1` region.)

### ELB Logging

This module provides Elastic Load Balancing Account IDs per region to be used in
configuring [S3 Bucket Permissions](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions)
to allow access logs to be stored in S3.

However, the account IDs have no other purpose, and as AWS expands, it has become more complicated to create
the correct bucket policy. The policy for region `me-central-1` is different than the policy for `us-east-1`.
So now this module has a new feature: you provide the full AWS region code for the region where logging
is to take place (`elb_logging_region`), and the S3 bucket ARN for where logs are to be stored (`elb_logging_bucket_resource_arn`),
and this module will output the appropriate S3 bucket policy (in JSON) to attach to your S3 bucket.

NOTE: The region must be known at Terraform "plan" time. Use a configuration input, such as what you used
to configure the Terraform AWS Provider, not an output from some resource or module.

### Region Display Names

There is no AWS API that reliably returns the human-friendly display name (e.g. "Europe (Stockholm)") given
the API-friendly region name. So this module provides `region_display_name_map` to implement this functionality.

### Enabled and Disabled Regions

For convenience, this module provides lists of enabled and disabled regions in the current account. Note that
since these lists are dynamic, they cannot be used in Terraform `count` or `for_each` resource expressions.


> [!TIP]
> #### Use Terraform Reference Architectures for AWS
>
> Use Cloud Posse's ready-to-go [terraform architecture blueprints](https://cloudposse.com/reference-architecture/) for AWS to get up and running quickly.
>
> ✅ We build it with you.<br/>
> ✅ You own everything.<br/>
> ✅ Your team wins.<br/>
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
> <details><summary>📚 <strong>Learn More</strong></summary>
>
> <br/>
>
> Cloud Posse is the leading [**DevOps Accelerator**](https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=commercial_support) for funded startups and enterprises.
>
> *Your team can operate like a pro today.*
>
> Ensure that your team succeeds by using Cloud Posse's proven process and turnkey blueprints. Plus, we stick around until you succeed.
> #### Day-0:  Your Foundation for Success
> - **Reference Architecture.** You'll get everything you need from the ground up built using 100% infrastructure as code.
> - **Deployment Strategy.** Adopt a proven deployment strategy with GitHub Actions, enabling automated, repeatable, and reliable software releases.
> - **Site Reliability Engineering.** Gain total visibility into your applications and services with Datadog, ensuring high availability and performance.
> - **Security Baseline.** Establish a secure environment from the start, with built-in governance, accountability, and comprehensive audit logs, safeguarding your operations.
> - **GitOps.** Empower your team to manage infrastructure changes confidently and efficiently through Pull Requests, leveraging the full power of GitHub Actions.
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
>
> #### Day-2: Your Operational Mastery
> - **Training.** Equip your team with the knowledge and skills to confidently manage the infrastructure, ensuring long-term success and self-sufficiency.
> - **Support.** Benefit from a seamless communication over Slack with our experts, ensuring you have the support you need, whenever you need it.
> - **Troubleshooting.** Access expert assistance to quickly resolve any operational challenges, minimizing downtime and maintaining business continuity.
> - **Code Reviews.** Enhance your team’s code quality with our expert feedback, fostering continuous improvement and collaboration.
> - **Bug Fixes.** Rely on our team to troubleshoot and resolve any issues, ensuring your systems run smoothly.
> - **Migration Assistance.** Accelerate your migration process with our dedicated support, minimizing disruption and speeding up time-to-value.
> - **Customer Workshops.** Engage with our team in weekly workshops, gaining insights and strategies to continuously improve and innovate.
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
> </details>


## Usage

Here's how to invoke this example module in your projects

```hcl
locals {
  shorten_regions   = true
  naming_convention = local.shorten_regions ? "to_short" : "identity"
  az_map            = module.example.region_az_alt_code_maps[local.naming_convention]
}

module "utils_example_complete" {
  source  = "cloudposse/utils/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
}

module "label" {
  source = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"

  attributes = [local.az_map["us-east-2"]]

  context = module.this.context
}
```

> [!IMPORTANT]
> In Cloud Posse's examples, we avoid pinning modules to specific versions to prevent discrepancies between the documentation
> and the latest released versions. However, for your own projects, we strongly advise pinning each module to the exact version
> you're using. This practice ensures the stability of your infrastructure. Additionally, we recommend implementing a systematic
> approach for updating versions to avoid unexpected changes.





## Examples

Here is an example of using this module:
- [`examples/complete`](examples/complete) - complete example of using this module




<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.by_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.by_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_regions.complete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |
| [aws_regions.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |
| [aws_regions.not_opted_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |
| [aws_regions.opted_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_elb_logging_bucket_resource_arn"></a> [elb\_logging\_bucket\_resource\_arn](#input\_elb\_logging\_bucket\_resource\_arn) | The AWS Resource ARN to use in the policy granting access to Load Balancer Logging.<br>Typically of the form `arn:aws:s3:::_bucket-name_/_prefix_/AWSLogs/_your-aws-account-id_/*`.<br>Required to generate `elb_logging_s3_bucket_policy_json`.<br>See [AWS Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#attach-bucket-policy). | `string` | `""` | no |
| <a name="input_elb_logging_region"></a> [elb\_logging\_region](#input\_elb\_logging\_region) | Full region (e.g. `us-east-1`) where ELB logging is taking place. Required to generate `elb_s3_bucket_policy_json`.<br>Must be known at "plan" time. | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_regions"></a> [all\_regions](#output\_all\_regions) | A list of all regions regardless of availability to the account |
| <a name="output_disabled_regions"></a> [disabled\_regions](#output\_disabled\_regions) | A list of regions that are disabled in the account |
| <a name="output_elb_logging_account"></a> [elb\_logging\_account](#output\_elb\_logging\_account) | Map of full region to ELB logging account |
| <a name="output_elb_logging_s3_bucket_policy_json"></a> [elb\_logging\_s3\_bucket\_policy\_json](#output\_elb\_logging\_s3\_bucket\_policy\_json) | The S3 bucket policy (in JSON) to attach to the S3 bucket to allow Load Balancer logs to be added.<br>Requires `elb_logging_bucket_resource_arn` and `elb_logging_region` inputs. |
| <a name="output_enabled_regions"></a> [enabled\_regions](#output\_enabled\_regions) | A list of regions that are enabled in the account |
| <a name="output_region_az_alt_code_maps"></a> [region\_az\_alt\_code\_maps](#output\_region\_az\_alt\_code\_maps) | Collection of maps converting between official AWS Region, Availability Zone, and Local Zone codes and shorter unofficial codes using only lower case letters and digits. Inspired for use in naming and tagging so that region or AZ code will be 1 semantic unit.<br><br>- `to_fixed` = Map of regions to 3-character codes and Availability Zones to 4-character codes<br>- `to_short` = Map of regions and Availability Zones to compact (usually 4-6 characters) codes<br>- `from_fixed` = Map of `fixed` codes back to full region or Availability Zone codes<br>- `from_short` = Map of `short` codes back to full region or Availability Zone codes<br>- `identity` = Identity map of full region and Availability Zone codes back to themselves |
| <a name="output_region_display_name_map"></a> [region\_display\_name\_map](#output\_region\_display\_name\_map) | Map of full region names to user-friendly display names (e.g. "eu-west-3" = "Europe (Paris)"). |
<!-- markdownlint-restore -->


## Related Projects

Check out these related projects.

- [terraform-provider-utils](https://github.com/cloudposse/terraform-provider-utils) - The Cloud Posse Terraform Provider for various utilities (e.g. deep merging, stack configuration management).
- [terraform-null-label](https://github.com/cloudposse/terraform-null-label) - Terraform module designed to generate consistent names and tags for resources. Use terraform-null-label to implement a strict naming convention.


## References

For additional context, refer to some of these links.

- [Terraform Standard Module Structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure) - HashiCorp's standard module structure is a file and directory layout we recommend for reusable modules distributed in separate repositories.
- [Terraform Module Requirements](https://www.terraform.io/docs/registry/modules/publish.html#requirements) - HashiCorp's guidance on all the requirements for publishing a module. Meeting the requirements for publishing a module is extremely easy.
- [Terraform Version Pinning](https://www.terraform.io/docs/configuration/terraform.html#specifying-a-required-terraform-version) - The required_version setting can be used to constrain which versions of the Terraform CLI can be used with your configuration
- [AWS Regions and Zones](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html) - AWS documentation on regions and zones




## ✨ Contributing

This project is under active development, and we encourage contributions from our community.



Many thanks to our outstanding contributors:

<a href="https://github.com/cloudposse/terraform-aws-utils/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudposse/terraform-aws-utils&max=24" />
</a>

For 🐛 bug reports & feature requests, please use the [issue tracker](https://github.com/cloudposse/terraform-aws-utils/issues).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.
 1. Review our [Code of Conduct](https://github.com/cloudposse/terraform-aws-utils/?tab=coc-ov-file#code-of-conduct) and [Contributor Guidelines](https://github.com/cloudposse/.github/blob/main/CONTRIBUTING.md).
 2. **Fork** the repo on GitHub
 3. **Clone** the project to your own machine
 4. **Commit** changes to your own branch
 5. **Push** your work back up to your fork
 6. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

### 🌎 Slack Community

Join our [Open Source Community](https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=slack) on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

### 📰 Newsletter

Sign up for [our newsletter](https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=newsletter) and join 3,000+ DevOps engineers, CTOs, and founders who get insider access to the latest DevOps trends, so you can always stay in the know.
Dropped straight into your Inbox every week — and usually a 5-minute read.

### 📆 Office Hours <a href="https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=office_hours"><img src="https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png" align="right" /></a>

[Join us every Wednesday via Zoom](https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=office_hours) for your weekly dose of insider DevOps trends, AWS news and Terraform insights, all sourced from our SweetOps community, plus a _live Q&A_ that you can’t find anywhere else.
It's **FREE** for everyone!
## License

<a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge" alt="License"></a>

<details>
<summary>Preamble to the Apache License, Version 2.0</summary>
<br/>
<br/>

Complete license is available in the [`LICENSE`](LICENSE) file.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
</details>

## Trademarks

All other trademarks referenced herein are the property of their respective owners.


## Copyrights

Copyright © 2020-2024 [Cloud Posse, LLC](https://cloudposse.com)



<a href="https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-utils&utm_content=readme_footer_link"><img alt="README footer" src="https://cloudposse.com/readme/footer/img"/></a>

<img alt="Beacon" width="0" src="https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-aws-utils?pixel&cs=github&cm=readme&an=terraform-aws-utils"/>
