module ErrorRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ApiError::RecordInvalid,
                ActiveRecord::RecordInvalid,
                with: :handle_422
    
    rescue_from ActiveRecord::RecordNotFound,
                with: :handle_422_with_message

    rescue_from ApiError::Unauthorized,
                with: :handle_401
  end

  private

  def handle_422(exception)
    render json: exception.record,
           serializer: Errors::ValidationErrorsSerializer, adapter: :attributes,
           status: :unprocessable_entity
  end

  def handle_422_with_message(exception)
    render json: {error: {reason: "Record Not Found", message: exception.message}}, status: :unprocessable_entity
  end

  def handle_401(exception)
    render json: {data: {reason: exception.reason, message: exception.message}}, status: :unauthorized
  end
end
