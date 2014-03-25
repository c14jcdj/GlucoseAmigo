class DashboardController < ApplicationController
  before_filter :load_diabetic, only: [:diabetic]
  def get
    choices = params[:menu_choice].split(':')
    @diabetic = Diabetic.find(choices[1].split('--')[1]) if choices[0] == 'Diabetic'
    render :partial => 'shared/menu', :locals => {
                                                    diabetic: @diabetic,
                                                    account: current_account
                                                  }
  end

  def diabetic
    render :partial => "dashboard/diabetic", :locals => {
                                                        diabetic: @diabetic,
                                                        account: current_account,
                                                        prefPath: getPreferencePath,
                                                        doctorPath: getDoctorPath
                                                      }
  end

  private
  def load_diabetic
    @diabetic = Diabetic.find(params[:id])
  end

  def getPreferencePath
    if !!@diabetic.preference
      edit_diabetic_preference_path(@diabetic.id, @diabetic.preference.id)
    else
      new_diabetic_preference_path(@diabetic.id)
    end
  end

  def getDoctorPath
    if !!@diabetic.doctor
      edit_diabetic_doctor_path(@diabetic, @diabetic.doctor)
    else
      new_diabetic_doctor_path(@diabetic)
    end
  end
end
