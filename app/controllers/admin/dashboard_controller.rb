class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTHORIZED_USERNAME'], password: ENV['AUTHORIZED_PASSWORD']

  def show
  end
end
