require 'features/features_spec_helper'
  
feature 'order_items management' do

  background do
    @book = FactoryGirl.create :book
  end

  scenario 'push order_item to cookies' do
    visit book_path(@book)
    click_button 'Add to Cart'
    expect(page).to have_content "\"#{@book.title}\" was added to the cart"
  end

  scenario 'browse order_items in the cart' do
    @another_book = FactoryGirl.create :book
    
    visit book_path(@book)
    click_button 'Add to Cart'
    visit book_path(@another_book)
    click_button 'Add to Cart'
    visit order_items_index_path
    expect(page).to have_content "#{@book.title}"
    expect(page).to have_content "#{@another_book.title}"
  end
  
end