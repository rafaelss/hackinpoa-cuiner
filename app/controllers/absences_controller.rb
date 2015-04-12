class AbsencesController < ApplicationController
  def index
    absences = current_user.absences
    respond_with(absences)
  end

  def create
    absence = current_user.absences.create(params.permit(:at, :shift))
    respond_with(absence, location: nil)
  end
end
