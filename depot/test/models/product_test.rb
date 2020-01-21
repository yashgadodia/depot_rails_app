#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products 
  test "product attributes must not be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "product price must be positive" do
    product = Product.new(title: "My Book Title",
                          description: "xyz",
                          image_url: "xxx.jpeg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than equal to 0.01"],
        product.errors[:price]

    product.price = 1
    assert product.valid?
  end
  def new_product(image_url)
    Product.new( title: "My book title",
                  description: "wxy",
                  price: 1,
                  image_url: image_url)
  end
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
    http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_url|
      assert new_product(image_url).valid?,
      "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?,
      "#{image_url} shouldn't be valid"
    end
  end           
end
