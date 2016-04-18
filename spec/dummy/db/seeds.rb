# Posts
puts post1 = Post.create!(
  title: "First Post",
  description: "First Ever Post!"
)
puts post2 = Post.create!(
  title: "Second Post",
  description: "Second Ever Post!"
)
puts post3 = Post.create!(
  title: "Third Post",
  description: "Third Ever Post!"
)
puts post4 = Post.create!(
  title: "Fourth Post",
  description: "Fourth Ever Post!"
)

posts = [post1, post2, post3, post4]

# Users
puts user = User.create!(
  email: 'user@mail.com',
  password: 'password'
)

# Admins
puts admin = Admin.create!(
  email: 'admin@mail.com',
  password: 'password'
)

#  Random Ratings
posts.each do |post|
  (1..5).to_a.sample.times do
    puts post.ratings.create(
      rater: [user, admin].sample,
      value: (1..5).to_a.sample
    )
  end
end
