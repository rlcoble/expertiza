class ScrubDatabase
  def self.run!
    puts "Scrubbing #{User.count} users"
    User.all.each do |user|
      user.name = "user#{user.id}"
      user.fullname = "#{user.id}, #{user.role.name}"
      user.email = "expertiza@mailinator.com"

      user.password = "password"
      user.password_confirmation = "password"

      user.save(false)
      print "." if user.id % 100 == 0
    end
    puts "Done!"
  end
end
