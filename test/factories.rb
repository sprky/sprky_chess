FactoryGirl.define do
	factory :player do
    sequence :email do |n|
  		"playerfactory#{n}@example.com"
	  end
  	password "ringaroundtherosie"
    password_confirmation "ringaroundtherosie"
	end

  factory :game do
    name "Sprky Chess Game"
  end

  factory :pawn do
  end

  factory :rook do
  end
end