require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do 
    it 'should have a name, price, quantity, and category' do
      @category = Category.new
      @product = @category.products.new({name: 'name', price: 10, quantity: 5, category: @category})
      expect(@product.save).to be_truthy
    end

    it 'should fail if no name' do
      @category = Category.new
      @product = @category.products.new({name: nil, price: 10, quantity: 5, category: @category})
      @product.valid?
      expect(@product.errors[:name]).to contain_exactly("can't be blank")

    end

    it 'should fail if no price' do
      @category = Category.new
      @product = @category.products.new({name: 'name', price: nil, quantity: 5, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")

    end

    it 'should fail if no quantity' do
      @category = Category.new
      @product = @category.products.new({name: 'name', price: 10, quantity: nil, category: @category})
      expect(@product.save).to be_falsy
      expect(@product.errors.full_messages).to contain_exactly("Quantity can't be blank")

    end

    it 'should fail if no category' do
      @product = Product.new({name: 'name', price: 10, quantity: 5, category: nil})
      expect(@product.save).to be_falsy
      expect(@product.errors.full_messages).to contain_exactly("Category can't be blank")
    end

  end 
end
