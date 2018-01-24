class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'MFMAP3TMN5JRD5HKW3WRJYVPZUS2FKTD5KC3YNQKF455D1TT'
        req.params['client_secret'] = '2ULVWNYXRT22342L5UOERPVDAW3M1JD5QUMIPIEAEU44J3H4'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body_hash = JSON.parse(@response.body)
      if @response.success?
        @venues = body_hash['response']['venues']
      else
        @error = body_hash["meta"]["errorDetail"]
      end

  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end
