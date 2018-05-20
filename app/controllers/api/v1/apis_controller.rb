class Api::V1::ApisController < ApplicationController

  skip_before_action :verify_authenticity_token

end