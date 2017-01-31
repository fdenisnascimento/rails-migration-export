class CallbackController < ApplicationController
  def create
    render json: {"status_code":200}, status: 201
  end
end
