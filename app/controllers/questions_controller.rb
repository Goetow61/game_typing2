class QuestionsController < ApplicationController
  def index
    @aggregates = Question.left_outer_joins(:results).where(user_id: 1).select("questions.id, questions.title, questions.results_count, COUNT(distinct results.user_id) AS count_distinct_results_user_id").group("questions.id, questions.category, results_count").order("questions.id ASC")
    @questions_words = Question.where(category: 0, user_id: 1).order(:id)
    @questions_sentences = Question.where(category: 1, user_id: 1).order(:id)
    @questions = Question.where.not(user_id: 1).order(id: 'DESC').includes(:user)
  end

  def new
  end

  def create
  end

  def destroy
  end

  def show
  end

  def play
  end

  def result
  end
end
