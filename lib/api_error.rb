module ApiError
  class RecordInvalid < StandardError
    attr_reader :record

    def initialize(errors)
      @record = errors
    end
  end
end
