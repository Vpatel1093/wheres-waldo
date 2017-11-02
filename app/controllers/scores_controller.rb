class ScoresController < ApplicationController
  def index
    @puzzle = Puzzle.find(params[:puzzle_id])
    @scores = @puzzle.scores
  end

  def create
    @score = Score.new(score_params)
    @puzzle = Puzzle.find(params[:score][:puzzle_id])
    if @score.save
      redirect_to scores_path(:puzzle_id => @puzzle.id)
    end
  end

  private
  def score_params
    params.require(:score).permit(:name, :puzzle_id, :score)
  end
end
