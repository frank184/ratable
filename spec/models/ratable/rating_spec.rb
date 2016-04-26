require 'rails_helper'

describe Ratable::Rating, type: :model do
  it "is empty when created" do
    raiting = Ratable::Rating.new
    attributes_are_nil = true
    rating.attributes.each do |k,v|
      attributes_are_nil = rating.k == nil
    end
    expect(attributes_are_nil).to be_truthy
  end
end
