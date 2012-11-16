class User
  CHRONICLER_PASSWORD = YAML.load_file('config/passwords.yml')["chronicler"]
  FAMILY_MEMBER_PASSWORD = YAML.load_file('config/passwords.yml')["family_member"]

  LOGINS = {
    :family_member => FAMILY_MEMBER_PASSWORD,
    :chronicler => CHRONICLER_PASSWORD
  }

  def initialize(role)
    role ||= :guest
    @role = role
  end

  def self.auth(role, password)
    LOGINS[role] == password
  end

  def self.get(role)
    User.new(role)
  end

  def guest?
    @role == :guest
  end

  def member?
    @role == :member
  end

  def chronicler?
    @role == :chronicler
  end
end
