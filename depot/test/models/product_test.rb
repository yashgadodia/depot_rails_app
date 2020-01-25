#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---
require 'test_helper'

#fixtures() directive loads the fixture data corresponsing to the given model name into the corresponding
#database table before each test method in the test case is run.
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
  #in this code we create a new product and then try setting its price to -1,0 and +1,
  #validating the product each time. if our model is working, the first two should be invalid. 
  #and we verify that the error mesasage associated with the price attribute is what we expect. 
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
  #validate the image url ends with .gif .jpg, .png
  def new_product(image_url)
    Product.new(title: "My book title",
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
  test "product is not valid without a unique title" do
    product = Product.new(title:       products(:ruby).title,
                          description: "yyyy",
                          price:       1,
                          image_url:   "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end  
  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:       products(:ruby).title,
                          description: "yyy",
                          price:       1,
                          image_url:   "fred.gif")

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end    
end
