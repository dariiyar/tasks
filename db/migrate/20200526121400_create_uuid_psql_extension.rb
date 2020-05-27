class CreateUuidPsqlExtension < ActiveRecord::Migration[6.0]
  def self.up
    enable_extension 'pgcrypto'
  end

  def self.down
    disable_extension 'pgcrypto'
  end
end
