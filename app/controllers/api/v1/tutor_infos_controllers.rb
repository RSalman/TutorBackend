class TutorInfosController < ApplicationController
  before_action :set_tutor_info, only: [:show, :update, :destroy]

  # GET /tutor_infos
  def index
    @tutorinfos = TutorInfo.all
    json_response(@tutorinfos)
  end

  # POST /tutor_infos
  def create
    @tutor_info = TutorInfo.create!(tutor_info_params)
    json_response(@tutor_info, :created)
  end

  # GET /tutor_infos/:id
  def show
    json_response(@tutor_info)
  end

  # PUT /tutor_infos/:id
  def update
    @tutor_info.update(tutor_info_params)
    head :no_content
  end

  # DELETE /tutor_infos/:id
  def destroy
    @tutor_info.destroy
    head :no_content
  end

  private

  def tutor_info_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_tutor_info
    @tutor_info = TutorInfo.find(params[:id])
  end
end