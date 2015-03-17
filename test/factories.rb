FactoryGirl.define do
	factory :player do
		email "playerfactory@example.com"
		password "ringaroundtherosie"
	end

  factory :game do
    name "Sprky Chess Game"
  end

  factory :pawn do
  end

  factory :rook do
  end

  factory :bishop do
  end

  factory :king do
  end
end