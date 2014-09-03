require 'rubygems'
require 'market_bot'

class TestsController < ApplicationController
  def details
    lb = MarketBot::Android::Leaderboard.new(:topselling_free, :game)
    lb.update
    @app = MarketBot::Android::App.new(lb.results.last[:market_id])
    @app.update
  end
end
