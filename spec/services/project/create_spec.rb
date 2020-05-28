require 'rails_helper'

RSpec.describe Project::Create do
  describe '#call' do
    let(:name) { FFaker::Lorem.word.upcase }
    let(:price) { rand(100.2...1000.9).round(2) }
    let!(:project) { build :project, name: name, price: price }
    subject { described_class.perform(project) }

    context 'when project is valid' do
      it 'saves and returns node' do
        expect(subject.project.id).to be_present
        expect(subject.project.name).to eq(project.name)
        expect(subject.project.description).to eq(project.description)
        expect(subject.success?).to  be_truthy
      end
    end

    context 'when project isn`t valid' do
      it 'without a name' do
        project.name = nil
        expect(subject.success?).to  be_falsey
        expect(subject.errors).not_to be_empty
      end

      it 'without a price' do
        project.price = nil
        expect(subject.success?).to  be_falsey
        expect(subject.errors).not_to be_empty
      end
    end
  end
end