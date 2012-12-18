class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    if (params.has_key?(:criteria))
      if (params[:criteria]!="")
        @contacts = Contact.where(["first_name LIKE ? OR last_name LIKE ?","%#{params[:criteria]}%","%#{params[:criteria]}%"]).order('last_name')
      else
        @contacts = Contact.order('last_name')
      end
    else
      @contacts = Contact.order('last_name')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
      format.js
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json

  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
      format.js
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
      format.js
    end
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    @contacts = Contact.order('last_name')

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    @contacts = Contact.order('last_name')

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
      format.js
    end
  end

  def delete_multiple
    @contacts = Contact.find(params[:contacts_ids])
    @contacts.each do |contact|
      contact.destroy
    end
    flash[:notice] = "Updated products!"
    redirect_to products_path
  end
end
