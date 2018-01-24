class SearchesController < ApplicationController
  def search
  end

  def foursquare
  @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '4YEOZLRBQKEMHZV41SGAUWTFJ5M3XX4IN22WJ0Y5YEWOIKOC'
      req.params['client_secret'] = 'UK0X2CALSUFOIRB12DHKW2IML1FXCJ4LKAQHEPL0HVBV5CQF'
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
  end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    render 'search'
  end
