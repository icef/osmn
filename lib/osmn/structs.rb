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
    :continent)
end