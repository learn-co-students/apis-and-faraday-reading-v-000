class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'UMTL0TMOR5QIIW1FY40SIC4MWYFY4YQVZAP0DXBO3T2WDDCK'
        req.params['client_secret'] = '1DWHYTQT2DWRTCSDIUHDNFG3SR1BE12DPV0QV2TGKCDBRJ2H'
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
      @error = "There was a timeout. Please try again"
    end
    render 'search'
  end
end
