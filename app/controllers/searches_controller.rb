class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
      req.params['client_id'] = 'TEADENO1W4C5FCOGHQLBW0IJROMA52CSUYZZHVJ3MMXIFVJ2'
      req.params['client_secret'] = 'RJUNMLSMSBDEGWE0NEW0IM3SJC120C32TPM5NFVY22EP3W1P'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee'
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
