class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "KVCELWB3XRQDXSIDCDY1NPL2ZDM2FIHLU53MY1UDTYTR4HX0"
        req.params['client_secret'] = "HHBE3CD1IOS4OQ14M204W2HV3T2JMG2ICJ4GB555JVASZMI4"
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

