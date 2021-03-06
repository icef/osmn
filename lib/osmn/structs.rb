module OSMN
  Result = Struct.new(
    :place_id, 
    :licence, 
    :osm_type, 
    :osm_id, 
    :boundingbox,
    :lat, 
    :lon, 
    :display_name, 
    :class,
    :type,
    :importance,
    :address,
    :icon)

  Address = Struct.new(
    :house_number, 
    :road, 
    :suburb,
    :city, 
    :county, 
    :state_district, 
    :state, 
    :postcode, 
    :country, 
    :country_code,
    :continent,
    # extra address details
    :aerodrome,
    :allotments,
    :atm,
    :attraction,
    :bank,
    :bar,
    :bay,
    :books,
    :brownfield,
    :building,
    :bus_station,
    :bus_stop,
    :cafe,
    :car_rental,
    :car_rental,
    :cemetery,
    :cinema,
    :city_district,
    :clothes,
    :commercial,
    :construction,
    :cycleway,
    :dry_cleaning,
    :farm,
    :farmyard,
    :ferry_terminal,
    :footway,
    :forest,
    :fuel,
    :hairdresser,
    :halt,
    :hamlet,
    :hospital,
    :hotel,
    :house,
    :industrial,
    :information,
    :island,
    :kindergarten,
    :locality,
    :mall,
    :marina,
    :military,
    :motel,
    :museum,
    :nature_reserve,
    :neighbourhood,
    :optician,
    :park,
    :parking,
    :peak,
    :pedestrian,
    :pet,
    :place_of_worship,
    :playground,
    :police,
    :post_office,
    :prison,
    :pub,
    :quarry,
    :recreation_ground,
    :region,
    :residential,
    :restaurant,
    :retail,
    :river,
    :school,
    :station,
    :stationery,
    :stream,
    :stream,
    :supermarket,
    :swimming_pool,
    :town,
    :townhall,
    :toys,
    :tram_stop,
    :village,
    :water,
    # unclear address details
    :address26,
    :address29,
    :address100
  )
end