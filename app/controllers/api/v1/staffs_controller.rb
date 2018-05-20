class Api::V1::StaffsController < Api::V1::ApisController

  require 'bcrypt'
  def login
    email = /^#{params[:email]}$/i
    password = params[:password]
    current_ts = Time.now
    # status, message = Validator.validate_employee_id(employee_id)
    #
    # unless status
    #   render json: { :errors => [message] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
    #   return
    # end

    if email.blank?
      render json: { :errors => ["Email can't be blank."] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
      return
    end


    if password.blank?
      render json: { :errors => ["Password can't be blank."] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
      return
    end

    user = User.find_by(email: email)
    if user.blank?
      render json: { :errors => ['Invalid email.'] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
      return
    end

    ency_pass = user.encrypted_password

    if ency_pass.blank?
      render json: { :errors => ['Invalid Password. Your Password is not registered with us.'] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
      return
    end

    new_pass = password

    if BCrypt::Password.new(ency_pass) != new_pass
      render json: { :errors => ["Invalid password"] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
      return
    end

    render json: { message: 'Logged In Successfully' }

  end

end
