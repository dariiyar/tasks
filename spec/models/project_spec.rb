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

  it 'is not valid when price less then 0' do
    subject.price = -1
    expect(subject).not_to be_valid
  end

  context "price validator" do
    subject { Project.first }
    before(:each) do
      create(:project_with_tasks)
    end

    it 'price should not be less then total tasks price' do
      subject.price = subject.tasks_price - 1
      expect(subject).not_to be_valid
    end
  end
end
