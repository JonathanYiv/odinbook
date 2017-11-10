class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size 1.megabyte, message: "Is too large (Max: 1 MB)"
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', '/image/png']
  end
end