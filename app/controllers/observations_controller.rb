class ObservationsController < ApplicationController

  before_action :find_resource, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  helper_method :collection, :resource

  def index
  end

  def new
  end

  def create
    response_information =
      if current_user.observations.create(observation_params).persisted?
        { status: 201, notice: "Beobachtungseintrag erstellt." }
      else
        { status: 422, alert: "Daten konnten nicht gespeichert werden: #{resource.errors.full_messages.join}" }
      end

    render :index, response_information
  end

  def edit
  end

  def update
    response_information =
      if resource.update(observation_params)
        { status: 200, notice: "Beobachtungseintrag aktualisiert." }
      else
        { status: 422, alert: "Daten konnten nicht gespeichert werden: #{resource.errors.full_messages.join}" }
      end

    render :index, response_information
  end

  def destroy
    response_information =
      if resource.destroy
        { status: 200, notice: "Beobachtungseintrag wurde gelöscht." }
      else
        { status: 422, alert: "Daten konnten nicht gelöscht werden!" }
      end

    render :index, response_information
  end


  private

  def collection
    @observations ||= current_user.observations.all
  end

  def find_resource
    raise ActiveRecord::RecordNotFound unless resource.persisted?
  end

  def resource
    @observation ||=
      (current_user.observations.find_by(id: params[:id]) || Observation.new)
  end

  def observation_params
    ObservationParams.new(params, user: current_user).to_hash
  end

end
