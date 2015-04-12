module SignInHelper
  def sign_in(user = nil)
    user ||= create_user
    post authenticate_user_path, email: user.email, password: "aaa123"
  end
end
