class Sensor < ActiveRecord::Base
  enum kind: %i(binary digital)

  belongs_to :group

  has_many :listeners, dependent: :destroy
  has_many :routines, through: :listeners

  validates :kind, presence: true
  validates :name, presence: true, uniqueness: { scope: :group }
  validates :group, presence: true
end
