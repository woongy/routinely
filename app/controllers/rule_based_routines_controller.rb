class RuleBasedRoutinesController < ApplicationController
  before_action :require_login
  before_action :set_routine, only: [:show, :edit, :update, :destroy, :events]

  def show
    @routine.build_rf_listener unless @routine.rf_listener.present?
  end

  def new
    @routine = RuleBasedRoutine.new
  end

  def edit
  end

  def create
    @routine = current_user.group.rule_based_routines.build(routine_params)

    if @routine.save
      redirect_to @routine, notice: "Routine was successfully created."
    else
      render :new
    end
  end

  def update
    if @routine.update(routine_params)
      Flows::SyncService.new(@routine).run!
      redirect_to @routine, notice: "Routine was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @routine.destroy
    Flows::SyncService.new(@routine).run!
    redirect_to routines_url, notice: "Routine was successfully destroyed."
  end

  def events
    @events = @routine.events.recent.page(params[:page])

    respond_to do |format|
      format.js { render partial: "events/events" }
    end
  end

  private

  def set_routine
    @routine = RuleBasedRoutine.find(params[:id])
    authorize @routine
  end

  def routine_params
    params.require(:rule_based_routine).permit(:name, :description, repeats_at: [])
  end
end
