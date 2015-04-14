FactoryGirl.define do
  factory :player do
    sequence :email do |n|
      "playerfactory#{n}@example.com"
    end
    password 'ringaroundtherosie'
    password_confirmation 'ringaroundtherosie'
  end
  
  factory :invitation do
  end

  factory :game do
  end

  factory :pawn do
  end

  factory :rook do
  end

  factory :bishop do
  end

  factory :knight do
  end

  factory :king do
  end

  factory :queen do
  end
end
