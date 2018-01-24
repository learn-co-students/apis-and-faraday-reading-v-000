class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "1IOPWZI51T542KMCVQJTDIYOD2IJGCXYUPDOZJU4SPOVJBT3"
        req.params['client_secret'] = "T0R0ZGPRJQPZBHHPO04ROIBVXONNCN1ZFDFVKI5V4RPMHN1R"
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

      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
