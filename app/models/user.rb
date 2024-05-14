class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable
  ROLES = ['member', 'librarian']

  def librarian?
    role == 'librarian'
  end

  def member?
    role == 'member'
  end
end
