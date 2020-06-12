FactoryBot.define do
  factory :user do
    name { "TestAdmin" }
    email { "test@test.com" }
    password { "Test123!" }
    avatar{ nil }
    roles_mask { 4 }
  end

  factory :location do
    name { "TestAdmin" }
    email { "test@test.com" }
    password { "Test123!" }
    avatar{ nil }
    roles_mask { 4 }
  end
end
