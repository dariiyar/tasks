require 'rails_helper'

RSpec.describe File::Downloader do
  describe '#perform' do
    let(:url) { "https://fakesite.com/2.jpg" }
    let(:result) { subject.perform(url) }
    subject { described_class }

    context 'when url in the batch url is valid' do
      before do
        allow(URI).to receive(:open).and_return(File.open("#{Rails.root}/spec/support/files/1.jpg"))
      end
      it 'returns file' do
        expect(result.success?).to be_truthy
        expect(result.file).not_to be_nil
      end
    end
    context 'when url in the batch url is not valid' do
      it 'returns error' do
        expect(result.success?).to be_falsey
        expect(result.error).to include('HTTPError')
      end
    end
  end
end
