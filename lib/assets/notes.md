<div>
  <% if @error %>
    <p><%= @error %></p>
  <% elsif @venues %>
    <ul>
    <% @venues.each do |venue| %>
      <li>
        <%= venue["name"] %><br>
        <%= venue["location"]["address"]["city"]["state"]%><br>
        Checkins: <%= venue["stats"]["checkinsCount"] %>
      </li>
    <% end %>
    </ul>
  <% end %>
</div>


  var lat = -34.397;
    var lng = 150.644;

    

Checkins: 652 {
"id"=>"4bcf82989854d13a0139f64d", 
"name"=>"Coffee Shop and Pub", 

"contact"=>{"phone"=>"6036417000", "formattedPhone"=>"(603) 641-7000", "twitter"=>"saintanselm"}, "location"=>{"address"=>"100 Saint Anselm Dr", "lat"=>42.98487704598687, "lng"=>-71.50858014822006, "labeledLatLngs"=>[{"label"=>"display", "lat"=>42.98487704598687, "lng"=>-71.50858014822006}], 

"postalCode"=>"03102", "cc"=>"US", "city"=>"Manchester", "state"=>"NH", "country"=>"United States", "formattedAddress"=>["100 Saint Anselm Dr", "Manchester, NH 03102", "United States"]}, "categories"=>[{"id"=>"4bf58dd8d48988d1a1941735", "name"=>"College Cafeteria", "pluralName"=>"College Cafeterias", "shortName"=>"Cafeteria", "icon"=>{"prefix"=>"https://ss3.4sqi.net/img/categories_v2/education/cafeteria_", "suffix"=>".png"}, "primary"=>true}], "verified"=>true, "stats"=>{"checkinsCount"=>652, "usersCount"=>124, "tipCount"=>2}, "url"=>"http://www.anselm.edu", "venueRatingBlacklisted"=>true, "allowMenuUrlEdit"=>true, "beenHere"=>{"lastCheckinExpiredAt"=>0}, "specials"=>{"count"=>0, "items"=>[]}, "storeId"=>"", "hereNow"=>{"count"=>0, "summary"=>"Nobody here", "groups"=>[]}, "referralId"=>"v-1489779760", "venueChains"=>[], "hasPerk"=>false}