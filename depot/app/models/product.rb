class Product < ApplicationRecord
    validates :title, :description, :image_url, presence: true #presence: true tells the validator to check that each of the named field is present and the contents are not empty
    validates :price, numericality: {greater_than_or_equal_to: 0.01 }
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format: {
        with: %r{\. (gid|jpg|png)\Z}i,
        message: 'must be a url or gif or png'
    }
end
