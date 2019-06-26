class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params["client_id"] = 'Y2LCGIK5EGTOFNVYXY5HDSUMO03MIDA3ZC3S3RCARPCAWK0P'
      req.params["client_secret"] = 'Q5ZCJCF12ROMW5LR0140HXN5HXLMH22GD4W5RXMADSBV12CF'
      req.params["v"] = '20190625'
      req.params["near"] = params[:zipcode]
      req.params["query"] = 'coffee shops'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end
  rescue Faraday::ConnectionFailed
    @error = "Request timed out. Please try again."
  end

    render 'search'
  end


end
