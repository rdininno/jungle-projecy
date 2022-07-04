require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(:name => "stuff")
    end

    it 'creates a product' do
      product = Product.new(
        :name => "robert",
        :price => 15,
        :quantity => 5,
        :category => @category
      )

      expect(product.save).to eq true
      expect(product.errors.messages).to be_empty
    end

    it 'gives an error when name is nil' do
      product = Product.new(
        :name => nil,
        :price => 15,
        :quantity => 5,
        :category => @category
      )

      product.save
      expect(product.errors.messages).to include(:name)
    end

    it 'gives an error when price is nil' do
      product = Product.new(
        :name => "name",
        :quantity => 5,
        :category => @category
      )

      product.save
      expect(product.errors.messages).to include(:price)
    end

    it 'gives an error when quantity is nil' do
      product = Product.new(
        :name => "name",
        :price => 5,
        :category => @category
      )

      product.save
      expect(product.errors.messages).to include(:quantity)
    end

    it 'gives an error when category is nil' do
      product = Product.new(
        :name => "name",
        :price => 5,
        :quantity => 15
      )

      product.save
      expect(product.errors.messages).to include(:category)
    end
  end
end

