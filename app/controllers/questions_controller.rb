class QuestionsController < ApplicationController
  def index
    default_user_id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id).ids[0]
    @aggregates = Question.left_outer_joins(:results).where(user_id: default_user_id).select("questions.id, questions.title, questions.results_count, COUNT(distinct results.user_id) AS count_distinct_results_user_id").group("questions.id, questions.category, results_count").order("questions.id ASC")
    @questions_words = Question.where(category: 0, user_id: default_user_id).order(:id)
    @questions_sentences = Question.where(category: 1, user_id: default_user_id).order(:id)
    @questions = Question.where.not(user_id: default_user_id).order(id: 'DESC').includes(:user)
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
    @default_user_id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id).ids[0]
    @question = Question.find(params[:id]) 
  end

  def play
    # CSV読み込みの部分が長くなってしまった
    require 'csv'
    require 'tempfile'
    
    @qfile = Qfile.find(params[:id])
    # テンポラリファイルを定義。S3からダウンロードして(多分)サーバー上のファイルとして開く。
    file = Tempfile.open
    data = open(@qfile.src.url).read()
    File.open(file, 'wb'){|file| file.write(data)}
    # CSVの中身を保存する配列
    question = []
    CSV.foreach(file, col_sep:"\t", liberal_parsing: true) do |row|
      question << row
    end
    # javascriptに変数を渡す
    gon.question = question
    # いらないかもしれないが、テンポラリファイルを閉じて削除
    file.close
    file.unlink
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
