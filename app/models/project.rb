class Project < ApplicationRecord
  has_many :tasks

  validates :name, presence: true
  validates :price, presence: true

  def estimate_date
    tasks.order('tasks.estimate_date DESC').first.estimate_date unless tasks.empty?
  end

  def progress
    tasks.order('tasks.progress ASC').first.progress unless tasks.empty?
  end

  def status
    tasks.order('tasks.status ASC').first.status unless tasks.empty?
  end

  def task_count
    tasks.count unless tasks.empty?
  end
end
