class PuzzlesController < ApplicationController
  before_action :require_user

  def index
    @user = current_user.id
    @puzzles = Puzzle.where.not(user_id: @user)
  end

  def answer
     @user = current_user
     @guess = params[:guess].downcase
     @puzzle = Puzzle.find(params[:id])
        if @guess == @puzzle.answer
          @user.score += 1
          @user.save
          @puzzle.solved = true
          @puzzle.score += 1
          @puzzle.save
        else
          @user.score -= 1
          @puzzle.user.score += 1
          @puzzle.user.save
          @user.save
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
    @puzzle.destroy
    redirect_to('/puzzles')
  end

  private

  def puzzle_params
    params.require(:puzzle).permit(:clue, :answer)
  end
end
