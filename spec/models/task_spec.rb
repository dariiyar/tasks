require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = FFaker::Lorem.word.upcase
    subject.project = FactoryBot.create(:project)
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    expect(subject).not_to be_valid
  end
end
