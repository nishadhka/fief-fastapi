provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.terraform_sa_key)  # Add this
}

# Create custom role
resource "google_project_iam_custom_role" "custom_role" {
  role_id     = var.role_id
  title       = var.role_title
  description = var.role_description
  permissions = var.role_permissions
  stage       = "GA"
}

# Create service account
resource "google_service_account" "custom_sa" {
  account_id   = var.service_account_id
  display_name = var.role_title
  description  = var.role_description
}

# Assign custom role to service account
resource "google_project_iam_member" "custom_sa_binding" {
  project    = var.project_id
  role       = google_project_iam_custom_role.custom_role.name
  member     = "serviceAccount:${google_service_account.custom_sa.email}"
}

# Generate service account key
resource "google_service_account_key" "custom_sa_key" {
  service_account_id = google_service_account.custom_sa.id
  public_key_type    = var.public_key_type
  key_algorithm      = var.key_algorithm
}

# Save the key to a file
resource "local_file" "sa_key_file" {
  content         = base64decode(google_service_account_key.custom_sa_key.private_key)
  filename        = var.key_file_path
  file_permission = "0600"
}

# Outputs
output "service_account_email" {
  value       = google_service_account.custom_sa.email
  description = "The email of the service account"
}

output "key_file_location" {
  value       = var.key_file_path
  description = "Location of the service account key file"
}

