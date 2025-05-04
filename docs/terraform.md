<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 6.35.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.0 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 6.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket_label"></a> [bucket\_label](#module\_bucket\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_dynamodb_table_label"></a> [dynamodb\_table\_label](#module\_dynamodb\_table\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.with_server_side_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [local_file.terraform_backend_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [oci_objectstorage_bucket.default](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_bucket) | resource |
| [oci_identity_region_subscriptions.current](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_type"></a> [access\_type](#input\_access\_type) | (Optional) (Updatable) The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations. | `string` | `"NoPublicAccess"` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auto_tiering"></a> [auto\_tiering](#input\_auto\_tiering) | (Optional) (Updatable) Set the auto tiering status on the bucket. By default, a bucket is created with auto tiering Disabled. Use this option to enable auto tiering during bucket creation. Objects in a bucket with auto tiering set to InfrequentAccess are transitioned automatically between the 'Standard' and 'InfrequentAccess' tiers based on the access pattern of the objects. | `string` | `"Disabled"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS profile name as set in the shared credentials file | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources in | `string` | `"eu-west-3"` | no |
| <a name="input_aws_role_arn"></a> [aws\_role\_arn](#input\_aws\_role\_arn) | The AWS role to be assumed | `string` | `""` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | DynamoDB billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_bucket_enabled"></a> [bucket\_enabled](#input\_bucket\_enabled) | Whether to create the OCI Object Storage bucket. | `bool` | `true` | no |
| <a name="input_capacity_mode"></a> [capacity\_mode](#input\_capacity\_mode) | Optional) (Updatable) The capacity mode of the table. If capacityMode = ON\_DEMAND, maxReadUnits and maxWriteUnits are not used, and both will have the value of zero. | `string` | `"ON_DEMAND"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_ddl_statement"></a> [ddl\_statement](#input\_ddl\_statement) | (Required) (Updatable) Complete CREATE TABLE DDL statement. When update ddl\_statement, it should be ALTER TABLE DDL statement. | `string` | `"CREATE TABLE IF NOT EXISTS dev (id STRING, data JSON, PRIMARY KEY (id))"` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | (Optioregionnal) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} | `map(string)` | `{}` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | A boolean that enables deletion protection for DynamoDB table | `bool` | `false` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_dynamodb_enabled"></a> [dynamodb\_enabled](#input\_dynamodb\_enabled) | Whether to create the DynamoDB table. | `bool` | `true` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | Override the name of the DynamoDB table which defaults to using `module.dynamodb_table_label.id` | `string` | `null` | no |
| <a name="input_enable_point_in_time_recovery"></a> [enable\_point\_in\_time\_recovery](#input\_enable\_point\_in\_time\_recovery) | Enable DynamoDB point-in-time recovery | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} | `map(string)` | `{}` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_is_auto_reclaimable"></a> [is\_auto\_reclaimable](#input\_is\_auto\_reclaimable) | (Optional) True if table can be reclaimed after an idle period. | `bool` | `false` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | (Optional) (Updatable) The OCID of a master encryption key used <br/>to call the Key Management service to generate a data encryption <br/>key or to encrypt or decrypt a data encryption key. | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Destination (S3 bucket name and prefix) for S3 Server Access Logs for the S3 bucket. | <pre>list(object({<br/>    target_bucket = string<br/>    target_prefix = string<br/>  }))</pre> | `[]` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | (Optional) (Updatable) Arbitrary string, up to 4KB, of keys and values for user-defined metadata. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_object_events_enabled"></a> [object\_events\_enabled](#input\_object\_events\_enabled) | (Optional) (Updatable) Whether or not events are emitted for object state changes in this bucket. By default, objectEventsEnabled is set to false. Set objectEventsEnabled to true to emit events for object state changes. For more information about events, see Overview of Events. | `bool` | `false` | no |
| <a name="input_oci_compartment_id"></a> [oci\_compartment\_id](#input\_oci\_compartment\_id) | The OCID of the compartment | `string` | n/a | yes |
| <a name="input_oci_fingerprint"></a> [oci\_fingerprint](#input\_oci\_fingerprint) | The fingerprint for the API key | `string` | n/a | yes |
| <a name="input_oci_namespace"></a> [oci\_namespace](#input\_oci\_namespace) | The name of the OCI namespace | `string` | `""` | no |
| <a name="input_oci_private_key_path"></a> [oci\_private\_key\_path](#input\_oci\_private\_key\_path) | The path to the private key file | `string` | n/a | yes |
| <a name="input_oci_region"></a> [oci\_region](#input\_oci\_region) | The OCI region to deploy resources in | `string` | `"eu-paris-1"` | no |
| <a name="input_oci_tenancy_ocid"></a> [oci\_tenancy\_ocid](#input\_oci\_tenancy\_ocid) | The OCID of the tenancy | `string` | n/a | yes |
| <a name="input_oci_user_ocid"></a> [oci\_user\_ocid](#input\_oci\_user\_ocid) | The OCID of the user | `string` | n/a | yes |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | List of policy statements to apply to the bucket. | `list(string)` | `[]` | no |
| <a name="input_public_access_type"></a> [public\_access\_type](#input\_public\_access\_type) | The type of public access for the bucket. Valid values are 'NoPublicAccess', 'ObjectRead', or 'ObjectReadWithoutList'. | `string` | `"NoPublicAccess"` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | DynamoDB read capacity units when using provisioned mode | `number` | `5` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_retention_rule_display_name"></a> [retention\_rule\_display\_name](#input\_retention\_rule\_display\_name) | (Optional) (Updatable) The display name of the retention rule. The name must be unique within the bucket and cannot be changed after the rule is created. | `string` | `"Retention Rule"` | no |
| <a name="input_retention_rule_duration_time_amount"></a> [retention\_rule\_duration\_time\_amount](#input\_retention\_rule\_duration\_time\_amount) | (Optional) (Updatable) The amount of time for the retention rule. The value must be a positive integer. | `number` | `1` | no |
| <a name="input_retention_rule_duration_time_unit"></a> [retention\_rule\_duration\_time\_unit](#input\_retention\_rule\_duration\_time\_unit) | (Optional) (Updatable) The unit of time for the retention rule. Allowed values are: Days, Months, Years. | `string` | `"Days"` | no |
| <a name="input_retention_rule_time_rule_locked"></a> [retention\_rule\_time\_rule\_locked](#input\_retention\_rule\_time\_rule\_locked) | (Optional) (Updatable) The date and time when the retention rule is locked, in RFC 3339 format. Use 'no date' to indicate no lock. | `string` | `null` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket name. If not provided, the name will be generated from the context by the label module. | `string` | `""` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_storage_tier"></a> [storage\_tier](#input\_storage\_tier) | The storage tier of the bucket. Valid values are 'Standard', 'InfrequentAccess', or 'Archive'. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_terraform_backend_config_file_name"></a> [terraform\_backend\_config\_file\_name](#input\_terraform\_backend\_config\_file\_name) | Name of the Terraform backend config file to generate. | `string` | `"terraform.tf"` | no |
| <a name="input_terraform_backend_config_file_path"></a> [terraform\_backend\_config\_file\_path](#input\_terraform\_backend\_config\_file\_path) | Directory for the Terraform backend config file. | `string` | `""` | no |
| <a name="input_terraform_backend_config_template_file"></a> [terraform\_backend\_config\_template\_file](#input\_terraform\_backend\_config\_template\_file) | The path to the template used to generate the config file. | `string` | `""` | no |
| <a name="input_terraform_state_file"></a> [terraform\_state\_file](#input\_terraform\_state\_file) | The path to the state file inside the bucket. | `string` | `"terraform.tfstate"` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The minimum required Terraform version. | `string` | `"1.0.0"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | The versioning status of the bucket. Valid values are 'Enabled' or 'Suspended'. | `string` | `"Enabled"` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | DynamoDB write capacity units when using provisioned mode | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_compartment_id"></a> [bucket\_compartment\_id](#output\_bucket\_compartment\_id) | The compartment ID of the OCI Object Storage bucket. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the OCI Object Storage bucket. |
| <a name="output_bucket_namespace"></a> [bucket\_namespace](#output\_bucket\_namespace) | The namespace of the OCI Object Storage bucket. |
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | DynamoDB table ARN |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | DynamoDB table ID |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | DynamoDB table name |
| <a name="output_terraform_backend_config"></a> [terraform\_backend\_config](#output\_terraform\_backend\_config) | Rendered Terraform backend config file. |
<!-- markdownlint-restore -->
