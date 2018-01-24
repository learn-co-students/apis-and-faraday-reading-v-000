class SearchesController < ApplicationController
  def search
  end

  def foursquare
     begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'FNYM0NVDZZV40XCB5NU5CBX0UURYESQHCKZEL2JQFSNEZ4K4'
        req.params['client_secret'] = 'W0S0QOP1PGJKHQJ3R3E5TXTMAFOXK1NRS51ZCOECUZDUFLKE'
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
