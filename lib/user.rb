require 'bcrypt'
require 'json'

class User
  attr_accessor :username, :password

  @@users = []

  def initialize(username, password, existing_hash = false)
    @username = username
    @password = existing_hash ? BCrypt::Password.new(password) : BCrypt::Password.create(password)
    @@users << self
  end

  def self.all
    @@users
  end

  # authenticate user to login
  def self.authenticate(username, password)
    user = User.find_by_username(username)

    if user && user.password == password
      return user
    else
      return nil
    end
  end

  def self.find_by_username(username)
    user = all.find do |u|
      u.username == username
    end
    user
  end

  def self.store_credentials(user)
    # Step 1. Create a file if it doesn't exist
    file_path = "users.json"
    unless File.exist?(file_path)
      File.open(file_path, "w") { |file| file.write(JSON.generate([]))}
    end

    # Step 2. Add user to the file
    file = File.read(file_path)
    users_data = JSON.parse(file)

    users_data << { username: user.username, password: user.password }

    File.open(file_path, "w") { |file| file.write(JSON.generate(users_data)) }
  end

  def self.load_users_from_file
    file_path = 'users.json'

    if File.exist?(file_path)
      # Step 1: parse data from file
      file = File.read(file_path)

      users_data = JSON.parse(file)

      # Step 2: Iterate and create user instances from an array of hashes
      users_data.each do |user_data|
        User.new(user_data['username'], user_data['password'])
      end
    end
  end
end
