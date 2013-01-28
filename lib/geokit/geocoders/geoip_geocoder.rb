require 'geoip'
class Geokit::Geocoders::GeoipGeocoder < Geokit::Geocoders::Geocoder

  cattr_accessor :database
  self.database = nil


  def self.do_geocode(ip_address, options={})
    if database and response = database.city(ip_address)
      res = GeoKit::GeoLoc.new
      res.provider = 'geoip'
      res.city = response.city_name
      res.state = response.region_name
      res.country = response.country_name
      res.country_code = response.country_code2
      res.lat = response.latitude
      res.lng = response.longitude
      res.success = !response.city_name.to_s.empty?
      res
    else
      GeoKit::GeoLoc.new
    end
  rescue => e

    logger.error "Caught an error during GeoipGeocoder geocoding call: #{$!}"

    GeoKit::GeoLoc.new
  end

end
