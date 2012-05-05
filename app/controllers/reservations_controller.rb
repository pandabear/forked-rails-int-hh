class ReservationsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @reservation = @book.reservations.new(user: current_user)
    if @reservation.save
      flash[:notice] = t('.flash.notice.reserved_book')
      UserMailer.reservation_confirmation(@reservation).deliver
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.json { render json: @reservation.to_json(include: :user) }
      end
    else
      render :new
    end
  end
  
  def free
    @book = Book.find(params[:book_id])
    @reservation = @book.reservations.where(id: params[:id], user_id: current_user.id).first
   
    if @reservation && @reservation.free
      flash[:notice] = t('.flash.notice.released_book')
    else
      flash[:error]  = t('.flash.error.release_book_fail')
    end
    redirect_to book_path(@book)
  end
  
end
