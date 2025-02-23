FactoryBot.define do
  factory :user do
    surname { "Popov" }
    name { "Alexandr" }
    patronymic { "Vladlenovich" }
    full_name { "Popov Alexander Vladlenovich" }
    email { "fake-mail@fake.com" }
    nationality { "Russian" }
    country { "Russia" }
    gender { "male" }
    age { 18 }
  end
end
