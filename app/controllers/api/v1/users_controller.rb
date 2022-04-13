module Api::V1
  class UsersController < ApplicationController

    def create
      service_result = CoreApi::Users::Create.new(params.permit!.to_h).call
      if service_result[:status] != 400
        render json: service_result, status: 201
      else
        render json: service_result, status: 400
      end
    end

    def index
      service_result = CoreApi::Users::ListAll.call
      render json: service_result
    end

    def show
      service_result = CoreApi::Users::Get.new(params.permit!.to_h).call
      if service_result[:status] != 400
        render json: service_result
      else
        render json: service_result, status: 400
      end
    end

  end
end