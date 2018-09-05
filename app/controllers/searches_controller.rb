class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'XLUSJZZ5C5QR5TW0NDZWEK4PK0QAU30GIRS2FN0TM4P4NKQ2'
      req.params['client_secret'] = 'IEFWVNKLTF3C1IKAF0G3EER2PUBLG5P5I05KD4W14FA31CSQ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'

      # req.options.timeout = 0
    end 

    body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
    end

  # rescue Faraday::ConnectionFailed
  #   @error = "There was a timeout. PLease try again."

    render 'search'
  end
end