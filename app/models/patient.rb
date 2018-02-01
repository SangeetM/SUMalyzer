class Patient < ApplicationRecord
  belongs_to :user
  has_many :observations
  validates :name, :birthday, :user_id, presence: true
end
