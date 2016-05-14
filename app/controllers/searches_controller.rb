class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'TF4IUQDM0KQNWURTYRPKA0AROTZ1MDVFUSA3MINIQLY5JZXH'
      req.params['client_secret'] = 'Y02IZT53YMP44015F2BOFBLXR1IIQC3XGPUSV4GBWA3SNQZW'
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
      @error = "There was a timeout. Please try again.
    end"
    render 'search'
  end
end
