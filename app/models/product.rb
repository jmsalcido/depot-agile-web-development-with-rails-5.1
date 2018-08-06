class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  # validations
  validates :title, uniqueness: true, length: { minimum: 5, message: "'%{value}' size is not the minimum of: %{count}"}
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  private

  def ensure_not_referenced_by_any_line_item
    return false if line_items.empty?
    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
