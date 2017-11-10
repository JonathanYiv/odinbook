require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

s3_options = {
  access_key_id:      ENV['AWS_ACCESS_KEY'],
  secret_access_key:  ENV['SECRET_ACCESS_KEY'],
  region:             "us-east-1",
  bucket:             ENV['S3_BUCKET_NAME']
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :rack_file # for non-Rails apps

# Adds validation helpers
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type