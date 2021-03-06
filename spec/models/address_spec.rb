require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryGirl.create :address }

  [:firstname, 
   :lastname, 
   :phone, 
   :address1, 
   :city, 
   :zipcode, 
   :country_id].each do |item|
    it "is invalid without #{item}" do
      expect(address).to validate_presence_of item
    end
  end
  
  context "with phone validation" do
    it "is valid when phone is plausible" do
      expect(Phony.plausible?(address.phone)).to eq true
    end
  end

  it "belongs to country" do
    expect(address).to belong_to :country
  end

  it "is using #normalize_phone as a callback before save" do
    expect(address).to callback(:normalize_phone).before(:save)
  end

  context "#custom_label_method" do
    it "returns string with city, address1 and address2" do
      expect(address.send(:custom_label_method)).
        to eq "#{address.city} #{address.address1} #{address.address2}"
    end
  end
  
  context "#normalize_phone" do
    it "normalizes phone" do
      norm_phone = Phony.normalize(address.phone)
      expect(Phony).to receive(:normalize!).with(address.phone).
        and_return(norm_phone)
      address.send(:normalize_phone)
    end
  end

  context "#country_code" do
    it "returns alpha2 code of country address belongs to" do
      expect(address.send(:country_code)).
        to eq Country.find(address.country_id).alpha2
    end
  end
end
