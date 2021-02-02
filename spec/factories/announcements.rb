# frozen_string_literal: true

FactoryBot.define do
  factory :announcement do
    title	{ Faker::Lorem.sentence }
    content	{ Faker::Lorem.paragraph }
    announcement_type { Announcement::VALID_TYPES[rand(3)] }

    trait :draft do
      status { 0 }
    end

    trait :ready_to_publish do
      status { 1 }
    end

    trait :approved do
      status { 2 }
    end

    trait :rejected do
      status { 3 }
    end

    trait :published do
      status { 4 }
    end

    trait :archived do
      status { 5 }
    end
  end
end
