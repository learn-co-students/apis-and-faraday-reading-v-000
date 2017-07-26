class SearchesController < ApplicationController

  def search
  end

  def foursquare

  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '1MKH1CZGFIN2JGROMEGYEGU1NYTZWDB2XX5EY21GY1E0V3GH'
        req.params['client_secret'] = 'NIMIJOMIQSEAMABLGGMLHL35I2N2ILFVLUF1U5CIK0EGGZLG'
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
