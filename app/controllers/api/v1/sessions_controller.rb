class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :only => [:create], :raise => false

  def create
    #debugger
    begin
      @user = User.find_by_email(params[:email])
      user_password = params[:password]
      if @user && @user.valid_password?(user_password)
           @user.authentication_token = nil
           @user.save
           #render json: user.as_json(only: [:email, :authentication_token]), status: :created
           #render create, status: :created
           render json: @user.as_json()

      else
           #head(:unauthorized)
           render json: "-1"
      end
    rescue
           render json: "-2"
    end

  end


  def destroy
  #debugger
    begin
      @user = User.find_by_authentication_token(params[:user_token])

      @user.authentication_token = nil
      @user.save
        #render json: "1", status: :created
      render json: "1"
    rescue
      render json: "-2"
    end
  end


end
