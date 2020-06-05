class Task::UrlsS3ArchiveUploader
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(task)
    @task = task
    @errors = []
    @archive = nil
  end

  def perform
    begin
      create_archive
      upload_archive if @errors.empty?
    rescue StandardError => e
      @errors << "Task: #{@task.id} - #{e.class} => #{e.message}"
    end
    return OpenStruct.new(success?: true) if @errors.empty?
    OpenStruct.new(success?: false, errors: @errors)
  end

  private

  def create_archive
    @task.urls.each do |url|
      downloader = File::Downloader.perform(url)
      if downloader.success?
        archiver = File::Archiver.perform(downloader.file, @archive)
        archiver.success? ? @archive = archiver.archive : @errors << archiver.error
      else
        @errors << downloader.error
      end
    end
  end

  def upload_archive
    uploader = File::AwsS3Uploader.perform(ENV['AWS_TASKS_BUCKET'], @archive, "urls_#{@task.id}.zip")
    @errors << uploader.error unless uploader.success?
  end
end
