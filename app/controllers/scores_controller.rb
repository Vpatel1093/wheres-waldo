class ScoresController < ApplicationController
  def index
    @puzzle = Puzzle.find(params[:puzzle_id])
    @scores = @puzzle.scores
  end
end
