class SeasonsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def season
    case params[:season_name]
    when "january"
      render 'january'
    when "february"
      render 'february'
    when 'march'
      render 'march'
    when 'april'
      render 'april'
    when 'may'
      render 'may'
    when 'june'
      render 'june'
    when 'july'
      render 'july'
    when 'august'
      render 'august'
    when 'september'
      render 'september'
    when 'october'
      render 'october'
    when 'november'
      render 'november'
    when 'december'
      render 'december'
    end
  end

  def search
    @vegetables_name = params[:vegetables_name]
    # render 'december'
    render "#{params[:season_name]}"
  end
end
