class Puzzle < ActiveRecord::Base
        belongs_to :user
        validates :clue, presence: true
        validates :answer, presence: true

        before_create :setup
        def setup
            self.solved = false
            self.score = 0
            self.answer.downcase
            self.user_id = current_user.id
        end
end
