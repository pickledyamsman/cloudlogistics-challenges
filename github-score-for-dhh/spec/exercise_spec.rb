require 'spec_helper'

RSpec.describe ScoreCalculator do
  before :each do
    @test_score = ScoreCalculator.new
  end

  it '#initialize sets default score to 0' do
    expect(@test_score.score).to eq(0)
  end

  it "#call returns DHH's score" do
    expect(@test_score.call).to include("DHH's github score is")
  end
end
