class PuzzlesController < ApplicationController
  before_action :require_user, except: [:index]

  def index
    @puzzles = Puzzle.where(solved: false)
  end

  def answer
     @guess = params[:guess]
     @puzzle = Puzzle.find(params[:id])
        if @guess == @puzzle.answer
          @puzzle.solved = true
          @puzzle.save
        end
        redirect_to puzzle_path(@puzzle)
  end

  def new
    @puzzle = Puzzle.new
  end

  def show
    @puzzle = Puzzle.find(params[:id])
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.solved = false
        if @puzzle.save
            redirect_to puzzles_path
        else
            render "new"
        end
  end

  def edit
    @puzzle = Puzzle.find(params[:id])
  end

  def update
        @puzzle = Puzzle.find(params[:id])

        if @puzzle.update_attributes(puzzle_params)
            redirect_to puzzles_path
        else
            render "edit"
        end
  end

  def destroy
    @puzzle = Puzzle.find(params[:id])
    @puzzle.destroy
    redirect_to('/puzzles')
  end

  private

  def puzzle_params
    params.require(:puzzle).permit(:clue, :answer)
  end
end
