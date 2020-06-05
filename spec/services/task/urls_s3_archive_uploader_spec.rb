require 'rails_helper'

RSpec.describe Task::UrlsS3ArchiveUploader do
  describe '#perform' do
    let(:project) { create(:project) }
    let(:task) { create(:task, project: project) }
    let(:result) { subject.new(task).perform }
    subject { described_class }

    context 'when all services are successful' do
      it 'creates uploads archive' do
        allow(File::Downloader).to receive(:perform).and_return(OpenStruct.new(success?: true))
        allow(File::Archiver).to receive(:perform).and_return(OpenStruct.new(success?: true))
        allow(File::AwsS3Uploader).to receive(:perform).and_return(OpenStruct.new(success?: true))

        expect(File::Downloader).to receive(:perform)
        expect(File::Archiver).to receive(:perform)
        expect(File::AwsS3Uploader).to receive(:perform)
        expect_any_instance_of(Task).to receive(:processing!)
        expect(result.success?).to be_truthy
        expect(result.errors).to be_nil
        expect(task.reload.status).to eq('finished')
      end
    end

    context 'when File::Downloader is not successful' do
      it 'returns error' do
        allow(File::Downloader).to receive(:perform).and_return(OpenStruct.new(success?: false, error: 'error'))

        expect(File::Archiver).not_to receive(:perform)
        expect(File::AwsS3Uploader).not_to receive(:perform)
        expect(result.success?).to be_falsey
        expect(result.errors).not_to be_nil
        expect(task.reload.status).to eq('failed')
      end
    end

    context 'when File::Archiver is not successful' do
      it 'returns error' do
        allow(File::Downloader).to receive(:perform).and_return(OpenStruct.new(success?: true))
        allow(File::Archiver).to receive(:perform).and_return(OpenStruct.new(success?: false, error: 'error'))

        expect(File::AwsS3Uploader).not_to receive(:perform)
        expect(result.success?).to be_falsey
        expect(result.errors).not_to be_nil
      end
    end

    context 'when File::AwsS3Uploader is not successful' do
      it 'returns error' do
        allow(File::Downloader).to receive(:perform).and_return(OpenStruct.new(success?: true))
        allow(File::Archiver).to receive(:perform).and_return(OpenStruct.new(success?: true))
        allow(File::AwsS3Uploader).to receive(:perform).and_return(OpenStruct.new(success?: false, error: 'error'))

        expect(result.success?).to be_falsey
        expect(result.errors).not_to be_nil
        expect(task.reload.status).to eq('failed')
      end
    end
  end
end
