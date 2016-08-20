module Api
  class CalendarsController < ApplicationController
    before_action :require_login

    def show
      render json: (current_user.group.time_based_routines + current_user.group.rule_based_routines + current_user.group.periodic_routines), root: "events"
    end
  end
end