class PuzzlesController < ApplicationController
  before_action :require_user

  # Sets @puzzles to all puzzles not created by user and where unsolved
  def index
    @user = current_user.id
    @puzzles = current_user.unsolved_puzzles.where.not(user_id: @user)
  end

  # Sets guess to params and downcases
  # Sets puzzle to clicked puzzle
  # Runs puzzle.solve
  # Runs rankup on current_user
  def answer
     guess = params[:guess].downcase
     puzzle = Puzzle.find(params[:id])
     puzzle.solve(current_user, guess)
     current_user.rankup
     redirect_to puzzle_path(puzzle)
  end

  # Makes new puzzle
  def new
    @puzzle = Puzzle.new
  end

  # Show submitted puzzle win/lose page
  def show
    @puzzle = Puzzle.find(params[:id])
  end

  # Creates new puzzle
  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.setup_id(current_user)
        if @puzzle.save
            redirect_to "/userhome"
        else
            flash[:error] = @puzzle.errors.full_messages.to_sentence
            render "new"
        end
  end

  # Edits puzzle
  def edit
    @puzzle = Puzzle.find(params[:id])
  end

  # Updates puzzle to edits
  def update
        @puzzle = Puzzle.find(params[:id])

        if @puzzle.update_attributes(puzzle_params)
            @puzzle.answer
            redirect_to puzzles_path
        else
            render "edit"
        end
  end

  # Destroys puzzle and all SolvedPuzzle attached to it
  def destroy
    @puzzle = Puzzle.find(params[:id])
    @solved = SolvedPuzzle.where(puzzle_id: @puzzle.id)
    @solved.destroy_all
    @puzzle.destroy
    redirect_to('/userhome')
  end

  private

  def puzzle_params
    params.require(:puzzle).permit(:clue, :answer)
  end
end
