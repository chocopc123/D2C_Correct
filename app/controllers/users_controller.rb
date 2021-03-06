class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:logout]}
  before_action :ensure_correct_user, {only: [:edit, :update, :password_reset, :password_update]}

  def ensure_correct_user
    if @current_user && @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/shops/index")
    end
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(username: params[:username], email: params[:email], password: params[:password], icon_name: "default_icon.jpg")
      if @user.save
        if params[:icon]
          @user.icon_name = "#{@user.id}.jpg"
          icon = params[:icon]
          File.binwrite("public/user_icons/#{@user.icon_name}", icon.read)
          @user.save
        end
        session[:user_id] = @user.id
        flash[:notice] = "登録完了しました"
        redirect_to("/shops/index")
      else
        render("users/new")
      end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}")
    else
      @email = params[:email]
      @password = params[:password]
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/shops/index")
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.username = params[:name]
    @user.email = params[:email]
    if @user.save
      if params[:icon]
        @user.icon_name = "#{@user.id}.jpg"
        icon = params[:icon]
        File.binwrite("public/user_icons/#{@user.icon_name}", icon.read)
        @user.save
      end
      flash[:notice] = "編集完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def password_reset
    @user = User.new
  end

  def password_update
    @user = User.find_by(id: @current_user.id)
    if params[:new_password] && @user.authenticate(params[:current_password])
      @user.password = params[:new_password]
      if @user.save
        flash[:notice] = "パスワードを再設定しました"
        redirect_to("/users/#{@user.id}")
      else
        render("/users/password_reset")
      end
    else
      @error_message = "パスワードが間違っているか、空です"
      render("/users/password_reset")
    end
  end

end
