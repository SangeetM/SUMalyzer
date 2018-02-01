require 'rails_helper'

RSpec.describe ObservationParams, type: :model do


  let(:user) { create(:user) }
  let(:comment) { "" }
  let(:params) { ActionController::Parameters.new(observation: { comment: comment }) }
  let!(:patient) { create(:patient, user: user, name: 'Guybrush') }

  subject { described_class.new(params, user: user) }

  context 'with patient mentioned' do
    let(:comment) { "Guybrush was ill" }
    it { expect(subject.to_hash[:patient_id]).to eql patient.id }
    it { expect(subject.to_hash[:city]).to eql nil }
  end

  context 'with location mentioned' do
    let(:comment) { "Guybrush was ill in Berlin" }
    it { expect(subject.to_hash[:city]).to eql "Berlin" }
  end

end
