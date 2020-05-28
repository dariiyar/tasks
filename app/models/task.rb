class Task < ApplicationRecord
  belongs_to :project

  enum status: %i[initialized processing failed finished]
end
