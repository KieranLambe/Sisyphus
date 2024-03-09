class InterestController < ApplicationController
  before_action :set_interest, only: [:show, :edit, :update, :destroy]

  def index
    @interests = Interest.all
  end

  def show
  end

  def new
    @interest = Interest.new
  end

  def create
    @interest = Interest.new(interest_params)

    if @interest.save
      redirect_to @interest, notice: 'Interest created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @interest.update(interest_params)
      redirect_to @interest, notice: 'Interest updated.'
    else
      render :edit
    end
  end

  def destroy
    @interest.destroy
    redirect_to interests_url, notice: 'Interest destroyed.'
  end

  private

  def set_interest
    @interest = Interest.find(params[:id])
  end

  def interest_params
    params.require(:interest).permit(:title)
  end
end
