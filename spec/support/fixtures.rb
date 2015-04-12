module Fixtures
  def create_user(attributes = {})
    attributes.reverse_merge!(
      name: "foo",
      email: "foo@bar.com",
      password: "aaa123",
      password_confirmation: "aaa123"
    )

    User.create!(attributes)
  end

  def create_absence(attributes = {})
    attributes.reverse_merge!(
      at: 2.days.from_now,
      shift: "morning"
    )

    attributes[:user_id] ||= create_user.id

    Absence.create!(attributes)
  end
end
