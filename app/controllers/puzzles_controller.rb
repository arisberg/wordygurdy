class PuzzlesController < ApplicationController
  before_action :require_user

  def index
    @user = current_user.id
    @puzzles = current_user.unsolved_puzzles.where.not(user_id: @user)
  end

  def answer
     guess = params[:guess].downcase
     puzzle = Puzzle.find(params[:id])
     puzzle.solve(current_user, guess)
     redirect_to puzzle_path(puzzle)
  end

  def new
    @puzzle = Puzzle.new
  end

  def show
    @puzzle = Puzzle.find(params[:id])
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.setup_id(current_user)
        if @puzzle.save
            redirect_to puzzles_path
        else
            flash[:error] = @puzzle.errors.full_messages.to_sentence
            render "new"
        end
  end

  def edit
    @puzzle = Puzzle.find(params[:id])
  end

  def update
        @puzzle = Puzzle.find(params[:id])

        if @puzzle.update_attributes(puzzle_params)
            @puzzle.answer
            redirect_to puzzles_path
        else
            render "edit"
        end
  end

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
