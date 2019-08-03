class ApiController < ApplicationController
  before_action :authorize_request!
end