class SearchesController < ApplicationController
  def search
    
  end

  def foursquare
    begin
  @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'SHCKFY3BET1XE2UWG1VIMDYWJNL0UDHH4JFVBE005JR55GGQ'
      req.params['client_secret'] = 'PHS2C25S0ID4LGSBM5JK1TQPCOCNLQUJEL5WQCNGCGAA0DG3'
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


