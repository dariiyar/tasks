class Task < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
  validates :progress, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validate :estimate_date_in_the_future, :tasks_price_cannot_be_bigger_than_project_price, :urls_presence

  enum status: %i[initialized processing failed finished]
  validates :status, inclusion: { in: Task.statuses, message: 'is not valid type' }

  private

  def urls_presence
    errors.add(:urls, 'cannot be empty') if urls.empty?
  end

  def estimate_date_in_the_future
    return if estimate_date.nil?
    errors.add(:estimate_date, "can't be in the past") unless estimate_date.future?
  end

  def tasks_price_cannot_be_bigger_than_project_price
    not_valid = project.present? && ((project.tasks_price + price) > project.price)
    errors.add(:price, "project's total tasks price can't be bigger than project price") if not_valid
  end
end
