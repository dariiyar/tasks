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
      upload_archive if create_archive
    rescue StandardError => e
      @errors << "Task: #{@task.id} - #{e.class} => #{e.message}"
    end
    result = @errors.present? ? OpenStruct.new(success?: false, errors: @errors) : OpenStruct.new(success?: true)
    update_task(result)
    result
  end

  private

  def create_archive
    @task.processing!
    @task.urls.each { |url| download_file(url) }
    @errors.empty?
  end

  def download_file(url)
    downloader = File::Downloader.perform(url)
    if downloader.success?
      archiver = File::Archiver.perform(downloader.file, @archive)
      archiver.success? ? @archive = archiver.archive : @errors << archiver.error
    else
      @errors << downloader.error
    end
  end

  def upload_archive
    uploader = File::AwsS3Uploader.perform(ENV['AWS_TASKS_BUCKET'], @archive, "urls_#{@task.id}.zip")
    @errors << uploader.error unless uploader.success?
  end

  def update_task(result)
    result.success? ? @task.finished! : @task.failed!
  end
end
