require 'rails_helper'

RSpec.describe File::AwsS3Uploader do
  describe '#perform' do
    let(:file) { File.open("#{Rails.root}/spec/support/files/1.jpg") }
    let(:task) { create(:task, project: project) }
    let(:file_name) { 'file.txt' }
    let(:bucket) { 'bucket' }
    let(:result) { subject.perform(bucket, file, file_name) }
    subject { described_class }

    context 'when S3 upload is successful' do
      it 'uploads the file' do
        allow_any_instance_of(Aws::S3::Object).to receive(:upload_file).and_return(true)
        expect(result.success?).to be_truthy
        expect(result.errors).to be_nil
      end
    end

    context 'when S3 upload is not successful' do
      it 'uploads the file' do
        expect(result.success?).to be_falsey
        expect(result.error).not_to be_nil
      end
    end
  end
end
