class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user #je log l'utilisateur
      params[:session][:remember_me] == "1" ? remember(user) : forget(user) #sil la case est coché je me souviens de lui, sinon je l'oublie
      redirect_to user #je le redirige vers son profil
    else
      flash.now[:danger] = "Email ou mot de passe invalide !"
      render "new"
    end
  end

  def destroy
    log_out if logged_in? #je log out si l'utilisateur est log ( prevention multiple navigateur)
    redirect_to root_path
  end

end
