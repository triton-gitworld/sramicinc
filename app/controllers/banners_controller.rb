class BannersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # GET /banners
  # GET /banners.json
  def index
    @banners = Banner.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    @banner = Banner.new
  end

  # GET /banners/1/edit
  def edit
  end

  # POST /banners
  # POST /banners.json
  def create
    @banner = Banner.new(banner_params)

    respond_to do |format|
      if @banner.save
        format.html { redirect_to banners_url, notice: 'Banner was successfully created.' }
        format.json { render :show, status: :created, location: @banner }
      else
        format.html { render :new }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    respond_to do |format|
      if @banner.update(banner_params)
        format.html { redirect_to banners_path, notice: 'Banner was successfully updated.' }
        format.json { render :show, status: :ok, location: @banner }
      else
        format.html { render :edit }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @banner.destroy
    respond_to do |format|
      format.html { redirect_to banners_url, notice: 'Banner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def active_deactive
    @news = Banner.find(params[:id])
    @news.update_attribute(:active, params[:flag])
    redirect_to banners_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:title, :url, :active,:banner_image)
    end
end
