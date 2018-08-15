class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'EN3KNORWPCQU1QZY2QNDTONDP20LHBFRE0GZQMQMVSGVHFZH'
      req.params['client_secret'] = 'YUR10ZYD4QZOS5MQIQAQAVN4PBEACADCDWWHVZHSHJSTBO02'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]  if @resp.success?
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
