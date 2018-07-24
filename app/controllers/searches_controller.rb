class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get "https://api.foursquare.com/v2/venues/search" do |req|
      req.params["client_id"] = '4PFMBTYP2J5GOUWC4UZKZCO0LLJNCT5LQ2RE0NWPEHTS4AHM'
      req.params['client_secret'] = 'Z1AMVKVZVEXDRLH3DRL3C2QOPECT2CVLX2TTVO4ELORSPG0B'
      req.params['v'] = "20160201"
      req.params["near"] = params[:zipcode]
      req.params["query"] = 'coffee shop'
  end
    body= JSON.parse(@resp.body)
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
