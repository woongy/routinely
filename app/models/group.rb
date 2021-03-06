class Group < ActiveRecord::Base
  store_accessor :nodered_config, :mqtt_broker, :rx_subflow, :tx_subflow

  has_many :users, dependent: :destroy
  has_many :routines, dependent: :destroy
  has_many :sensors, dependent: :destroy
  has_many :actors, dependent: :destroy

  has_many :rule_based_routines, dependent: :destroy
  has_many :time_based_routines, dependent: :destroy
  has_many :periodic_routines, dependent: :destroy
  has_many :dependent_routines, dependent: :destroy
  has_many :dependent_routine_events, through: :dependent_routines, source: :events do
    def on_start; merge(Event.started); end
  end

  validates :name, presence: true, uniqueness: true
  validates :synced, inclusion: { in: [true, false] }
end
