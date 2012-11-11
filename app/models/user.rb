class User
  ADMIN_PASSWORD = YAML.load_file('config/passwords.yml')["admin"]
  VIEWER_PASSWORD = YAML.load_file('config/passwords.yml')["viewer"]

  def self.auth(role, password)
    const_get("#{role.to_s.upcase}_PASSWORD") == password
  end
end
