class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '40WNBC2HWFCS4D2OOY2X04MHRZWG5QX1E0XESZDYV1RHVYLQ'
        req.params['client_secret'] = 'IPLVEHQYDFBAIPNFY01TYILKP33PNWGI0E0ZDPBRUOGSN1DP'
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
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end
end
