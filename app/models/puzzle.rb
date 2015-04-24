class Puzzle < ActiveRecord::Base
        belongs_to :user
        has_many :solved_puzzle
        validates :clue, presence: true
        validates :answer, presence: true

        before_create :setup

        def setup
            self.solved = false
            self.score = 0
            self.answer = self.answer.downcase
        end

        def setup_id(current_user)
            self.user_id = current_user.id
        end

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
