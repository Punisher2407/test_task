module Users
  class Create < ActiveInteraction::Base

    string :surname, :name, :patronymic, :email, :nationality, :country, :gender
    integer :age
    array :interests, default: []
    array :skills, default: []

    validates_numericality_of :age, greater_than: 0, less_than_or_equal_to: 90
    validates_inclusion_of :gender, in: %w[male female]

    def execute
      user = User.new(inputs.except(:interests, :skills))

      unless user.save
        errors.merge!(user.errors)
        return nil
      end

      user.interests = inputs[:interests].map { |name| Interest.find_or_create_by(name: name) }
      user.skills = inputs[:skills].map { |name| Skill.find_or_create_by(name: name) }

      user
    end
  end
end
