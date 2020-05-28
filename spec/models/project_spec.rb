require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = FFaker::Lorem.word.upcase
    subject.price = rand(100.2...1000.9).round(2)
    subject.description = FFaker::Lorem.sentence
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.price = rand(100.2...1000.9).round(2)
    subject.description = FFaker::Lorem.sentence
    expect(subject).not_to be_valid
  end
  it "is not valid without a price" do
    subject.name = FFaker::Lorem.word.upcase
    subject.description = FFaker::Lorem.sentence
    expect(subject).not_to be_valid
  end
end
