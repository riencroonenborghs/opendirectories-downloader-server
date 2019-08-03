class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    token = JsonWebToken.encode(user_id: current_user.id)
    time = Time.now + 1.month.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
  end
end