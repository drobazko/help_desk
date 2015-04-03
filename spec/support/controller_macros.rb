module ControllerMacros
  def login_as(role_name)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      role = "#{role_name}_staff" if role_name
      @current_user = create(role.to_sym)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @current_user
    end
  end
end