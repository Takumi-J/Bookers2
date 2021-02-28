class BooksController < ApplicationController

 
  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] ="Book was successfully created."
     redirect_to "/books/#{@book.id}"
    else
     @user = current_user
     @books = Book.all
     render 'index'
    end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

   def update
     @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
   end
  
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id != current_user.id
     redirect_to "/books"
    end
  end





    private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  

end
