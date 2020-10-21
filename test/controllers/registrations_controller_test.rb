require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
  end

  test "can register with company email" do
    host! "#{@account.subdomain}.myapp.com"

    assert_difference "User.count" do
      post user_registration_url, params: {
        user: {
          name: "Test User",
          email: "test@#{@account.email_domain}",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
  end

  test "cannot register with a non-company email" do
    host! "#{@account.subdomain}.myapp.com"

    assert_no_difference "User.count" do
      post user_registration_url, params: {
        user: {
          name: "Test User",
          email: "test@invalid.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_match "Email must be an @#{@account.email_domain} address", response.body
  end
end
