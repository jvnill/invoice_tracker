class PaymentDetailsController < ApplicationController
  before_action :set_user_as_current_user
  before_action :payment_detail_params, only: %i[create update]

  load_and_authorize_resource through: :user

  def create
    @payment_detail.save
  end

  def update
    @payment_detail.update_attributes(params[:payment_detail])
  end

  def destroy
    @payment_detail.destroy
  end

  private

  def payment_detail_params
    params[:payment_detail] = params.require(:payment_detail).permit(:text, :title)
  end
end
