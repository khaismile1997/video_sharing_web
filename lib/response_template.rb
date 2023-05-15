module ResponseTemplate
  class << self
    def template(code, message)
      { 
        data: { code: code, message: message }
      }
    end
  
    def success(message)
      template(200, message)
    end
  end
end
