class User < ActiveRecord::Base
    has_secure_password
    has_many :puzzles
    has_many :solved_puzzles
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates_presence_of :password, presence: true, confirmation: true, :on => :create

    def unsolved_puzzles
      ids = []
        self.solved_puzzles.each do |solved|
          ids << solved.puzzle_id
        end
       Puzzle.where.not(id: ids)
    end
end
