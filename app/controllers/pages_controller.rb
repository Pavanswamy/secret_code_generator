class PagesController < ApplicationController
	def home
		redirect_to secret_codes_path if current_user.present? && current_user.admin?
	end
end