require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:birthday) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:observations) }
end
