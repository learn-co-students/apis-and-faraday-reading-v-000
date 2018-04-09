class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3PKM014A3CAA14O14AYIKJUEH4X4NIGXGAFNQORJ3GLEPAHA'
        req.params['client_secret'] = 'TA1C4IUVSL0PGNX3FGVTXCQAEA2CBVLNR0V4IXUDNFKKX551'
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
      @error = "There was a timeout.  Please try again."
    end
    render 'search'
  end
end
