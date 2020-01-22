class StoreController < ApplicationController
  def index #get the list of products out of db and make it available to the code in the view thatll display the table
    #we decided to order in alphabetical order
    @products = Product.order(:title)
  end
end
