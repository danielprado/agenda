class ContactsController < ApplicationController
  before_action :check_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]


  # GET /users/:user_id/contacts
  def index
    @q = @user.contacts.ransack(params[:q])
    @contacts = @q.result(dinstinct: true)
  end

  # GET /users/:user_id/contacts/:id
  def show
  end

  # GET /users/:user_id/contacts/new
  def new
    @contact = Contact.new
    @contact.phones.build
  end

  # GET /users/:user_id/contacts/:id/edit
  def edit
  end

  # POST /users/:user_id/contacts
  def create
    @contact = Contact.new(contact_params)
    @contact.user=@user

    respond_to do |format|
      if @contact.save
        format.html { redirect_to [@user,@contact], notice: 'Contact was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/:user_id/contacts/:id
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to [@user,@contact], notice: 'Contact was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/:user_id/contacts/:id
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to user_contacts_url(@user), notice: 'Contact was successfully destroyed.' }
    end
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

    def check_user!
      if current_user.id != params[:user_id].to_i
        flash[:notice] = 'Este no es el contacto que buscabas'

        redirect_to root_path

        return false
      else
        @user= User.find(params[:user_id])
      end
    end
end
