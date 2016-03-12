class InvoicesController < ApplicationController
  before_action :set_user_as_current_user
  before_action :invoice_params, only: [:create, :update]

  load_and_authorize_resource through: :user

  before_action :set_invoice_item_quantity, only: %i[create update]

  def index
    @invoices = @invoices.includes(project: :client).ordered_by_id.page(params[:page])
  end

  def new
    @invoice.invoice_items.build
  end

  def create
    @invoice.calculate_invoice_total
    @invoice.save
  end

  def show
    @project       = @invoice.project
    @client        = @project.client
    @invoice_items = @invoice.invoice_items.ordered_by_id
  end

  def update
    if @invoice.update_attributes(invoice_params)
      @invoice.calculate_invoice_total
      @invoice.save!
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path
  end

  def download
    template = params[:template].match(/template[1-3]/) ? params[:template] : 'template1'

    render pdf: @invoice.number.to_s,
           disposition: 'attachment',
           page_height: 1123,
           dpi: 300,
           margin: { bottom: 0 },
           show_as_html: params[:preview],
           template: "invoices/#{template}"
  end

  def cycle_status
    @invoice.update_column :status, @invoice.next_status

    render json: { status: @invoice.status.titleize }
  end

  def next_invoice_number
    max = Invoice.where(project_id: params[:project_id]).maximum(:number)
    render text: max && max.succ
  end

  private

  def invoice_params
    params[:invoice] = params.require(:invoice).permit(:project_id, :number, :date, :client_reference_number, :due_date, :payment_detail_id, :currency, :page_size, :no_quantity, invoice_items_attributes: [:name, :quantity, :unit_amount, :id, :_destroy])
  end

  def set_invoice_item_quantity
    return unless @invoice.no_quantity?

    @invoice.invoice_items.each { |invoice_item| invoice_item.quantity = 1 }
  end
end
