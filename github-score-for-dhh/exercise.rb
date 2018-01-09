# frozen_string_literal: true

require 'json'
require 'open-uri'

# Calculates David Heinemeier Hansson's github score
# based on his public commit types
class ScoreCalculator
  URL = 'https://api.github.com/users/dhh/events/public'
  TYPE = {
    'IssuesEvent': 7,
    'IssueCommentEvent': 6,
    'PushEvent': 5,
    'PullRequestReviewCommentEvent': 4,
    'WatchEvent': 3,
    'CreateEvent': 2
  }.freeze

  attr_accessor :score

  def initialize
    @score = 0
  end

  def call
    score_calculator
    "DHH's github score is #{@score}"
  end

  private

  def score_calculator
    commits = JSON.parse(open(URL).read)

    commits.each do |commit|
      type = commit['type'].to_sym
      @score += TYPE.key?(type) ? TYPE[type] : 1
    end
  end
end

puts ScoreCalculator.new.call
