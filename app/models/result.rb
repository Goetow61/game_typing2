class Result < ApplicationRecord
  belongs_to :user
  belongs_to :question
  counter_culture :question
end
