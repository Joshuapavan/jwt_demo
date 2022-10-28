class UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: [:show, :update, :destroy]

  # GET api/users
  def index
    @users = User.all
    render json: @users, status: 200
  end

  # POST api/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render json:{message: "unable to get the user"}, status: 503
    end
  end

  # GET api/users/id
  def show
    if @user
      render json: @user, status: 200
    else
      render json:{message: "unable to get the user with the id #{params[:id]}"}, status: 503
    end
  end

  # UPDATE/PATCH api/users/id
  def update
    if user.update(user_params)
      render json: @user, status: 200
    else
      render json:{message: "unable to update the user with id #{params[:id]}"}, status: 503
    end
  end

  # DELETE api/users
  def destroy
    if @user.destroy
      render json: @user, status: 200
    else
      render json:{message: "unable to destroy the user with id #{params[:id]}"}, status: 503
  end


  private
  def user_params
    params.permit(:user_name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end


end
