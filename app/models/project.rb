class Project < ApplicationRecord
  has_many :tasks

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: :tasks_price }

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

  def tasks_price
    return 0 if tasks.empty?
    tasks_prices = tasks.map(&:price).reject(&:nil?)
    tasks_prices.empty? ? 0 : tasks_prices.sum
  end
end
