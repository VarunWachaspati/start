class MentorsController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  require 'will_paginate/array'

  def new
   if !current_user
      @user = Mentor.new
      store_location
   else
      redirect_to current_user
   end
  end

  def profile
     @user = current_user
  end
def follow
    store_location
    @mentor=Mentor.find(params[:id])
    current_user.follow!(@mentor)
    redirect_back_or current_user
  end

  def unfollow
    store_location
    @mentor=Mentor.find(params[:id])
    current_user.unfollow!(@mentor)
    redirect_back_or current_user
  end

  def following
     store_location
     @user = current_user
     @entrepreneurs=@user.followees(Entrepreneur).paginate
  end

  def all
     #@students=Student.paginate(page: params[:page])
     @search = Search.new(:mentor, params[:search])
    @search.order = 'lname'
    @mentors = (@search.run).paginate(:page => params[:page], :per_page => 9)
  end

  def show
    @user = Mentor.find(params[:id])
    @microposts = Micropost.paginate(page: params[:page])
     @search = Search.new(:mentor, params[:search])
    @search.order = 'lname'
    @mentors = (@search.run).paginate(:page => params[:page], :per_page => 9)
       store_location
    @mentor = Mentor.find(params[:id])
    
    
 
  end

  def myent
    #@user = Mentor.find(params[:id])
    @entrepreneurs = current_user.followers(Entrepreneur).paginate
    end
  
  def edit
    $purpose="Edit"
    @user = Mentor.find(params[:id])
    expertise = params[:expertise]|| []
  end

  def updatepwd
    $purpose="Pwd"
    @user = current_user
  end

  def create
    @mentor = Mentor.new(user_params)
    if @mentor.save
      @user=Users.new
      #Handle a successful save.
      if lcurrent_user
         @string=lcurrent_user['siteStandardProfileRequest']['url'].scan(/id=+(\d+)/)[0][0]
         @mentor.update_attribute(:linkedin_id,@string)
         @user.update_attribute(:linkedin_id,@string)
      end
      @user.update_attribute(:email,@mentor.email)   
      @user.update_attribute(:type,"Mentor")
      @user.save
      sign_in(@mentor,"Mentor")
      flash[:success] = "Welcome to StartupSphere!Update your profile for better opportunities"
      redirect_to @mentor
    else
      @user=@mentor
      render 'new'
      #redirect_to "/students/new"
    end
  end
def message
    store_location
    @mentor = Mentor.find(params[:id])
    redirect_to new_message_path
  end


  def update
    @user = Mentor.find(params[:id])
    #params[:student].delete(:password) if params[:student][:password].blank?
    #expertise = params[:expertise].to_s|| []
    
    if @user.update_attributes(edit_user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      if $purpose=="Edit"
         render 'edit'
      else
         render 'updatepwd'
      end    
    end
  end

  private

    def user_params
      params.require(:mentor).permit(:fname, :lname, :email,:password,:password_confirmation,:time_devoted_monthly,:ways_can_help,:expertise => [],:mentor_interest =>[])
    end

    def edit_user_params
      params.require(:mentor).permit(:fname, :lname, :email,:skills,:bio,:google,:fb,:github,:pic,:password,:password_confirmation,:education,:linkedin,:phone,:time_devoted_monthly,:ways_can_help,:expertise => [],:mentor_interest => [])
    end

end
