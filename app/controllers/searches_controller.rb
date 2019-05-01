class SearchesController < ApplicationController
  def search
  end

  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'IW5SWFWJSOGUGBPCZOM45D40PSVIPRZJQ0P5K0HJVYO3VBEB'
        req.params['client_secret'] = 'U21MCYANBSC4LS3SDZVMCVY4FJPBOYNXZOXYQ0HODALTN3Z5'
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
