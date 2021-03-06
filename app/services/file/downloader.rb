class File::Downloader
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(url)
    @url = url
    @error = nil
  end

  def perform
    download_file
    @error.present? ? OpenStruct.new(success?: false, error: @error) : OpenStruct.new(success?: true, file: @tempfile)
  end

  private

  def download_file
    filename = File.basename(@url)
    @tempfile = Tempfile.new(filename)
    begin
      File.open(@tempfile.path, 'wb') do |file|
        file.write URI.open(@url).read
      end
    rescue StandardError => e
      @error = "File: #{filename} - #{e.class} => #{e.message}"
    end
  end
end
