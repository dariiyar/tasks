class File::Archiver
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(file, archive = nil)
    @file = file
    @archive = archive
  end

  def perform
    begin
      @archive.present? ? add_to_existing : create_new
    rescue StandardError => e
      error = "File::Archiver #{File.basename('' || @file&.path)} - #{e.class} => #{e.message}"
      return OpenStruct.new(success?: false, error: error)
    end
    OpenStruct.new(success?: true, archive: @archive)
  end

  private

  def create_new
    path = @file.path
    @archive = Tempfile.new("#{SecureRandom.hex}.zip")
    ::Zip::OutputStream.open(@archive) { |zos| }
    ::Zip::File.open(@archive.path, Zip::File::CREATE) do |zip|
      zip.add(File.basename(path), path)
    end
  end

  def add_to_existing
    new_name = check_duplicate_name
    path = @file.path
    ::Zip::File.open(@archive.path, Zip::File::CREATE) do |zip|
      new_name ||= File.basename(path)
      zip.add(new_name, path)
    end
  end

  def check_duplicate_name
    is_valid = true
    path = @file.path
    name = File.basename(path)
    extension = File.extname(path)
    ::Zip::File.foreach(@archive.path) { |file| is_valid = file.name != name }
    return if is_valid
    File.basename(path, extension) + '_' + SecureRandom.hex(6) + extension
  end
end
