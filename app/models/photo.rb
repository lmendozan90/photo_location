require "exifr/jpeg"

class Photo < ApplicationRecord
  has_one_attached :image

  after_save :extract_metadata

  private
  def extract_metadata
    return unless image.attached?

    image_path = ActiveStorage::Blob.service.send(:path_for, image.key)
    exif = EXIFR::JPEG.new(image_path)

    if exif.gps
      self.latitude = exif.gps.latitude
      self.longitude = exif.gps.longitude
    end
  end
end
