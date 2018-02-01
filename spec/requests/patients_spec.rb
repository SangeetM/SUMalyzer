require 'rails_helper'

RSpec.describe PatientsController, type: :request do

  context 'with user authenticated' do
    let(:patient) { create(:patient, user: user, name: 'foo') }

    include_context 'authenticated_user'

    describe 'GET /patients/new' do
      it 'renders form' do
        get "/patients/new"
        expect(response).to be_ok
      end
    end

    describe 'POST /patients' do
      context 'with meaningful data' do
        let(:params) do
          {
            patient: {
              name: 'Catfish',
              birthday: '01.02.2010'
            }
          }
        end

        it 'creates a patient' do
          expect{ post "/patients", params: params }
            .to change{ Patient.count }.by(1)
          expect(response.status).to eql 302
        end
      end
    end

    describe 'GET /patients/:id/edit' do
      context 'with meaningful ID value' do
        it 'renders edit page' do
          get "/patients/#{patient.id}/edit"
          expect(response).to be_ok
        end
      end

      context 'with ID not found in database' do
        let(:this_id_cannot_exist) { Patient.all.pluck(:id).sum }

        it 'renders 404' do
          expect{ get "/patients/#{this_id_cannot_exist}/edit" }
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe 'PUT /patients/:id' do
      before { patient }

      context 'with meaningful data' do
        let(:params) do
          {
            patient: {
              name: 'David'
            }
          }
        end

        it 'accepts update' do
          expect{ put "/patients/#{patient.id}", params: params }
            .to change{ patient.reload.name }.from('foo').to('David')
          expect(response.status).to eql 302
        end
      end
    end

    describe 'DELETE destroy' do
      before { patient }

      it "destroys records" do
        expect{ delete "/patients/#{patient.id}" }
          .to change { user.reload.patients.count }.by(-1)
        expect(response.status).to eql 302
      end
    end

  end
end
