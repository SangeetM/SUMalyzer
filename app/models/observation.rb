class Observation < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  validates :patient_id, :user_id, presence: true
end
