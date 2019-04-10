class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = WFL3Y0FI0BVLDCPRNC5DVDUGJAIBL5VO04IEIG3A45IKM4I5
      req.params['client_secret'] = WFSTSVYS5NV2FHNOGIKGOIQ52DYQ3YMHR3JJ4WZ0E2ZMSVAZ
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
end
