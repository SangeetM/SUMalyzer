require 'rails_helper'

RSpec.describe ObservationsController, type: :request do

  let!(:observation)  { create(:observation, user: user, comment: 'foo') }

  context 'with user authenticated' do
    include_context 'authenticated_user'

    describe 'GET /observations' do
      it 'lists observations' do
        get "/observations"
        expect(response.body).to include(observation.comment)
      end
    end

    describe 'GET /observations/new' do
      it 'renders form' do
        get "/observations/new"
        expect(response).to be_ok
      end
    end

    describe 'POST /observations' do
      context 'with meaningful data' do
        let(:patient) { create(:patient, user: user) }
        let(:params) do
          {
            observation: {
              comment: "#{patient.name} has too many cats",
            }
          }
        end

        it 'creates an observation' do
          expect{ post "/observations", params: params }
            .to change{ user.reload.observations.count }.by(1)
          expect(response.status).to eql 201
        end
      end
    end

    describe 'GET /observations/:id/edit' do
      context 'with meaningful ID value' do
        it 'renders edit page' do
          get "/observations/#{observation.id}/edit"
          expect(response).to be_ok
        end
      end

      context 'with ID not found in database' do
        let(:this_id_cannot_exist) { Observation.all.pluck(:id).sum }

        it 'renders 404' do
          get "/observations/#{this_id_cannot_exist}/edit"
          expect(response).to be_ok
        end
      end
    end

    describe 'PUT /observations/:id' do
      context 'with meaningful data' do
        let(:params) do
          {
            observation: {
              patient_id: observation.patient_id,
              comment: "#{observation.patient.name} has too many dogs"
            }
          }
        end

        it 'accepts update' do
          expect{ put "/observations/#{observation.id}", params: params }
            .to change{ observation.reload.comment }.from('foo').to("#{observation.patient.name} has too many dogs")
          expect(response.status).to eql 200
        end
      end
    end

    describe 'DELETE destroy' do
      it "destroys records" do
        expect{ delete "/observations/#{observation.id}" }
          .to change { Observation.count }.by(-1)
        expect(response.status).to eql 200
      end
    end

  end
end
