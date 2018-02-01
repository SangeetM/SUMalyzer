class ObservationParams

  def initialize(params, user:)
    @user = user
    @params = params.to_unsafe_h
  end

  def to_hash
    {
      comment: comment,
      patient_id: patient_id,
      city: location
    }
  end

  private

  def comment
    observation["comment"].to_s
  end

  def observation
    @params.fetch("observation", {})
  end

  def patient_id
    observation["patient_id"] ||
      begin
        user = @user.patients.detect { |patient| comment.include?(patient.name) } || Patient.new
        user.id
      end
  end

  def location
    locations = comment.split(" in ")

    if locations.size > 1
      locations.last.to_s.presence
    else
      nil
    end
  end

end
