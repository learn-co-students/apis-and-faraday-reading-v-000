class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
          client_id = 'WVRZD0XXWGXNZFFEMBPTZOROUQ5ITF0IJ2Q4WH4DCUNXCNYV'
          client_secret = '0EDFS5VNVUVYPQFK4T3YIUCWAW2Y51NSFAKGVHZQMWANQJDC'
          req.params['client_id'] = client_id
          req.params['client_secret'] = client_secret
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
        end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
