# Define provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create Terraform admin service account
resource "google_service_account" "terraform_admin" {
  account_id   = var.sa_name
  display_name = "Terraform Admin SA"
  description  = "Terraform admin service account"
}

# Assign roles to the Terraform admin service account using a loop
resource "google_project_iam_member" "role_binding" {
  for_each = toset(var.roles)

  project = var.project_id
  member  = "serviceAccount:${google_service_account.terraform_admin.email}"
  role    = each.value
}

# Generate service account key
resource "google_service_account_key" "terraform_admin_key" {
  service_account_id = google_service_account.terraform_admin.id
  public_key_type    = var.public_key_type
  key_algorithm      = var.key_algorithm
}

# Save the key to a file
resource "local_file" "sa_key_file" {
  content         = base64decode(google_service_account_key.terraform_admin_key.private_key)
  filename        = var.key_file_path
  file_permission = "0600"
}

# Outputs
output "service_account_email" {
  value       = google_service_account.terraform_admin.email
  description = "The email of the Terraform admin service account"
}

output "key_file_location" {
  value       = var.key_file_path
  description = "Location of the Terraform admin service account key file"
}

