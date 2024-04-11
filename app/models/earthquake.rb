class Earthquake < ApplicationRecord
  has_many :comments, foreign_key: 'feature_id' #relacion de uno a muchos con la tabla de comments
  self.inheritance_column = :type_inheritance #cambia el nombre de la columna de herencia para que type no sea una palabra reservada
  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }, numericality: { greater_than_or_equal_to: 0 } # valida que el id sea unico y que sea un numero entero
  # verifica que el id sea unico y que sea un numero entero
  before_validation :generate_id, on: :create #genera un id si no se le pasa uno
  validates :external_id, presence: true, uniqueness: true #valida haya el id externo y que sea unico para que no se repita en la base de datos
  validates :type, presence: true
  before_validation :set_default_type
  # validaciones que pide el reto
  validates :title, presence: true
  validates :external_url, presence: true
  validates :place, presence: true
  validates :mag_type, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :magnitude, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10.0 } #validaa que este entre -1 y 10
  validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 } # valida que este entre -90 y 90
  validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 } # valida que este entre -180 y 180


  private

  def set_default_type
    self.type ||= "feature"
  end
  def generate_id
    return unless id.blank?
    last_id = Earthquake.maximum(:id)
    self.id = last_id ? last_id + 1 : 1
  end
end
