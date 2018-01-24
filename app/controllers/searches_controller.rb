class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = "P2VF5QSY2XYWBYE0QUADETN3JLVOO24J5O4CRCRW3XOE1NTF"
          req.params['client_secret'] = "PW4G2ZUJ4FD0A0LPRMZHSB0F1S3RCO3FQYITSXCQXMDHY345"
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
        end
        body = JSON.parse(@resp.body)
        if @resp.success?
          @venues = body["response"]["venues"]
        else
          @error = body["meta"]["errorDetail"]
        end
   
      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
      end
      render 'search'
    end
end
