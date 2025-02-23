# User Creation with ActiveInteraction
## Task Requirements

1. **Refactor `Users::Create` using ActiveInteraction**
   - Implement ActiveInteraction to structure the user creation logic declaratively.
   - Ensure better separation of concerns and maintainability.

2. **Fix the typo in `Skil`**
   - There are two ways to fix the issue:
     1. **Migration Approach**: Create a migration to rename the `skils` table and associated model to `skills`.
        ```ruby
        class RenameSkilToSkill < ActiveRecord::Migration[7.1]
          def change
            rename_table :skils, :skills
          end
        end
        ```
     2. **Workaround Approach**: Keep the incorrect spelling (`Skil`) but alias it within the model to use `Skill`. This is not ideal but allows the existing database structure to remain unchanged.
        ```ruby
        class Skil < ApplicationRecord
          self.table_name = 'skills'
        end
        ```

3. **Fix Associations**
   - Ensure proper `has_many` and `belongs_to` relationships are set up correctly for `User`, `Interest`, `Skill`, `UserInterest`, and `UserSkill` models.

4. **Setup and Use `Users::Create` in a Rails Application**
   - Implement `Users::Create` as an ActiveInteraction service in the Rails app.
   - Ensure it correctly processes input parameters and persists data.

5. **Write Tests**
   - Implement RSpec tests for `Users::Create`.
   - Validate successful user creation, handling of duplicate emails, and error cases.

6. **Use Declarative Programming in Refactoring**
   - Ensure that the refactored `Users::Create` follows a declarative programming approach.
   - Improve readability and maintainability by leveraging ActiveInteraction's declarative style.


## Setup Instructions

1. Clone the repository:
   ```sh
   git clone <repo_url>
   cd <project_folder>
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Set up the database:
   ```sh
   rails db:create db:migrate
   ```
4. Run the test suite:
   ```sh
   rspec
   ```

## Technologies Used
- Ruby on Rails 7.1.5
- ActiveInteraction
- RSpec
- FactoryBot
- PostgreSQL

