class Comment < ApplicationRecord
  belongs_to :earthquake, foreign_key: 'feature_id', class_name: 'Earthquake' #relacion de uno a muchos con la tabla de earthquakes

  validates :feature_id, presence: true, numericality: { only_integer: true }, numericality: { greater_than_or_equal_to: 0 }
  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }, numericality: { greater_than_or_equal_to: 0 }
  validates :body, presence: true, length: { minimum: 10 }

  before_validation :generate_id, on: :create

  def generate_id
    return unless id.blank?
    last_id = Comment.maximum(:id)
    self.id = last_id ? last_id + 1 : 1
  end

end
