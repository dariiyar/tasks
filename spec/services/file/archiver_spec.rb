require 'rails_helper'

RSpec.describe File::Archiver do
  describe '#perform' do
    let(:file) { File.open("#{Rails.root}/spec/support/files/1.jpg") }
    let(:result) { subject.perform(file) }
    subject { described_class }

    context 'the newly created archive' do
      context 'with valid data' do
        it 'returns archive file' do
          expect(result.success?).to be_truthy
          expect(result.archive).not_to be_nil
        end
      end
      context 'with invalid data' do
        let!(:file) { nil }
        it 'returns error' do
          expect(result.success?).to be_falsey
          expect(result.error).not_to be_nil
        end
      end
    end

    context 'adding to already existing archive' do
      context 'with valid data' do
        let!(:archive) { result.archive }
        it 'returns archive file' do
          result = subject.perform(file, archive)
          expect(result.success?).to be_truthy
          expect(result.archive).not_to be_nil
        end
      end
      context 'with invalid data' do
        let!(:file) { nil }
        it 'returns error' do
          expect(result.success?).to be_falsey
          expect(result.error).not_to be_nil
        end
      end
    end
  end
end
