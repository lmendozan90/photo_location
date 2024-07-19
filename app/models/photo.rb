require "exifr/jpeg"

class Photo < ApplicationRecord
  has_one_attached :image

  after_commit :extract_metadata, on: :create

  private
  def extract_metadata
    return unless image.attached?

    image_path = ActiveStorage::Blob.service.path_for(image.key)
    exif = EXIFR::JPEG.new(image_path)

    if exif&.gps
      self.latitude = exif.gps.latitude
      self.longitude = exif.gps.longitude
      save
    end
  end
end
