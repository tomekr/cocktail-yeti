class ApplicationController < ActionController::Base
  def heartbeat
    render plain: "Aroooooo!"
  end
end
