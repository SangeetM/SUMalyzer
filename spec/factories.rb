FactoryGirl.define do

  factory :patient do
    name "Holly"
    birthday 10.years.ago
    user
  end

  factory :observation do
    comment "Today was a good day"
    patient
    user
  end

  factory :user do
    email { "#{["mick", "werner", "elisabeth"].sample}.#{["meyer", "schmidt", "treibholz"].sample}-#{rand(1000)}@SUMalyzer.org" }
    password "abc-123"
  end

end
