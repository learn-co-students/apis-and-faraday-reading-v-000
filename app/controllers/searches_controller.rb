class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'YPQCWAG5HVQR5ANL3BD30F0PE4HBAAS5KNKGLMY1I4ZJZZ23'
      req.params['client_secret'] = '55RLPDEAG4KED5ISF2FFAYYDOHBXHZ4DNDWHMITHZDB4SQ0W'
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
