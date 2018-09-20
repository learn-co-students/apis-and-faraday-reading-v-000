class SearchesController < ApplicationController
  def search
  end

  def foursquare
   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "BCLQ1JM1QV2IOBB0BGQWP5CK2BDY0T4NYJMKIK14TUE0APID"
      req.params['client_secret'] = "QCN5LNYY4VN125SNOZFW5NEYUDL0NGNSGB1FDJNOIBAG00T1"
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
    render 'search'
  end
end
