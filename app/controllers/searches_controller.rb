class SearchesController < ApplicationController
    def search
    end

    def foursquare
        begin
            @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
                req.params[:client_id] = 'FLLNAAOPZPI5QWNYD0FJ4QMHWHEDUA1XFPT3TQZPXKQQI4NV'
                req.params[:client_secret] = '4N53LW3AB2LVC4OU5E2BVKCPTHU1DETW3ENZVEV0PO4XFJBT'
                req.params[:v] = '20160201'
                req.params[:near] = params[:zipcode]
                req.params[:intent] = 'checkin'
                req.params[:query] = 'donuts'
            end

            body_hash = JSON.parse(@resp.body)
            if @resp.success?
                @venues = body_hash["response"]["venues"]
            else
                @error = body_hash["meta"]["errorDetail"]
            end

        rescue
            @error = "There was a timeout. Please try again!"
        end

        render 'search'
    end
end
