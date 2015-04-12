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

  def create_menu(attributes = {})
    attributes.reverse_merge!(
      name: "foo",
      price: 1.99,
      price_per_person: 0.5,
      tags: ["bar", "baz"]
    )

    attributes[:user_id] ||= create_user.id

    Menu.create!(attributes)
  end
end
