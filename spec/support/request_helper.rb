# frozen_string_literal: true

# Helper methods for use in request specs.
module RequestHelper

  # Public: Parse response body as JSON.
  #
  # Returns a Hash.
  def response_json
    JSON.parse(response.body)
  end

end
