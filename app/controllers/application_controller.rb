class ApplicationController < ActionController::Base
	# deviseコントローラーにストロングパラメータを追加する
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	#devise用のストロングパラメータconfigure_permitted_parametersを設定する
	def configure_permitted_parameters
		#ユーザーが新規登録する際変更できるのは、第１引数sing_up（deviseデフォルト設定になっている新規登録に
		# 必要な項目、emailやpasswordなど）と独自追加カラムusernameのみ許可、
		# 加えて子モデルcreatorの、names_master_idとnameカラムのみ許可
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :creators_attributes => [:names_master_id, :name]])
		devise_parameter_sanitizer.permit(:account_update, keys: [:username])
	end
	
end
