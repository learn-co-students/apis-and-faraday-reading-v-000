class SearchesController < ApplicationController
  def search
  end

   def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "MCCSQ2DZQVLVL3W20NWRPWBTRPWTNLFNO033C0CCZEGZVS4N"
      req.params['client_secret'] = "LGD3BP5J34Y3R0HJQWIPKENHK5SAPGDW3HDBM1040SDVNGMR"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 0
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
