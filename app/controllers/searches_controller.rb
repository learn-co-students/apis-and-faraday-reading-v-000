class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'NZ1VHOCSQXPVM142ACNTMEIFFVOQB5TGCFA32PTG5AGA1DNU'
      req.params['client_secret'] = 'YX2TI224TILZATF0AFFWSPDEOTQ3ROGSXMSSMB0KJBJYE0JC'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee'
      #req.options.timeout = 0
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
