class User < ActiveRecord::Base
    has_secure_password
    has_many :puzzles
    has_many :solved_puzzles
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates_presence_of :password, presence: true, confirmation: true, :on => :create

    before_create :setup

    # On create user sets role to Padawan
    def setup
      self.role = "Padawan"
    end

    # Sets role to appropriate rank
    def rankup
      if self.score > 10
        self.role = "Novice"
      end
      if self.score > 20
        self.role = "Adept"
      end
      if self.score > 30
        self.role = "Apprentice"
      end
      if self.score > 40
        self.role = "Expert"
      end
      if self.score > 50
        self.role = "Master"
      end
      self.save
    end

    # Returns progress to next rank as percentage
    def progress
      return self.score % 10 * 10
    end

    # Creates array of solved puzzles
    # Returns all puzzles not where puzzle id is not in the array
    def unsolved_puzzles
      ids = []
        self.solved_puzzles.each do |solved|
          ids << solved.puzzle_id
        end
       Puzzle.where.not(id: ids)
    end
end
