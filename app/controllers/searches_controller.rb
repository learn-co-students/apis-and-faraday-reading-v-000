class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'YEC0ZAUM0I3XGRSOUK1WRSUS0K50WMQF1N4JTFTGFUOF5HGT'
        req.params['client_secret'] = 'SHG3YLYMWXJYERJDDIA152ASPT5ZKE3RVG2BBUYTNP3BZFRD'
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
