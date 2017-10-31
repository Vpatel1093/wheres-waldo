class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @puzzle_id = @puzzle.id
    respond_to do |format|
      format.html
      format.json { render json: @puzzle.characters }
    end
  end
end
