class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params[:client_id] = 'NJFKN5SDRYJ34ROXEPUL35HHBPBVVUGNLYAJWKXAHGWJVZJ1'
        req.params[:client_secret] = 'ITBVDDEGFBDFKMPXHTGDCDG24JQYULNRVJFFIO553J3G5Q4C'
        req.params[:v] = '20160201'
        req.params[:near] = params[:zipcode]
        req.params[:query] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["error_detail"]
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
