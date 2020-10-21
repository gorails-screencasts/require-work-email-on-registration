class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name

  has_many :notifications, as: :recipient
  has_many :services
  has_many :account_users
  has_many :accounts, through: :account_users

  validate :email_matches_account_domain

  def email_matches_account_domain
    return if accounts.none?

    email_domain = "@#{accounts.first.email_domain}"
    unless email.ends_with?(email_domain)
      errors.add :email, "must be an #{email_domain} address"
    end
  end
end
