require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
      :email => "MyString@mail.com",
      :password => "Password",
      :password_confirmation => "Password",
      :firstname => "Firstname",
      :lastname => "Lastname"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/mystring\@mail\.com/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
  end
end
