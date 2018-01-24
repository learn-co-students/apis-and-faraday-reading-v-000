class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "U101Y3FMRY42P1YGHSNMRRRYKYQA1REOVA1WUFGBTXO2VX1O"
        req.params['client_secret'] = "K0FNS35GLZKDK4YVBRVQ03MNNGKKOAIM0RA4TSO3SMADXRTW"
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
