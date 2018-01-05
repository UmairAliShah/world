class Api::V1::ProfilesController < ApplicationController

 #skip_before_action :authenticate_user_from_token!, :only => [:create], :raise => false

  def create
      begin
        #debugger
        @user = User.find_by_authentication_token(params[:user_token])
        #@user = User.find_by_email(params[:user_email])
        if @user && @user.profile == nil
           @new_profile = Profile.new(profile_params)
           if @user.profile = @new_profile
              render json: @new_profile.as_json()
           else
              render json: "0", status: :Profile_Not_Saved
           end
        else
           render json: "-1", status: :User_Not_Found
        end
      rescue
        render json: "-2"
      end
  end

  def update
      begin
          @user = User.find_by_authentication_token(params[:user_token])
          if @user && @user.profile != nil
             @profile_to_be_Changed = @user.profile
             if @profile_to_be_Changed.update(profile_params)
                render json: @profile_to_be_Changed.as_json()
             else
                render json: "0", status: :Profile_Not_Update
             end
          else
             render json: "-1", status: :User_Not_Found
          end
      rescue
        render json: "-2"
      end
  end

  def update_img
    begin
        @user = User.find_by_authentication_token(params[:user_token])
        if @user && @user.profile != nil
           @profile_img_to_be_Changed = @user.profile
           if @profile_img_to_be_Changed.update(update_img_url)
              render json: @profile_img_to_be_Changed.as_json()
           else
              render json: "0", status: :Profile_Img_Not_Update
           end
        else
           render json: "-1", status: :User_Not_Found
        end
    rescue
      render json: "-2"
    end
  end

  private
  def profile_params
      params.require(:profile).permit(:first_name, :last_name, :state, :city, :country, :code, :phone_no, :provider, :img_url, :provider_id)
  end

  def update_img_url
     params.require(:profile).permit(:img_url)
  end
end
