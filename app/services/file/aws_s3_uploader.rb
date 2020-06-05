class File::AwsS3Uploader
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(bucket, file, file_name = nil)
    @bucket = bucket
    @file = file
    @file_name = file_name
    @error = nil
  end

  def perform
    upload_to_s3
    return OpenStruct.new(success?: true) if @error.nil?
    OpenStruct.new(success?: false, error: @error)
  end

  private

  def upload_to_s3
    s3 = Aws::S3::Resource.new
    @file_name ||= File.basename(@file)
    obj = s3.bucket(@bucket).object(@file_name)
    obj.upload_file(File.open(@file))
  rescue StandardError => e
    @error = "File::AwsS3Uploader: #{e.class} => #{e.message}"
  end
end
