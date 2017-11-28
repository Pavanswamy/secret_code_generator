class SecretCodesController < ApplicationController
  load_and_authorize_resource
  before_action :set_secret_code, only: [:show, :edit, :update, :destroy]

  def index
    @secret_codes = SecretCode.all
  end

  def edit
  end

  def create
    if params[:count].present? 
      params[:count].to_i.times do
        code = SecretCode.generate_key
        SecretCode.create(code: code, user_id: nil)
      end
      msg = 'Secret codes was successfully created.'
    else
      msg = 'please select count'
    end
    redirect_to secret_codes_path, notice: msg
  end

  def update
    check_uniqiness_for_sc
    respond_to do |format|
      if @secret_code.update(secret_code_params)
        format.html { redirect_to @secret_code, notice: 'Secret code was successfully updated.' }
        format.json { render :show, status: :ok, location: @secret_code }
      else
        format.html { render :edit }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @secret_code.destroy
    respond_to do |format|
      format.html { redirect_to secret_codes_url, notice: 'Secret code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret_code
      @secret_code = SecretCode.find(params[:id])
    end

    def check_uniqiness_for_sc
      User.find(params[:user_id]).secret_code.update(user_id: nil) rescue nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secret_code_params
      params.permit(:code, :user_id, :count)
    end
end
