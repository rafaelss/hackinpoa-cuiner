module SignInHelper
  PASSWORD = "aaa123".freeze

  def sign_in
    user = create_user
    post authenticate_user_path, email: user.email, password: PASSWORD
  end
end
