class BooksController < ApplicationController
   before_action :is_matching_login_user,only:[:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user=@book.user
    @books = Book.new#投稿フォームで追加
    @book_comment=BookComment.new

    @book_detail = Book.find(params[:id]) #閲覧カウントここから
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end #ここまで
  end

  def index
    @books = Book.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
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
    @book=Book.find(params[:id])
    if @book.user!=current_user
    redirect_to books_path
    end
  end
  # ここまで追加

end
