variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "role_id" {
  description = "ID for the custom role"
  type        = string
}

variable "service_account_id" {
  description = "ID for the service account"
  type        = string
}

variable "key_file_path" {
  description = "Path where the service account key file will be saved"
  type        = string
}

variable "terraform_sa_key" {
  description = "Path to the Terraform service account key file"
  type        = string
}

variable "role_title" {
  description = "Title of the custom role"
  type        = string
}

variable "role_description" {
  description = "Description of the custom role"
  type        = string
  default     = "Access to create Cloud Run, Storage, and Artifact Registry resources"
}

variable "role_permissions" {
  description = "List of permissions for the custom role"
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
