class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    if @comment.save
    render :book_comments
    end
  end

  def destroy
    @book =Book.find(params[:book_id])
    @comment = current_user.book_comments.find(params[:id])
    if @comment.destroy
    render :book_comment
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment).merge(book_id: params[:book_id])
  end

end
