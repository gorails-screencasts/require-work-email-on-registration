class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_account

  protected

  def build_resource(hash = {})
    super
    resource.accounts << @account if @account
  end

  private

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end
end
