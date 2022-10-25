class BooksController < ApplicationController
   before_action :is_matching_login_user,only:[:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user=@book.user
    @books = Book.new#投稿フォームで追加
  end

  def index
    @books = Book.all
    @book=Book.new
    @user=current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
       @user=current_user
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

# ここからアクセス制限
  def is_matching_login_user
    #user_id = params[:id].to_i
    #logger.debug(user_id)
    #logger.debug("aaaaa")
    #login_user_id = current_user.id
    #logger.debug(login_user_id)
    #logger.debug("aaaaa")
    #if(user_id != login_user_id)
     #redirect_to books_path
    @book=Book.find(params[:id])
    if @book.user!=current_user
    redirect_to books_path
    end
  end
  # ここまで追加

end
