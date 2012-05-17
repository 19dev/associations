class PhysiciansController < ApplicationController
  # GET /physicians
  # GET /physicians.json
  def index
    @physicians = Physician.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @physicians }
    end
  end

  # GET /physicians/1
  # GET /physicians/1.json
  def show
    @physician = Physician.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @physician }
    end
  end

  # GET /physicians/new
  # GET /physicians/new.json
  def new
    @physician = Physician.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @physician }
    end
  end

  # GET /physicians/1/edit
  def edit
    @physician = Physician.find(params[:id])
  end

  # POST /physicians
  # POST /physicians.json
  def create
    @physician = Physician.new(params[:physician])

    respond_to do |format|
      if @physician.save
        format.html { redirect_to @physician, notice: 'Physician was successfully created.' }
        format.json { render json: @physician, status: :created, location: @physician }
      else
        format.html { render action: "new" }
        format.json { render json: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /physicians/1
  # PUT /physicians/1.json
  def update
    @physician = Physician.find(params[:id])

    respond_to do |format|
      if @physician.update_attributes(params[:physician])
        format.html { redirect_to @physician, notice: 'Physician was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /physicians/1
  # DELETE /physicians/1.json
  def destroy
    @physician = Physician.find(params[:id])
    @physician.destroy

    respond_to do |format|
      format.html { redirect_to physicians_url }
      format.json { head :no_content }
    end
  end
end
