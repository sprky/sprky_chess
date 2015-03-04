FactoryGirl.define do
	factory :player do
		email "playerfactory@example.com"
		password "ringaroundtherosie"
	end

  factory :game do
    name "Sprky Chess Game"
  end
end