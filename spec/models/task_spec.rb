require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:project) { create(:project_with_tasks) }
  subject { build(:task, project: project) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it 'is not valid when urls array is empty' do
    subject.urls = []
    expect(subject).not_to be_valid
  end
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end
  it 'is not valid when estimate date in past' do
    subject.estimate_date = Date.today - 1.day
    expect(subject).not_to be_valid
  end
  it 'is not valid when total tasks price is bigger that project price' do
    subject.price = project.price + 1
    expect(subject).not_to be_valid
  end
  it 'is not valid with wrong status' do
    subject.status = :some_status
    expect(subject).not_to be_valid
  end
  it 'is not valid with non integer progress field' do
    subject.progress = 1.0
    expect(subject).not_to be_valid
  end
  it 'is not valid if progress is less than 0' do
    subject.progress = -1
    expect(subject).not_to be_valid
  end
  it 'is not valid if progress is bigger than 100' do
    subject.progress = 101
    expect(subject).not_to be_valid
  end
end
