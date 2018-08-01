class Product < ApplicationRecord
  validates :title, uniqueness: true, length: { minimum: 5 }
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
