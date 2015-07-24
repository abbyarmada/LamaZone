require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryGirl.create :book }

  [:title, :price, :books_in_stock].each do |item|
    it "is invalid without #{item}" do
      expect(book).to validate_presence_of item
    end
  end
  
  it "is valid only when price is numerical and greater than 0" do
    expect(book).to validate_numericality_of(:price).
      is_greater_than 0
  end

  it "is valid only when books_in_stock is numerical, integer 
    and greater than or equal 0" do
    expect(book).to validate_numericality_of(:books_in_stock).
      is_greater_than_or_equal_to(0).only_integer
  end

  [:author, :category].each do |item|
    it "belongs to #{item}" do
      expect(book).to belong_to item
    end
  end

  it "has many ratings" do
    expect(book).to have_many :ratings
  end
end
