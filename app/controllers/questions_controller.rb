class QuestionsController < ApplicationController
  def index
    id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id)
    @aggregates = Question.left_outer_joins(:results).where(user_id: id.ids[0]).select("questions.id, questions.title, questions.results_count, COUNT(distinct results.user_id) AS count_distinct_results_user_id").group("questions.id, questions.category, results_count").order("questions.id ASC")
    @questions_words = Question.where(category: 0, user_id: id.ids[0]).order(:id)
    @questions_sentences = Question.where(category: 1, user_id: id.ids[0]).order(:id)
    @questions = Question.where.not(user_id: id.ids[0]).order(id: 'DESC').includes(:user)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
  end

  def show
  end

  def play
  end

  def result
  end

  private

  def question_params
    params.require(:question).permit(:title, :overview, :category, :src).merge(user_id: current_user.id)
  end

  def result_params
    params.require(:question).permit(:correct_cnt, :wrong_cnt, :elapsed_time, :speed).merge(user_id: current_user.id, question_id: params[:id])
  end

end
