namespace :dev do
  desc "Rebuild development system"
  task rebuild: ["tmp:clear", "log:clear", "db:reset", "db:seed"]

  desc "Create development data"
  task data: :environment do
    admin =
      User.where(email: "admin@example.com")
        .first_or_create!(
          name: "Admin",
          password: "password",
          password_confirmation: "password",
          confirmed_at: Time.now,
        )
    admin.add_role(:admin)
  end
end
