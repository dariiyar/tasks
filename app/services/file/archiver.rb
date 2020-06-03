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
      @error = "File::Archiver #{File.basename(@file.path) unless @file.nil?} - #{e.class} => #{e.message}"
    end
    return OpenStruct.new(success?: true, archive: @archive) if @error.nil?
    OpenStruct.new(success?: false, error: @error)
  end

  private

  def create_new
    @archive = Tempfile.new("#{SecureRandom.hex}.zip")
    ::Zip::OutputStream.open(@archive) { |zos| }
    ::Zip::File.open(@archive.path, Zip::File::CREATE) do |zip|
      zip.add(File.basename(@file.path), @file.path)
    end
  end

  def add_to_existing
    new_name = check_duplicate_name
    ::Zip::File.open(@archive.path, Zip::File::CREATE) do |zip|
      new_name ||= File.basename(@file.path)
      zip.add(new_name, @file.path)
    end
  end

  def check_duplicate_name
    is_valid = true
    name = File.basename(@file.path)
    extension = File.extname(@file.path)
    ::Zip::File.foreach(@archive.path) { |f| is_valid = f.name != name }
    return if is_valid
    File.basename(@file.path, extension) + '_' + SecureRandom.hex(6) + extension
  end
end
