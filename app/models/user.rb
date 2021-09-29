class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def employee_nick_name
    if !employee_email.blank?
      words = employee_email.split(/[\.@]/)
      first_name = words.first
      last_name = words.second
      return "#{first_name.downcase}#{last_name[0].upcase}"
    else
      ""
    end
  end
end
