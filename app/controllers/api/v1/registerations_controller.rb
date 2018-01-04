class Api::V1::RegisterationsController < ApplicationController

skip_before_action :authenticate_user_from_token!, :only => [:create], :raise => false

  def create
      #debugger
       begin
            if params[:password] == params[:password_confirmation]
              @user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
              if @user.save
                 render json: @user.as_json()
              else
                 render json: "-1", status: :Not_Registered
              end
            else
                 render json: "0", status: :No_Password_Match
            end

       rescue
          render json: "-2"
       end


  end

end
