class Result < ApplicationRecord
  WEBSITE = "havior-company.herokuapp.com"
  EMPLOYEE_EMAIL = "@havior.co"
  DB_URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vT_ERXgcdZcXKGMgLgCAArtlz_CN4j9730lPb4tAvnaljXNAfBeHlZWNXk0eSApeyZini_S5YnCAPuV/pubhtml?widget=true&amp;headers=false"
  # "https://docs.google.com/spreadsheets/d/e/2PACX-1vQw8FKimNKpoWzaoyowE9yVYf2_RRf5A5oTVJQNIFuNDzsVsv01yuEVY-_LTUwYeSZ6UWfHYzctxzeV/pubhtml?widget=true&amp;headers=false"
  EMPLOYEE_PWDS = [
    "123456",
    "123456789",
    "azerty",
    "qwerty",
    "1234561",
    "loulou",
    "doudou",
    "marseille",
    "azertyuiop",
    "12345678",
    "password",
    "soleil"
  ]
  DB_PASSWORD = "password"
  PLACE = "bedroom".parameterize
  
  validate :website_validation
  validate :employee_email_validation
  validate :employee_pwd_validation
  validate :db_password_validation
  validate :place_validation
  # validate :friends_validation
  # validate :location_validation

  def valid_for?(attrs)
    self.valid?
    validation = true
    attrs.each do |attr|
      validation &= self.errors[attr].blank?
    end
    validation
  end

  def website_validation
    if !website.present? || !website.include?(WEBSITE)
      errors.add(:website, "Ce n'est pas le bon site")
    end
  end

  def employee_email_validation
    employee_emails = User.all.find_all{ |u| (Date.today - u.created_at.to_date).to_i <= 1 }.map(&:employee_email)
    if !employee_email.present? || !employee_email.include?(EMPLOYEE_EMAIL) || employee_emails.include?(employee_email)
      errors.add(:employee_email, "Cet employé a un antivirus. Essayez en un autre")
    end
  end  

  def employee_pwd_validation
    if !employee_pwd.present? || !EMPLOYEE_PWDS.include?(employee_pwd)
      errors.add(:employee_pwd, "Ce n'est pas le bon mot de passe.")
    end
  end

  def db_password_validation
    if !db_password.present? || db_password != DB_PASSWORD
      errors.add(:db_password, "Ce n'est pas le bon mot de passe.")
    end
  end

  def place_validation
    if !place.present? || !place.include?(PLACE)
      errors.add(:place, "Ce n'est pas le bon site")
    end
  end

  # def friends_validation
  #   friends = [friend1&.parameterize, friend2&.parameterize, friend3&.parameterize, friend4&.parameterize, friend5&.parameterize]
  #   if friends != FRIENDS
  #     errors.add(:friend1, "L'ordre est invalide")
  #     errors.add(:friend2, "L'ordre est invalide")
  #     errors.add(:friend3, "L'ordre est invalide")
  #     errors.add(:friend4, "L'ordre est invalide")
  #     errors.add(:friend5, "L'ordre est invalide")
  #   end
  # end

  # def location_validation
  #   if !location.present? || !location.parameterize.include?(LOCATION)
  #     errors.add(:location, "Ce n'est pas le bon animal")
  #   end
  # end

  # def cities_validation
  #   cities = [city1&.downcase, city2&.downcase, city3&.downcase]
  #   if (cities.compact & CITIES).size != 3
  #     errors.add(:city1, "une de ces villes est invalide")
  #     errors.add(:city2, "une de ces villes est invalide")
  #     errors.add(:city3, "une de ces villes est invalide")
  #   end
  # end

end
