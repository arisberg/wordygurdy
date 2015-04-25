class Puzzle < ActiveRecord::Base
        belongs_to :user
        has_many :solved_puzzle
        validates :clue, presence: true
        validates :answer, presence: true

        before_create :setup

        # On Puzzle create sets initial values
        def setup
            self.solved = false
            self.score = 0
            self.answer = self.answer.downcase
        end

        # On Puzzle create sets user_id to current_user id
        def setup_id(current_user)
            self.user_id = current_user.id
        end

        # Compares entered guess to stored answer
        # Creates solvedpuzzle object
        # Increments user score and puzzle score by 1 if correct
        # If incorrect, decrements user score by one, increments Puzzle creator score by 1
        def solve(user, guess)
            if guess == self.answer
              solvedpuzzle = SolvedPuzzle.new
              solvedpuzzle.user_id = user.id
              solvedpuzzle.puzzle_id = self.id
              solvedpuzzle.save
              user.score += 1
              user.save
              self.solved = true
              self.score += 1
              self.save
            else
              user.score -= 1
              self.user.score += 1
              self.user.save
              user.save
          end
        end
end
