class Api::V1::ContactsController < Api::V1::BaseController
  before_action :set_user
  before_action :set_contact, only: [:show]

  # GET /api/v1/users/:user_id/contacts
  def index
    @contacts = @user.contacts
  end

  # GET /api/v1/users/:user_id/contacts/1
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :surnames, :email, :category, :photo, phones_attributes: [:id, :number, :_destroy])
    end

    def set_user
      @user= User.find(params[:user_id])
    end
end
