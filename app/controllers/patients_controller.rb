class PatientsController < ApplicationController

  before_action :find_resource, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!

  helper_method :collection, :resource

  def index
  end

  def new
  end

  def create
    if current_user.patients.create(patient_params).persisted?
      redirect_to patients_path, notice: "Patient created."
    else
      render :new, alert: "Cannot save patient: #{resource.errors.full_messages.join}"
    end
  end

  def edit
  end

  def update
    if resource.update(patient_params)
      redirect_to patients_path, notice: "Patient updated."
    else
      render :edit, alert: "Cannot save patient: #{resource.errors.full_messages.join}"
    end
  end

  def destroy
    response_information =
      if resource.destroy
        { notice: "Patient record deleted." }
      else
        { alert: "Cannot delete patient!" }
      end

    redirect_to patients_path, response_information
  end


  private

  def find_resource
    raise ActiveRecord::RecordNotFound unless resource.persisted?
  end

  def collection
    @patients ||= current_user.patients
  end

  def resource
    @patient ||=
      (current_user.patients.find_by(id: params[:id]) || Patient.new)
  end

  def patient_params
    params
      .require(:patient)
      .permit(:name, :birthday, :gender, :avatar)
  end

end
