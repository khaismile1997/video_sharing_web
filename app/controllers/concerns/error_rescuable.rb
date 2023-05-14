module ErrorRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ApiError::RecordInvalid,
                ActiveRecord::RecordInvalid,
                with: :handle_422
    
    rescue_from ActiveRecord::RecordNotFound,
                with: :handle_422_with_message
  end

  private

  def handle_422(exception)
    render json: exception.record,
           serializer: Errors::ValidationErrorsSerializer, adapter: :attributes,
           status: 422
  end

  def handle_422_with_message(exception)
    render json: {error: {reason: "Record Not Found", message: exception.message}}, status: 422
  end
end
