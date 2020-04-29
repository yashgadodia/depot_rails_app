require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products 
  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    #...
    #...
  end

end
