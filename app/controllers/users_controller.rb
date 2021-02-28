class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
       redirect_to "/users/#{current_user.id}"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="successfully updated."
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

    def new
    @book = Book.new
    end


  def index
     @book = Book.new
     @users = User.all
     @user = current_user
  end




    private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
