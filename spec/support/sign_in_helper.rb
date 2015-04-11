module SignInHelper
  PASSWORD = "aaa123".freeze

  def sign_in
    user = create_user
    post authenticate_user_path, email: user.email, password: PASSWORD
  end

  private

  def create_user
    @@n ||= 0
    @@n += 1

    User.create(
      first_name: "foo #{@@n}",
      last_name: "baz #{@@n}",
      email: "foo#{@@n}@bar.com",
      password: PASSWORD,
      password_confirmation: PASSWORD
    )
  end
end
