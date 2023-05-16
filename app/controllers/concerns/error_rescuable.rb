module ErrorRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ApiError::RecordInvalid,
                ActiveRecord::RecordInvalid,
                with: :handle_422
    
    rescue_from ActiveRecord::RecordNotFound,
                ApiError::Youtube::VideoNotExisted,
                with: :handle_404_with_message

    rescue_from ApiError::Unauthorized,
                with: :handle_401
    
    rescue_from ApiError::Auth::Unauthorized,
                with: :handle_401_with_message
  end

  private

  def handle_422(exception)
    render json: exception.record,
           serializer: Errors::ValidationErrorsSerializer, adapter: :attributes,
           status: :unprocessable_entity
  end

  def handle_422_with_message(exception)
    render json: {error: {reason: 'INVALID_PARAMS', message: exception.message}}, status: :unprocessable_entity
  end

  def handle_401(exception)
    render json: {error: {reason: exception.reason, message: exception.message}}, status: :unauthorized
  end

  def handle_401_with_message(exception)
    render json: {error: {reason: 'INVALID_PAYLOAD', message: exception.message}}, status: :unauthorized
  end

  def handle_404_with_message(exception)
    render json: {error: {reason: 'RECORD_NOT_FOUND', message: exception.message}}, status: :not_found
  end
end
