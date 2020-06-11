FactoryBot.define do
    sequence :email do |n|
        "person#{n}@example.com"
    end
    sequence :name do |n|
        "person#{n}"
    end
    factory :user do |n|
      name 
      email 
      roles_mask {1}
      password { "Passw0rd!"} 
      password_confirmation { "Passw0rd!" }
      factory :user_with_categories do
        association :categories
      end
    end
    factory :location do
        name {""}
        user
        street {"test"}
        lat {1}
        long {1}
        factory :location_with_categories do
            association :categories
        end
    end
    factory :category do
        name {"ciao"}
    end
  end