class Question < ApplicationRecord
  belongs_to :user
  has_many :results

  # rails enumで検索 単語が0、文章が1で入る
  enum category: [:'英語-単語', :'英語-文章']
end
