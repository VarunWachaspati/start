class EntrepreneursController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update,:show]
  before_action :correct_user,   only: [:edit, :update]
  require 'will_paginate/array'
  def new
  if !current_user
     @user = Entrepreneur.new
     store_location
  else
    redirect_to current_user
  end
  end

  def show
    @user = Entrepreneur.find(params[:id])
    @startups = @user.startups.paginate(page: params[:page])
    @microposts = Micropost.paginate(page: params[:page])
  end

  def updatepwd
    @user = current_user
  end
def follow
    store_location
    @entrepreneur=Entrepreneur.find(params[:id])
    current_user.follow!(@entrepreneur)
    redirect_back_or current_user
  end

  def unfollow
    store_location
    @entrepreneur=Entrepreneur.find(params[:id])
    current_user.unfollow!(@entrepreneur)
    redirect_back_or current_user
  end

  def mymentor
    store_location
    @user = current_user
    @mentors=@user.followees(Mentor).paginate
  end 
  def following
     store_location
     @user = current_user
     @mentors=@user.followees(Mentor).paginate
  end
  def create
    @entrepreneur = Entrepreneur.new(user_params)    
    if @entrepreneur.save
      # Handle a successful save.
      @user=Users.new
      if lcurrent_user
         @string=lcurrent_user['siteStandardProfileRequest']['url'].scan(/id=+(\d+)/)[0][0]
         @entrepreneur.update_attribute(:linkedin_id,@string)
         @user.update_attribute(:linkedin_id,@string)
      end
      @user.update_attribute(:email,@entrepreneur.email)
      @user.update_attribute(:type,"Entrepreneur")
      @user.save
      sign_in(@entrepreneur,"Entrepreneur")
      flash[:success] = "Make your own startup to reach out to other users"
      redirect_to current_user
    else
      #redirect_back_or "/login"
      @user=@entrepreneur
      render 'new'
    end
  end

def all
     #@students=Student.paginate(page: params[:page])
     @search = Search.new(:entrepreneur, params[:search])
    @search.order = 'lname'
    @entrepreneurs = (@search.run).paginate(:page => params[:page], :per_page => 9)
  end
def profile
      @user = Entrepreneur.find(params[:id])

  end

  def update
    @user = Entrepreneur.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'updatepwd'
    end
  end

  private

    def user_params
      params.require(:entrepreneur).permit(:fname, :lname, :email,:skills,:bio,:google,:fb,:github,:pic,:password,:password_confirmation,:education,:linkedin,:phone)
    end

    
end
