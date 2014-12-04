require 'test/unit'
require 'osmn'

class Tests < Test::Unit::TestCase

  def test_nil_search
    response = OSMN::search

    assert_equal(nil, response)
  end

  def test_nil_reverse
    response = OSMN::reverse_geocode

    assert_equal(nil, response)
  end

  def test_search
    response = OSMN::search('135 pilkington avenue, birmingham')[0]

    assert_equal('83573385', response.place_id)
  end

  def test_reverse
    response = OSMN::reverse_geocode(52.5487921, -1.8164307339635)

    assert_equal('83573385', response.place_id)
  end

  def test_search_with_no_details
    response = OSMN::search('135 pilkington avenue, birmingham', 0)[0]

    assert_respond_to(response, :place_id)
    assert_respond_to(response, :licence)
    assert_respond_to(response, :osm_type)
    assert_respond_to(response, :osm_id)
    assert_respond_to(response, :boundingbox)
    assert_respond_to(response, :lat)
    assert_respond_to(response, :lon)
    assert_respond_to(response, :display_name)
    assert_respond_to(response, :class)
    assert_respond_to(response, :type)

    assert_raise NoMethodError do
      response.address.house_number
    end
  end


  def test_search_with_details
    response = OSMN::search('135 pilkington avenue, birmingham', 1)[0]

    assert_respond_to(response, :place_id)
    assert_respond_to(response, :licence)
    assert_respond_to(response, :osm_type)
    assert_respond_to(response, :osm_id)
    assert_respond_to(response, :boundingbox)
    assert_respond_to(response, :lat)
    assert_respond_to(response, :lon)
    assert_respond_to(response, :display_name)
    assert_respond_to(response, :class)
    assert_respond_to(response, :type)
    assert_respond_to(response, :address)
    assert_respond_to(response, :icon)

    assert_respond_to(response.address, :house_number)
    assert_respond_to(response.address, :road)
    assert_respond_to(response.address, :suburb)
    assert_respond_to(response.address, :city)
    assert_respond_to(response.address, :county)
    assert_respond_to(response.address, :state_district)
    assert_respond_to(response.address, :state)
    assert_respond_to(response.address, :postcode)
    assert_respond_to(response.address, :country)
    assert_respond_to(response.address, :country_code)
  end

  def test_reverse_geocode
    response = OSMN::reverse_geocode(52.5487429714954, -1.81602098644987, 0)

    assert_respond_to(response, :place_id)
    assert_respond_to(response, :licence)
    assert_respond_to(response, :osm_type)
    assert_respond_to(response, :osm_id)
    assert_respond_to(response, :lat)
    assert_respond_to(response, :lon)
    assert_respond_to(response, :display_name)

    assert_raise NoMethodError do
      response.address.house_number
    end
  end

  def test_reverse_geocode_with_address_details
    response = OSMN::reverse_geocode(52.5487429714954, -1.81602098644987, 1)

    assert_respond_to(response, :place_id)
    assert_respond_to(response, :licence)
    assert_respond_to(response, :osm_type)
    assert_respond_to(response, :osm_id)
    assert_respond_to(response, :lat)
    assert_respond_to(response, :lon)
    assert_respond_to(response, :display_name)
    assert_respond_to(response, :address)

    assert_respond_to(response.address, :house_number)
    assert_respond_to(response.address, :road)
    assert_respond_to(response.address, :suburb)
    assert_respond_to(response.address, :city)
    assert_respond_to(response.address, :county)
    assert_respond_to(response.address, :state_district)
    assert_respond_to(response.address, :state)
    assert_respond_to(response.address, :postcode)
    assert_respond_to(response.address, :country)
    assert_respond_to(response.address, :country_code)
  end

  def test_address_detail_bank
    response = OSMN::search('Bank Austria, Rathausplatz, Eisberg, Sankt Pölten, St.Pölten (Stadt), Niederösterreich, 3100, Österreich', 1)[0]

    assert_respond_to(response.address, :bank)
    assert_respond_to(response.address, :pedestrian)
    assert_respond_to(response.address, :town)
  end

  def test_address_detail_residential
    response = OSMN::search('St. Pölten, Eisberg, Sankt Pölten, St.Pölten (Stadt), Niederösterreich, 3100, Österreich', 1)[0]

    assert_respond_to(response.address, :industrial)
    assert_respond_to(response.address, :post_office)
    assert_respond_to(response.address, :residential)
  end

  def test_address_detail_hamlet
    response = OSMN::search('Arezzo, Genova, LIG, Italia', 1)[0]
    assert_respond_to(response.address, :hamlet)
  end

  def test_address_detail_village
    response = OSMN::search('Bologna, Lecco, Lombardia, Italia', 1)[0]
    assert_respond_to(response.address, :village)
  end

  def test_address_detail_school
    response = OSMN::search('Meransen, Prato, Bolzano, Trentino-Alto Adige, Italia', 1)[0]

    assert_respond_to(response.address, :school)
    assert_respond_to(response.address, :city_district)
    assert_respond_to(response.address, :kindergarten)
  end

  def test_address_detail_neighbourhood
    response = OSMN::search('Freiberg, Mühlhausen, Stuttgart, Regierungsbezirk Stuttgart, Baden-Württemberg, 70437, Deutschland', 1)[0]

    assert_respond_to(response.address, :neighbourhood)
    assert_respond_to(response.address, :halt)
  end

  def test_address_detail_farmyard
    response = OSMN::search('Bautzen, Berg, Verwaltungsverband Mittleres Schussental, Landkreis Ravensburg, Regierungsbezirk Tübingen, Baden-Württemberg, 88276, Deutschland', 1)[0]
    assert_respond_to(response.address, :farmyard)
  end

  def test_address_detail_commercial
    response = OSMN::search('SIGMA Technopark Dresden, Übigau, Pieschen, Dresden, Sachsen, 01139, Deutschland', 1)[0]
    assert_respond_to(response.address, :commercial)
  end

  def test_address_detail_recreation_ground
    response = OSMN::search('ESV Dresden Kanu, Cotta, Dresden, Sachsen, 01157, Deutschland', 1)[0]
    assert_respond_to(response.address, :recreation_ground)
  end

  def test_address_detail_allotments
    response = OSMN::search('KGV Dresden-Ost e.V., Seidnitz, Blasewitz, Dresden, Sachsen, 01277, Deutschland', 1)[0]
    assert_respond_to(response.address, :allotments)
  end

  def test_address_detail_farm
    response = OSMN::search('Ravensberg, Petershagen, Kreis Minden-Lübbecke, Regierungsbezirk Detmold, Nordrhein-Westfalen, 32469, Deutschland', 1)[0]
    assert_respond_to(response.address, :farm)
  end

  def test_address_detail_military
    response = OSMN::search('Ludwigsburg, Langholz, Waabs, Schlei-Ostsee, Kreis Rendsburg-Eckernförde, Schleswig-Holstein, 24369, Deutschland', 1)[0]
    assert_respond_to(response.address, :military)
  end

  def test_address_detail_cemetery
    response = OSMN::search('Neuer Jüdischer Friedhof Düsseldorf, Derendorf, Stadtbezirk 1, Düsseldorf, Regierungsbezirk Düsseldorf, Nordrhein-Westfalen, 40468, Deutschland', 1)[0]
    assert_respond_to(response.address, :cemetery)
  end

  def test_address_detail_retail
    response = OSMN::search('Düsseldorf Arcaden, Unterbilk, Stadtbezirk 3, Düsseldorf, Regierungsbezirk Düsseldorf, Nordrhein-Westfalen, 40217, Deutschland', 1)[0]

    assert_respond_to(response.address, :retail)
    assert_respond_to(response.address, :mall)
  end

  def test_address_detail_construction
    response = OSMN::search('Zukünftiger Campus der Fachhochschule Düsseldorf (ehem. Schlachthof und Schlösser-Brauerei), Derendorf, Stadtbezirk 1, Düsseldorf, Regierungsbezirk Düsseldorf, Nordrhein-Westfalen, 40476, Deutschland', 1)[0]
    assert_respond_to(response.address, :construction)
  end

  def test_address_detail_region
    response = OSMN::search('Benidorm, Marina Baja, Provincia de Alicante, Comunidad Valenciana, España', 1)[0]

    assert_respond_to(response.address, :region)
    assert_respond_to(response.address, :station)
    assert_respond_to(response.address, :fuel)
    assert_respond_to(response.address, :playground)
  end

  def test_address_detail_quarry
    response = OSMN::search('Anciennes Ardoisières de Maël Carhaix, Maël-Carhaix, Guingamp, Côtes-d\'Armor, Bretagne, France métropolitaine, 22340, France', 1)[0]
    assert_respond_to(response.address, :quarry)
  end

  def test_address_detail_restaurant
    response = OSMN::search('Nagoya, Fukui Prefecture, Japan', 1)[0]
    assert_respond_to(response.address, :restaurant)
  end

  def test_address_detail_bar
    response = OSMN::search('okazaki, Udagawacho, Shibuya, Tokyo, 150-0044, Japan', 1)[0]

    assert_respond_to(response.address, :bar)
    assert_respond_to(response.address, :footway)
  end

  def test_address_detail_townhall
    response = OSMN::search('Yamagata City Hall, Yamagata, Gifu Prefecture, 501-2192, Japan', 1)[0]
    assert_respond_to(response.address, :townhall)
  end

  def test_address_detail_address29
    response = OSMN::search('Wakayama, Tanabe, Nishiumuro County, Wakayama Prefecture, Kinki Region, Japan', 1)[0]
    assert_respond_to(response.address, :address29)
  end

  def test_address_detail_bus_station
    response = OSMN::search('Beppu, Beppu, Hayami County, Ōita, Japan', 1)[0]
    assert_respond_to(response.address, :bus_station)
  end

  def test_address_detail_clothes
    response = OSMN::search('Kasugai, Ichinomiya, Chita, Aichi, Kinki Region, 491-0043, Japan', 1)[0]
    assert_respond_to(response.address, :clothes)
  end

  def test_address_detail_dry_cleaning
    response = OSMN::search('Kawasaki, Shinagawa-kaido, Hachimancho, Fuchū, Tokio, Japan', 1)[0]
    assert_respond_to(response.address, :dry_cleaning)
  end

  def test_address_detail_island
    response = OSMN::search('Hokkaido, Shintoku, Kamikawa, Hokkaidō, Hokkaidō Region, Japan', 1)[0]
    assert_respond_to(response.address, :island)
  end

  def test_address_detail_bus_stop
    response = OSMN::search('Shinjo, Aramachi, Yurihonjo, Ogachi, Akita, Tohoku Region, Tōhoku, Japan', 1)[0]
    assert_respond_to(response.address, :bus_stop)
  end

  def test_address_detail_building
    response = OSMN::search('Numata, Numata, Tone District, Gunma, Japan', 1)[0]
    assert_respond_to(response.address, :building)
  end

  def test_address_detail_cafe
    response = OSMN::search('Sannōdōri, Syowa, Nagoya, Nishikasugai, Aichi, Chūbu, 466-8585, Japan', 1)[0]
    assert_respond_to(response.address, :cafe)
  end

  def test_address_detail_pub
    response = OSMN::search('Sakai, Midosuji, Fukushima Ward, Senboku District, Osaka Prefecture, 542-0071, Japan', 1)[0]
    assert_respond_to(response.address, :pub)
  end

  def test_address_detail_address26
    response = OSMN::search('Matsuyama, Matsuyama, Kita County, Ehime Prefecture, Shikoku Region, Japan', 1)[0]

    assert_respond_to(response.address, :address26)
    assert_respond_to(response.address, :atm)
  end

  def test_address_detail_hairdresser
    response = OSMN::search('Sendai, 503, Hino, Tokio, Japan', 1)[0]
    assert_respond_to(response.address, :hairdresser)
  end

  def test_address_detail_stationery
    response = OSMN::search('Fukushima, 37, Toyako, Abuta District, Hokkaidō, Japan', 1)[0]
    assert_respond_to(response.address, :stationery)
  end

  def test_address_detail_river
    response = OSMN::search('Ichi Kawa, Kamikawa, Kanzaki County, Hyogo Prefecture, Kinki Region, Japan', 1)[0]
    assert_respond_to(response.address, :river)
  end

  def test_address_detail_optician
    response = OSMN::search('YAMAGUCHI, Minamiawaji, Kako County, Hyogo Prefecture, Kinki Region, Japan', 1)[0]
    assert_respond_to(response.address, :optician)
  end

  def test_address_detail_park
    response = OSMN::search('Shimajiri Mangrove Forest, Miyakojima, Okinawa, Japan', 1)[0]
    assert_respond_to(response.address, :park)
  end

  def test_address_detail_supermarket
    response = OSMN::search('Shimajiri General Store, Miyakojima, Okinawa, Japan', 1)[0]
    assert_respond_to(response.address, :supermarket)
  end

  def test_address_detail_toys
    response = OSMN::search('Toda, Ishikawa-gun, Fukushima, Japan', 1)[0]
    assert_respond_to(response.address, :toys)
  end

  def test_address_detail_brownfield
    response = OSMN::search('Toda, Shiyakusho minami dori, Toda, Minami-Saitama, Saitama, Japan', 1)[0]
    assert_respond_to(response.address, :brownfield)
  end

  def test_address_detail_attraction
    response = OSMN::search('Chiapa de Corzo, Avenida Miguel Hidalgo, Chiapa de Corzo, Chiapas, Mexiko', 1)[0]
    assert_respond_to(response.address, :attraction)
  end

  def test_address_detail_peak
    response = OSMN::search('San Miguel, Rosario de Lerma, Salta, Argentinien', 1)[0]
    assert_respond_to(response.address, :peak)
  end

  def test_address_detail_car_rental
    response = OSMN::search('Olivos, Rivadavia, Bombal, Ciudad de Mendoza, Departamento Capital, Mendoza, Argentinien', 1)[0]
    assert_respond_to(response.address, :car_rental)
  end

  def test_address_detail_parking
    response = OSMN::search('Strombeek-Bever', 1)[0]
    assert_respond_to(response.address, :parking)
  end

  def test_address_detail_information
    response = OSMN::search('Zaventem', 1)[0]

    assert_respond_to(response.address, :cycleway)
    assert_respond_to(response.address, :information)
  end

  def test_address_detail_forest
    response = OSMN::search('Hasselt', 1)[0]
    assert_respond_to(response.address, :forest)
  end

  def test_address_detail_books
    response = OSMN::search('Moscow', 1)[0]
    assert_respond_to(response.address, :books)
  end

  def test_address_detail_house
    response = OSMN::search('Akademgorodok', 1)[0]
    assert_respond_to(response.address, :house)
  end

  def test_address_detail_hotel
    response = OSMN::search('Saratov', 1)[0]

    assert_respond_to(response.address, :hotel)
    assert_respond_to(response.address, :swimming_pool)
  end

  def test_address_detail_ferry_terminal
    response = OSMN::search('Astrakhan', 1)[0]
    assert_respond_to(response.address, :ferry_terminal)
  end

  def test_address_detail_nature_reserve
    response = OSMN::search('Zlin', 1)[0]
    assert_respond_to(response.address, :nature_reserve)
  end

  def test_address_detail_stream
    response = OSMN::search('Jihlava', 1)[0]
    assert_respond_to(response.address, :stream)
  end

  def test_address_detail_marina
    response = OSMN::search('Ceské Budejovice', 1)[0]
    assert_respond_to(response.address, :marina)
  end

  def test_address_detail_aerodrome
    response = OSMN::search('Mlada Boleslav', 1)[0]
    assert_respond_to(response.address, :aerodrome)
  end

  def test_address_detail_bay
    response = OSMN::search('Hawke\'s Bay', 1)[0]

    assert_respond_to(response.address, :bay)
    assert_respond_to(response.address, :locality)
  end

  def test_address_detail_address100
    response = OSMN::search('Mount Maunganui, Tauranga, Bay of Plenty, Neuseeland', 1)[0]
    assert_respond_to(response.address, :address100)
  end

  def test_address_detail_police
    response = OSMN::search('Makati City', 1)[0]

    assert_respond_to(response.address, :pet)
    assert_respond_to(response.address, :police)
    assert_respond_to(response.address, :prison)
  end

  def test_address_detail_place_of_worship
    response = OSMN::search('Pasig City', 1)[0]

    assert_respond_to(response.address, :hospital)
    assert_respond_to(response.address, :place_of_worship)
    assert_respond_to(response.address, :museum)
  end

  def test_address_detail_cinema
    response = OSMN::search('Kiev', 1)[0]
    assert_respond_to(response.address, :cinema)
  end

  def test_address_detail_water
    response = OSMN::search('Simferopol', 1)[0]
    assert_respond_to(response.address, :water)
  end

  def test_address_detail_motel
    response = OSMN::search('Poltava', 1)[0]
    assert_respond_to(response.address, :motel)
  end

  def test_address_detail_tram_stop
    response = OSMN::search('Sevastopol', 1)[0]
    assert_respond_to(response.address, :tram_stop)
  end

end