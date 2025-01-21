resource "google_storage_bucket" "static_website" {
  provider = google-beta.google-beta

  name                        = "static-website-1234567"
  location                    = var.gcp_region
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
}

resource "google_storage_bucket_object" "index_file" {
  name   = "index.html"
  source = "index.html"
  bucket = google_storage_bucket.static_website.id
}

resource "google_storage_bucket_object" "error_file" {
  name   = "error.html"
  source = "error.html"
  bucket = google_storage_bucket.static_website.id
}

# Give all users public access to view objects in bucket
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.static_website.id
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
