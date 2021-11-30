class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound,with: :render_try_again
    def index
        activity = Activity.all 
        render json:activity
      end

      def destroy
         activity =  Activity.find(params[:id])
         activity.destroy
         head :no_content
      end

      private
      
      def render_try_again
        render json: { error: "Activity not found" }, status: :not_found
      end
end
