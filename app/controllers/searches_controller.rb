class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'IRD1IAABZILDZ5KXIPYFIQDUYLQDAZUW3LLKTL0TGRHCAJHG'
        req.params['client_secret'] = 'NVBXSTBAHYKEBF0K0KQCW0DKNGE0LKIYIXCQ14GC2UPANA3E'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end

end
