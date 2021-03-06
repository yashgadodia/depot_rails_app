#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.

#product model is responsible for mainitaining the state of the application. Sometimes this state is transient
#lasting for jsust a couple of interactions with the user. sometimes the state is permanenet,
#and is stores outside the application, often in a database. 

#a model is more than data, it enforces all the business rules that apply to that data
#the model acts as both a datekeeper and a data store. 
#---
class Product < ApplicationRecord
    has_many :line_items

    before_destroy :ensure_not_referenced_by_any_line_item
    private

    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            error.add(:base, 'Line Items present')
            throw :abort
        end
    end
    
    #validates() method is the standard rails rails Validator. it checks ome or more model fields against 
    #one or more conditions. 
    validates :title, :description, :image_url, presence: true #validates method
    #presence checks that each of the named field is present and the contents arent empty
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
    validates :title, uniqueness: true #each product has a unique title
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
    }
end
