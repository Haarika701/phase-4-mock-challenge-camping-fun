class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid,with: :render_try_again
    rescue_from ActiveRecord::RecordInvalid,with: :render_unproccessed_entity
def index
    render json: Camper.all
end

def show
    camper = find_camper
    render json: camper, serializer: CamperActivitySerializer
  end


def create 
    campers = Camper.create!(camper_params)
    render json:campers,status: :created
end


private
# t.string "name"
# t.integer "age"
def camper_params
    params.permit(:name,:age)
end

def find_camper
    Camper.find(params[:id])
  end

def render_try_again
    render json: { error: "Camper not found" }, status: :not_found
end

def render_unproccessed_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
end

end
