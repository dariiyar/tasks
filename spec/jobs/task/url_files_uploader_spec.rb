require 'rails_helper'

describe Task::UrlFilesUploaderJob do
  subject {Task::UrlFilesUploaderJob}
  let(:task) {create(:task)}

  it { is_expected.to be_processed_in :default }
  it 'call proper services' do
    subject.perform_async(task.id)
  end

end