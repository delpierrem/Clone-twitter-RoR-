class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit,:update,:destroy]
  before_action :logged_in_user, only: [:index,:edit,:update,:destroy]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #Sauvegarde confirmé <- true
      log_in(@user)
      flash[:success] = "Bienvenue sur le clone de twitter"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil mis à jour"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Utilisateur supprimé"
    redirect_to users_path
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Merci de vous connecter."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
