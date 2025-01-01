
# Project ID variable
variable "project_id" {
  description = "The project ID to use."
  type        = string
}

# Region variable
variable "region" {
  description = "The region to use."
  type        = string
}

# Service account name variable
variable "sa_name" {
  description = "The name of the Terraform admin service account."
  type        = string
}


variable "key_file_path" {
  description = "Path where the service account key file will be saved"
  type        = string
}


variable "roles" {
  description = "List of roles to assign to the Terraform admin service account"
  type        = list(string)
}


variable "public_key_type" {
  description = "Type of public key to generate for the service account"
  type        = string
}

variable "key_algorithm" {
  description = "Key algorithm to use for the service account key"
  type        = string
}

