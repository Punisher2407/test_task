require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  describe '.run' do
    let(:params) do
      {
        surname: 'Panysh',
        name: 'Denis',
        patronymic: 'Sergeevich',
        email: 'fake-mail@fake.com',
        nationality: 'Belarussian',
        country: 'Belarus',
        gender: 'male',
        age: 22,
        interests: ['Dancing', 'Football', 'Bowling', 'Music'],
        skills: ['Ruby on Rails', 'PostgreSQL', 'Rspec', 'Here can be yours Ads.']
      }
    end

    context 'when user is valid' do
      before do
        create(:interest, name: 'Dancing')
        create(:skill, name: 'Ruby on Rails')
      end

      it 'creates a new user' do
        expect { Users::Create.run(params) }.to change { User.count }.by(1)
      end

      it 'associates the correct interests and skills with the user' do
        result = Users::Create.run(params)
        user = result.result
        
        expect(user.interests.pluck(:name)).to match_array(params[:interests])
        expect(user.skills.pluck(:name)).to match_array(params[:skills])
      end

      it 'creates only new interests and skills' do
        expect { Users::Create.run(params) }
          .to change { Interest.count }.by(3)
          .and change { Skill.count }.by(3)
      end
    end

    context 'when email is already taken' do
      before { create(:user, email: 'fake-mail@fake.com') }

      it 'does not create a user and adds an error' do
        result = Users::Create.run(params)

        expect(result.valid?).to be_falsey
        expect(result.errors[:email]).to include('has already been taken')
      end
    end

    context 'when required fields are missing' do
      %i[surname name patronymic email nationality country gender age].each do |field|
        it "returns an error when #{field} is missing" do
          params.delete(field)
          result = Users::Create.run(params)

          expect(result.valid?).to be_falsey
          expect(result.errors[field]).to include("is required")
        end
      end
    end
  end
end
