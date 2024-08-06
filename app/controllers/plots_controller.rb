class PlotsController < ApplicationController
  def index
    @plots = Plot.includes(:plants).all

  end
end