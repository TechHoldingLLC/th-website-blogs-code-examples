resource "google_storage_bucket" "static_website" {
  provider = google-beta.google-beta

  name                        = "static-website"
  location                    = var.gcp_region
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

# Give all users public access to view objects in bucket
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.static_website.id
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
