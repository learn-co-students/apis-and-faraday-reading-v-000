class SearchesController < ApplicationController
  def search

  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '0VNIVSMDP2U0Y3K5HWTW2BK4EEVSX5DBAFJ5HTYZ14AR0WMN'
      req.params['client_secret'] = 'A5CFTPNX0NWP1B1OD140OILS4IDZCQ1B2AIFHEFQJDVNZGWO'
      req.params['v'] = '20181025'
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
