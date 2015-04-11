module Fixtures
  def create_user(attributes = {})
    attributes.reverse_merge!(
      first_name: "foo",
      last_name: "baz",
      email: "foo@bar.com",
      password: "aaa123",
      password_confirmation: "aaa123"
    )

    User.create!(attributes)
  end
end
