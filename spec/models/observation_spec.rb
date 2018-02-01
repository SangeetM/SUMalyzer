require 'rails_helper'

RSpec.describe Observation, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:patient) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:patient_id) }
end
