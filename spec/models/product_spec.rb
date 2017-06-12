require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @category = Category.new(name: "test")
    @params = { name: "test product", price: 123, quantity: 42 }
  end

  describe 'Validations' do
    it "should save given valid parameters" do
      @product = @category.products.new(@params)
      expect(@product.valid?).to be true
    end

    it "should not save given invalid name" do
      @params[:name] = nil
      @product = @category.products.new(@params)
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "should not save given invalid price" do
      @params[:price] = nil
      @product = @category.products.new(@params)
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "should not save given invalid quantity" do
      @params[:quantity] = nil
      @product = @category.products.new(@params)
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "should not save given invalid category" do
      @product = Product.new(@params)
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
