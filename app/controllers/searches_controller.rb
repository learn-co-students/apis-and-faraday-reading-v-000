class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "Q51NKFU1NAQNHJ03OJKUGVDJ1XYK40CGEQX4VBG4BFHENVHK"
        req.params['client_secret'] = "0KYTHOUQ4VCZOJMUPAYSPJCOCOPZN5TDW5A2CX15SF0CMIMG"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options .timeout = 0
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

      rescue Faraday::TimeoutError
        @error = "There was a timeout. Pleas try again."
      end
    render 'search'
    end
end
