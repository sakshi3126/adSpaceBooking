def seed_users
  user_id = 0
  roles = ['Space Provider', 'Organisation', 'Space Agent']
  10.times do
    roles.each do |role|
      User.create(
          name: "test#{user_id}",
          email: "test#{user_id}@test.com",
          password: '123456',
          password_confirmation: '123456',
          role: "#{role}"

      )
      user_id = user_id + 1
    end
  end
end


def seed_slots
  10.times do
    roles = []
    Slot.create(
        title: Faker::Lorem.sentences[0],
        start_at: rand(2.days.ago..1.days.after),
        end_at: rand(2.days.ago..2.days.after),
        user_id: rand(1..9),
    )
  end
end

seed_users
seed_slots