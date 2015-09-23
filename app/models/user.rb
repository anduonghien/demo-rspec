class User < ActiveRecord::Base

  has_many :posts

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :email, uniqueness: true

  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
