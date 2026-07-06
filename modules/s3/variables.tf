variable "s3_buckets_list" {
  description = "List of the name of s3_buckets"
  type        = list(string)

  validation {
    condition = length(var.s3_buckets_list) > 0

    error_message = "Atleast one bucket should be created."
  }

  validation {
    condition = alltrue([
      for bucket in var.s3_buckets_list :
      can(regex(
        "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$",
        bucket
      ))

    ])
    error_message = "The bucket name only consists of alphanumerics and '-'s."
  }
}