require "numru/netcdf"

class WorkflowsController < ApplicationController
  # GET /workflows
  # GET /workflows.json
  def index
    @workflows = Workflow.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workflows }
    end
  end

  # GET /workflows/1
  # GET /workflows/1.json
  def show
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workflow }
    end
  end

  # accepts a longitude, latitude:
    # http://localhost:3000/get_biome?lng=-89.25&lat=41.75
    # OR
    # $.post("get_biome", { lng: 106, lat: 127 });
  # returns JSON object of the biome
  def get_biome
    @request_lng = params[:lng].to_f
    @request_lat = params[:lat].to_f
    # used by each file
    @dims = {}

    def remap_range(input, in_low, in_high, out_low, out_high)
      # map onto [0,1] using input range
      frac = ( input - in_low ) / ( in_high - in_low )
      # map onto output range
      ( frac * ( out_high - out_low ) + out_low ).to_i.round()
    end


    #### Saatchi: ####
    ## asia_agb_1km
    # http://localhost:3000/get_biome.json?lng=113.8042&lat=1.918004 # => 90.7488
    @saatchi_asia_bgb = NumRu::NetCDF.open("netcdf/saatchi_asia_bgb_1km.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @saatchi_asia_bgb.var("lat")
    @dims["lon"] = @saatchi_asia_bgb.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @saatchi_asia_bgb_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @saatchi_asia_bgb_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @saatchi_asia_bgb.var_names[-1]
      @saatchi_asia_bgb_num = @saatchi_asia_bgb.var( @file_var_name )[ @saatchi_asia_bgb_i, @saatchi_asia_bgb_j, 0, 0 ][0]
#      puts "################### america_bgb_1km ####################"
#      puts @saatchi_asia_bgb_num
      @saatchi_asia_bgb.close()
    end  
    
    ## asia_agb_1km
    # http://localhost:3000/get_biome.json?lng=113.8042&lat=1.918004 # => 353.926
    @saatchi_asia_agb = NumRu::NetCDF.open("netcdf/saatchi_asia_agb_1km.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @saatchi_asia_agb.var("lat")
    @dims["lon"] = @saatchi_asia_agb.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @saatchi_asia_agb_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @saatchi_asia_agb_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @saatchi_asia_agb.var_names[-1]
      @saatchi_asia_agb_num = @saatchi_asia_agb.var( @file_var_name )[ @saatchi_asia_agb_i, @saatchi_asia_agb_j, 0, 0 ][0]
#      puts "################### america_bgb_1km ####################"
#      puts @saatchi_asia_agb_num
      @saatchi_asia_agb.close()
    end  
    
    ## america_agb_1km
    # http://localhost:3000/get_biome.json?lng=-54.91339&lat=1.91196 # => 83.0064
    @saatchi_america_bgb = NumRu::NetCDF.open("netcdf/saatchi_america_bgb_1km.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @saatchi_america_bgb.var("lat")
    @dims["lon"] = @saatchi_america_bgb.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @saatchi_america_bgb_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @saatchi_america_bgb_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @saatchi_america_bgb.var_names[-1]
      @saatchi_america_bgb_num = @saatchi_america_bgb.var( @file_var_name )[ @saatchi_america_bgb_i, @saatchi_america_bgb_j, 0, 0 ][0]
#      puts "################### america_bgb_1km ####################"
#      puts @saatchi_america_bgb_num
      @saatchi_america_bgb.close()
    end  
    
    ## america_agb_1km
    # http://localhost:3000/get_biome.json?lng=-53.78006&lat=1.345293 # => 251.726
    @saatchi_america_agb = NumRu::NetCDF.open("netcdf/saatchi_america_agb_1km.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @saatchi_america_agb.var("lat")
    @dims["lon"] = @saatchi_america_agb.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @saatchi_america_agb_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @saatchi_america_agb_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @saatchi_america_agb.var_names[-1]
      @saatchi_america_agb_num = @saatchi_america_agb.var( @file_var_name )[ @saatchi_america_agb_i, @saatchi_america_agb_j, 0, 0 ][0]
#      puts "################### america_agb_1km ####################"
#      puts @saatchi_america_agb_num
      @saatchi_america_agb.close()
    end  
    
    ## africa_bgb_1km
    # http://localhost:3000/get_biome.json?lng=-7.470817&lat=5.702878 # => 60.4312
    @saatchi_africa_bgb = NumRu::NetCDF.open("netcdf/saatchi_africa_bgb_1km.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @saatchi_africa_bgb.var("lat")
    @dims["lon"] = @saatchi_africa_bgb.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @saatchi_africa_bgb_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @saatchi_africa_bgb_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @saatchi_africa_bgb.var_names[-1]
      @saatchi_africa_bgb_num = @saatchi_africa_bgb.var( @file_var_name )[ @saatchi_africa_bgb_i, @saatchi_africa_bgb_j, 0, 0 ][0]
#      puts "################### africa_bgb_1km ####################"
#      puts @saatchi_africa_bgb_num
      @saatchi_africa_bgb.close()
    end   

    ## africa_agb_1km
    # http://localhost:3000/get_biome.json?lng=-8.47915&lat=6.061211 # => 343.329
    @saatchi_africa_agb = NumRu::NetCDF.open("netcdf/saatchi_africa_agb_1km.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @saatchi_africa_agb.var("lat")
    @dims["lon"] = @saatchi_africa_agb.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @saatchi_africa_agb_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @saatchi_africa_agb_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @saatchi_africa_agb.var_names[-1]
      @saatchi_africa_agb_num = @saatchi_africa_agb.var( @file_var_name )[ @saatchi_africa_agb_i, @saatchi_africa_agb_j, 0, 0 ][0]
#      puts "################### africa_agb_1km ####################"
#      puts @saatchi_africa_agb_num
      @saatchi_africa_agb.close()
    end   




    #### Brazil: ####
    
    ## Brazil Sugarcane
    # This map has an ij coordinate range of (0,0) to (59, 44)
    # top left LatLng being (-60.25 ,-4.75)
    # bottom right LatLng being (-30.75 ,-26.75)
    # Therefore it sits between:
    # Lat -4.75 and -26.75
    # Lon -30.75 and -60.25
    if ( -4.75 >= @request_lat && @request_lat >= -26.75 && -30.75 >= @request_lng && @request_lng >= -60.25 )
      @braz_sugarcane_i = remap_range( @request_lng, -30.75, -60.25, 0, 59 )
      @braz_sugarcane_j = remap_range( @request_lat, -4.75, -26.75, 0, 44 ) # j == 0 where lat is at its lowest value
      @braz_sugarcane = NumRu::NetCDF.open("netcdf/GCS/Crops/Brazil/Sugarcane/brazil_sugc_latent_10yr_avg.nc")
      @braz_sugarcane_num = @braz_sugarcane.var("latent")[@braz_sugarcane_i,@braz_sugarcane_j,0,0][0]
      @braz_sugarcane.close()
      
      # Hacks for testing out saatchi dataset
      @braz_saatchi_carbon = 10
    end

    #### Global biomes: ####

    ## Global biomes: tundra
    # http://localhost:3000/get_biome.json?lng=-150.9497&lat=69.61112 # => 17077
    @global_biome_tundra = NumRu::NetCDF.open("netcdf/GCS/biomes/Tundra.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_tundra.var("lat")
    @dims["lon"] = @global_biome_tundra.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_tundra_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_tundra_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_tundra.var_names[-1]
      @global_biome_tundra_num = @global_biome_tundra.var( @file_var_name )[ @global_biome_tundra_i, @global_biome_tundra_j, 0, 0 ][0]
#      puts "################### global biome tundra ####################"
#      puts @global_biome_tundra_num
      @global_biome_tundra.close()
    end   


    ## Global biomes: savanna
    # http://localhost:3000/get_biome.json?lng=-0.2647708&lat=12.52548 # => 10139
    @global_biome_savanna = NumRu::NetCDF.open("netcdf/GCS/biomes/TropicalSavanna.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_savanna.var("lat")
    @dims["lon"] = @global_biome_savanna.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_savanna_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_savanna_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_savanna.var_names[-1]
      @global_biome_savanna_num = @global_biome_savanna.var( @file_var_name )[ @global_biome_savanna_i, @global_biome_savanna_j, 0, 0 ][0]
#      puts "################### global biome savanna ####################"
#      puts @global_biome_savanna_num
      @global_biome_savanna.close()
    end

    
    ## Global biomes: peat
    # http://localhost:3000/get_biome.json?lng=22.01513&lat=-0.6995686 # => 10088
    @global_biome_peat = NumRu::NetCDF.open("netcdf/GCS/biomes/TopicalForestAndPeatForest.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_peat.var("lat")
    @dims["lon"] = @global_biome_peat.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_peat_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_peat_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_peat.var_names[-1]
      @global_biome_peat_num = @global_biome_peat.var( @file_var_name )[ @global_biome_peat_i, @global_biome_peat_j, 0, 0 ][0]
#      puts "################### global biome peat ####################"
#      puts @global_biome_peat_num
      @global_biome_peat.close()
    end 
    
    
    ## Global biomes: temperate_scrub
    # http://localhost:3000/get_biome.json?lng=-4.978971&lat=39.16113 # => 16
    @global_biome_temperate_scrub = NumRu::NetCDF.open("netcdf/GCS/biomes/TemperateScrubAndWoodland.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_temperate_scrub.var("lat")
    @dims["lon"] = @global_biome_temperate_scrub.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_temperate_scrub_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_temperate_scrub_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_temperate_scrub.var_names[-1]
      @global_biome_temperate_scrub_num = @global_biome_temperate_scrub.var( @file_var_name )[ @global_biome_temperate_scrub_i, @global_biome_temperate_scrub_j, 0, 0 ][0]
#      puts "################### global biome temperate_scrub ####################"
#      puts @global_biome_temperate_scrub_num
      @global_biome_temperate_scrub.close()
    end   
    
    
    # Global biomes: temperate_grassland
    # http://localhost:3000/get_biome.json?lng=39.89124&lat=36.02617 # => 16
    @global_biome_temperate_grassland = NumRu::NetCDF.open("netcdf/GCS/biomes/TemperateGrassland.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_temperate_grassland.var("lat")
    @dims["lon"] = @global_biome_temperate_grassland.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_temperate_grassland_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_temperate_grassland_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_temperate_grassland.var_names[-1]
      @global_biome_temperate_grassland_num = @global_biome_temperate_grassland.var( @file_var_name )[ @global_biome_temperate_grassland_i, @global_biome_temperate_grassland_j, 0, 0 ][0]
#      puts "################### global biome temperate_grassland ####################"
#      puts @global_biome_temperate_grassland_num
      @global_biome_temperate_grassland.close()
    end
    
    
    
    ## Global biomes: temperate_forest
    # http://localhost:3000/get_biome.json?lng=-80.58157&lat=38.78027 # => 10031
    @global_biome_temperate_forest = NumRu::NetCDF.open("netcdf/GCS/biomes/TemperateForest.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_temperate_forest.var("lat")
    @dims["lon"] = @global_biome_temperate_forest.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_temperate_forest_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_temperate_forest_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_temperate_forest.var_names[-1]
      @global_biome_temperate_forest_num = @global_biome_temperate_forest.var( @file_var_name )[ @global_biome_temperate_forest_i, @global_biome_temperate_forest_j, 0, 0 ][0]
#    puts "################### global biome temperate_forest ####################"
#    puts @global_biome_temperate_forest_num
      @global_biome_temperate_forest.close()
    end


    
    ## Global biomes: Boreal
    # http://localhost:3000/get_biome.json?lng=-117.6874&lat=60.88063 # => 17060
    @global_biome_boreal = NumRu::NetCDF.open("netcdf/GCS/biomes/NorthernPeatlandAndBorealForest.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_boreal.var("lat")
    @dims["lon"] = @global_biome_boreal.var("lon")

    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_boreal_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_boreal_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_boreal.var_names[-1]
      @global_biome_boreal_num = @global_biome_boreal.var( @file_var_name )[ @global_biome_boreal_i, @global_biome_boreal_j, 0, 0 ][0]
#    puts "################### global biome boreal ####################"
#    puts @global_biome_boreal_num
      @global_biome_boreal.close()
    end
    
    
    ## Global biomes: Marsh
    # http://localhost:3000/get_biome.json?lng=-32.02963&lat=7.605901 # => 10147
    @global_biome_marsh = NumRu::NetCDF.open("netcdf/GCS/biomes/MarshAndSwampland.nc")
    @dims.clear # ensure hash is empty
    @dims["lat"] = @global_biome_marsh.var("lat")
    @dims["lon"] = @global_biome_marsh.var("lon")
    if ( @dims["lat"].get.min <= @request_lat && @request_lat <= @dims["lat"].get.max && @dims["lon"].get.min <= @request_lng && @request_lng <= @dims["lon"].get.max )
      @global_biome_marsh_i = remap_range( @request_lng, @dims["lon"].get.min, @dims["lon"].get.max, 0, @dims["lon"].get.shape[0] )
      # high and low values are counter-intuitive ... but are infact correct
      @global_biome_marsh_j = remap_range( @request_lat, @dims["lat"].get.max, @dims["lat"].get.min, 0, @dims["lat"].get.shape[0] )
      @file_var_name = @global_biome_marsh.var_names[-1]
#      @global_biome_marsh_num = @global_biome_marsh.var( @file_var_name )[ 382, 127, 0, 0 ][0]
      @global_biome_marsh_num = @global_biome_marsh.var( @file_var_name )[ @global_biome_marsh_i, @global_biome_marsh_j, 0, 0 ][0]
#    puts "################### global biome marsh ####################"
#    puts @global_biome_marsh_num
      @global_biome_marsh.close()
    end


    ## Global biomes: Desert
    # This map has an ij coordinate range of (0,0) to (766, 250)
    # top left LatLng being (50.9873 ,-121.142)
    # bottom right LatLng being (-35.2665 ,143.854)
    # Therefore it sits between:
    # Lat -35.2665 and 50.9873
    # Lon -121.142 and 143.854
    # http://localhost:3000/get_biome.json?lng=-8.758202&lat=24.31446 # => 10698
    if ( 50.9873 >= @request_lat && @request_lat >= -35.2665 && 143.854 >= @request_lng && @request_lng >= -121.142 )
      @global_biome_desert_i = remap_range( @request_lng, -121.142, 143.854, 0, 766 )
      @global_biome_desert_j = remap_range( @request_lat, 50.9873, -35.2665, 0, 250 ) # high and low values are counter-intuitive
      @global_biome_desert = NumRu::NetCDF.open("netcdf/GCS/biomes/Desert.nc")
      @global_biome_desert_num = @global_biome_desert.var("dsrt")[@global_biome_desert_i,@global_biome_desert_j,0,0][0]
      @global_biome_desert.close()
    end
#    puts "################### global biome desert ####################"
#    puts @global_biome_desert_num

    ## Global pasture
    # This map has an ij coordinate range of (0,0) to (4320, 2160)
    # top left LatLng being (89.9583 ,-179.9583)
    # bottom right LatLng being (-89.9583 ,179.9583)
    # Therefore it sits between:
    # Lat -89.9583 and 89.9583
    # Lon -179.9583 and 179.9583
    # http://localhost:3000/get_biome.json?lng=-101.0417&lat=44.95834 # => 0.9817577600479126
    if ( 89.9583 >= @request_lat && @request_lat >= -89.9583 && 179.9583 >= @request_lng && @request_lng >= -179.9583 )
      @global_pasture_i = remap_range( @request_lng, -179.9583, 179.9583, 0, 4320 )
      @global_pasture_j = remap_range( @request_lat, 89.9583, -89.9583, 0, 2160 ) # high and low values are counter-intuitive
      @global_pasture = NumRu::NetCDF.open("netcdf/GCS/Pasture2000_5min.nc")
      @global_pasture_num = @global_pasture.var("farea")[@global_pasture_i,@global_pasture_j,0,0][0]
      @global_pasture.close()
    end

    ## Global cropland
    # This map has an ij coordinate range of (0,0) to (4320, 2160)
    # top left LatLng being (89.9583 ,-179.9583)
    # bottom right LatLng being (-89.9583 ,179.9583)
    # Therefore it sits between:
    # Lat -89.9583 and 89.9583
    # Lon -179.9583 and 179.9583
    # http://localhost:3000/get_biome.json?lng=-113.375&lat=51.70834 # => 1.0
    if ( 89.9583 >= @request_lat && @request_lat >= -89.9583 && 179.9583 >= @request_lng && @request_lng >= -179.9583 )
      @global_cropland_i = remap_range( @request_lng, -179.9583, 179.9583, 0, 4320 )
      @global_cropland_j = remap_range( @request_lat, 89.9583, -89.9583, 0, 2160 ) # high and low values are counter-intuitive
      @global_cropland = NumRu::NetCDF.open("netcdf/GCS/Cropland2000_5min.nc")
      @global_cropland_num = @global_cropland.var("farea")[@global_cropland_i,@global_cropland_j,0,0][0]
      @global_cropland.close()
    end

    ## US SpringWheat
    # This map has an ij coordinate range of (0,0) to (80, 50)
    # top left LatLng being (49.75 ,-105.25)
    # bottom right LatLng being (24.75 ,-65.25)
    # Therefore it sits between:
    # Lat 24.75 and 49.75
    # Lon -105.25 and -65.25
    # http://localhost:3000/get_biome.json?lng=-97.25&lat=44.75 # => 0.0956562
    if ( 49.75 >= @request_lat && @request_lat >= 24.75 && -65.25 >= @request_lng && @request_lng >= -105.25 )
      @us_springwheat_i = remap_range( @request_lng, -105.25, -65.25, 0, 80 )
      @us_springwheat_j = remap_range( @request_lat, 49.75, 24.75, 0, 50 ) # j == 0 where lat is at its lowest value
      @us_springwheat = NumRu::NetCDF.open("netcdf/GCS/Crops/US/SpringWheat/fractioncover/fswh_2.7_us.0.5deg.nc")
      @us_springwheat_num = @us_springwheat.var("fswh")[@us_springwheat_i,@us_springwheat_j,0,0][0]
#      @us_springwheat_num = @us_springwheat.var("fswh")[12,7,0,0][0] #=>> 0.21387700736522675
      @us_springwheat.close()
    end
    
    ## US Soybean
    # This map has an ij coordinate range of (0,0) to (80, 50)
    # top left LatLng being (49.75 ,-105.25)
    # bottom right LatLng being (24.75 ,-65.25)
    # Therefore it sits between:
    # Lat 24.75 and 49.75
    # Lon -105.25 and -65.25
    if ( 49.75 >= @request_lat && @request_lat >= 24.75 && -65.25 >= @request_lng && @request_lng >= -105.25 )
      @us_soybean_i = remap_range( @request_lng, -105.25, -65.25, 0, 80 )
      @us_soybean_j = remap_range( @request_lat, 49.75, 24.75, 0, 50 ) # j == 0 where lat is at its lowest value
      @us_soybean = NumRu::NetCDF.open("netcdf/GCS/Crops/US/Soybean/fractioncover/fsoy_2.7_us.0.5deg.nc")
      @us_soybean_num = @us_soybean.var("fsoy")[@us_soybean_i,@us_soybean_j,0,0][0]
#      @us_soybean_num = @us_soybean.var("fsoy")[22,13,0,0][0] #=>> 0.40256670117378235
      @us_soybean.close()
    end
    
    ## US Corn
    # This map has an ij coordinate range of (0,0) to (80, 50)
    # top left LatLng being (49.75 ,-105.25)
    # bottom right LatLng being (25.25 ,-65.25)
    # Therefore it sits between:
    # Lat 24.75 and 49.75
    # Lon -105.25 and -65.25
    # http://localhost:3000/get_biome?lng=-83.25&lat=44.25 # => 0.18501955270767212
    if ( 49.75 >= @request_lat && @request_lat >= 24.75 && -65.25 >= @request_lng && @request_lng >= -105.25 )
      @us_corn_i = remap_range( @request_lng, -105.25, -65.25, 0, 80 ) 
      @us_corn_j = remap_range( @request_lat, 49.75, 25.25, 0, 50 ) # j == 0 where lat is at its lowest value
      @us_corn = NumRu::NetCDF.open("netcdf/GCS/Crops/US/Corn/fractioncover/fcorn_2.7_us.0.5deg.nc")
      @us_corn_num = @us_corn.var("fcorn")[@us_corn_i,@us_corn_j,0,0][0]
      @us_corn.close()
    end

    ## Vegtype
    # This map has an ij coordinate range of (0,0) to (720, 360)
    # top left LatLng being (89.75, -179.25)
    # top left LatLng being (-89.75, 179.25)
    # Therefore it sits between:
    # Lat -89.75 and 89.75
    # Lon -179.25 and 179.25
    @vegtype_i = remap_range( @request_lng.to_i , -179.25, 179.25, 0, 720 )
    @vegtype_j = remap_range( @request_lat.to_i , 89.75, -89.75, 0, 360 ) # j == 0 where lat is at its lowest value
    @vegtype = NumRu::NetCDF.open("netcdf/vegtype.nc")
    @biome_num = @vegtype.var("vegtype")[@vegtype_i,@vegtype_j,0,0][0]
    @vegtype.close()
 
    # open data/default_ecosystems.json and parse
    # object returned is an array of hashes... Ex:
    # p @ecosystems[0] # will return a Hash
    # p @ecosystems[0]["category"] # => "native"
#    @ecosystems = JSON.parse( File.open( "#{Rails.root}/data/default_ecosystems.json" , "r" ).read )
    
    @name_indexed_ecosystems = JSON.parse( File.open( "#{Rails.root}/data/final_ecosystems.json" , "r" ).read )



    @biome_data = { "native_eco" => {}, "agroecosystem_eco" => {}, "aggrading_eco" => {}, "biofuel_eco" => {} }
    if @biome_num <= 15
      ## Logic for vegtype ecosystems
      case @biome_num
        when 1
          @biome_data["native_eco"]["tropical_peat_forest"] = @name_indexed_ecosystems["tropical peat forest"]
          @biome_data["native_eco"]["tropical_forest"] = @name_indexed_ecosystems["tropical forest"]
        when 2
          @biome_data["native_eco"]["tropical_forest"] = @name_indexed_ecosystems["tropical forest"]
          @biome_data["native_eco"]["tropical_savanna"] = @name_indexed_ecosystems["tropical savanna"]
        when 3, 4, 5
          @biome_data["native_eco"]["temperate_forest"] = @name_indexed_ecosystems["temperate forest"]
        when 6, 7
          @biome_data["native_eco"]["northern_peatland"] = @name_indexed_ecosystems["northern peatland"]
          @biome_data["native_eco"]["boreal_forest"] = @name_indexed_ecosystems["boreal forest"]
        when 8
          if @request_lat >= 50
            @biome_data["native_eco"]["boreal_forest"] = @name_indexed_ecosystems["boreal forest"]
          else 
            @biome_data["native_eco"]["temperate_forest"] = @name_indexed_ecosystems["temperate forest"]
          end
        when 9
          if @request_lat.abs >= 50
            @biome_data["native_eco"]["boreal_forest"] = @name_indexed_ecosystems["boreal forest"]
          elsif @request_lat.abs > 23.26 && @request_lat.abs <= 50
            @biome_data["native_eco"]["temperate_grassland"] = @name_indexed_ecosystems["temperate grassland"]
            @biome_data["native_eco"]["temperate_scrub/woodland"] = @name_indexed_ecosystems["temperate scrub/woodland"]
            @biome_data["native_eco"]["temperate_forest"] = @name_indexed_ecosystems["temperate forest"]
          elsif @request_lat.abs <= 23.26
            @biome_data["native_eco"]["tropical_savanna"] = @name_indexed_ecosystems["tropical savanna"]
          end
        when 10
          @biome_data["native_eco"]["temperate_grassland"] = @name_indexed_ecosystems["temperate grassland"]
        when 11
          if @request_lat <= 5
            @biome_data["native_eco"]["temperate_scrub/woodland"] = @name_indexed_ecosystems["temperate scrub/woodland"]
          end
        when 12, 14
          @biome_data["native_eco"]["desert"] = @name_indexed_ecosystems["desert"]
        when 13, 15
          @biome_data["native_eco"]["tundra"] = @name_indexed_ecosystems["tundra"]
#        when 14
#          @biome_data["native_eco"] = ["desert [No Vegitation]"]
      end
    end

#    @biofuel_names = []
#    @agroecosystem_names = []
#    @native_names = []
#    @aggrading_names = []
    
    



    
    
############ Here we set the threshold levels ############
   
###    NATIVE
#    if @global_biome_temperate_grassland_num != nil && @global_biome_temperate_grassland_num > 0.01
#      @native_names << "temperate grassland"
#    end
#    if @global_biome_peat_num != nil && @global_biome_peat_num > 0.01
#      @native_names << "tropical peat forest"
#    end
#    if @global_biome_marsh_num != nil && @global_biome_marsh_num > 0.01
#      @native_names << "marsh & swamp"
#    end
#    if @global_biome_temperate_forest_num != nil && @global_biome_temperate_forest_num > 0.01
#      @native_names << "temperate forest"
#    end
#    if @global_biome_boreal_num != nil && @global_biome_boreal_num > 0.01
#      @native_names << "boreal forest"
#    end
#    if @global_biome_temperate_scrub_num != nil && @global_biome_temperate_scrub_num > 0.01
#      @native_names << "temperate scrub"
#    end
#    if @global_biome_savanna_num != nil && @global_biome_savanna_num > 0.01
#      @native_names << "savanna"
#    end
#    if @global_biome_desert_num != nil && @global_biome_desert_num > 0.01
#      @native_names << "desert"
#    end
#    if @global_biome_tundra_num != nil && @global_biome_tundra_num > 0.01
#      @native_names << "tundra"
#    end



###   AGROECOSYSTEMS
#tropical pasture
#temperate pasture
#tropical cropland
#temperate cropland
#wetland rice

    if @us_springwheat_num != nil #&& @us_springwheat_num > 0.01
      @biome_data["agroecosystem_eco"]["springwheat"] = @name_indexed_ecosystems["switchgrass"]
    end
      # should include spring wheat in the JSON:
      # http://localhost:3000/get_biome.json?lng=-97.25&lat=44.75
    if @global_pasture_num != nil &&  @global_pasture_num > 0.01
      if @request_lat.abs < 23.26
#        @agroecosystem_eco_names << "tropical pasture"
        @biome_data["agroecosystem_eco"]["tropical_pasture"] = @name_indexed_ecosystems["tropical pasture"]
      else
#        @agroecosystem_eco_names << "temperate pasture"
        @biome_data["agroecosystem_eco"]["temperate_pasture"] = @name_indexed_ecosystems["temperate pasture"]
      end
    end
    if @global_cropland_num != nil && @global_cropland_num > 0.01
      if @request_lat.abs < 23.26
#        @agroecosystem_eco_names << "tropical cropland"
        @biome_data["agroecosystem_eco"]["tropical_cropland"] = @name_indexed_ecosystems["tropical cropland"]
      else
#        @agroecosystem_eco_names << "temperate cropland"
        @biome_data["agroecosystem_eco"]["temperate_cropland"] = @name_indexed_ecosystems["temperate cropland"]
      end
    end


#0 tropical peat forest
#1 tropical forest
#2 northern peatland
#3 marsh & swamp
#4 temperate forest
#5 aggrading temperate non-forest
#6 boreal forest
#7 aggrading tropical non-forest
#8 aggrading boreal forest
#9 switchgrass
#10 temperate grassland
#11 aggrading tropical forest
#12 temperate scrub/woodland
#13 tropical savanna
#14 desert
#15 tundra
#16 tropical pasture
#17 temperate pasture
#18 tropical cropland
#19 temperate cropland
#20 wetland rice
#21 miscanthus
#22 aggrading temperate forest
#23 US corn
#24 US soy


###   BIOFUELS
#switchgrass
#miscanthus
#US corn
#US soy
    if @us_corn_num != nil && @us_corn_num > 0.01
#      @biofuel_names << "corn"
      @biome_data["biofuel_eco"]["US corn"] = @name_indexed_ecosystems["US corn"]
#      @agroecosystem_eco_names << "corn"
      @biome_data["agroecosystem_eco"]["US corn"] = @name_indexed_ecosystems["US corn"]
    end
    if @us_soybean_num != nil && @us_soybean_num > 0.01
#      @biofuel_names << "soybean"
      @biome_data["biofuel_eco"]["soybean"] = @name_indexed_ecosystems["US corn"]
#      @agroecosystem_eco_names << "soybean"
      @biome_data["agroecosystem_eco"]["soybean"] = @name_indexed_ecosystems["US corn"]
    end
    if @braz_sugarcane_num != nil && @braz_sugarcane_num > 0.01
#      @biofuel_names << "sugarcane"
      @biome_data["biofuel_eco"]["sugarcane"] = @name_indexed_ecosystems["sugarcane"]
#      @agroecosystem_eco_names << "sugarcane"
      @biome_data["agroecosystem_eco"]["sugarcane"] = @name_indexed_ecosystems["sugarcane"]
    end
    
    if @braz_saatchi_carbon
#      @native_names << '{{"Anderson-Teixeira and DeLucia (2011)"=>"400","Saatchi and others (2011)"=>"800"},"OM_root"=>"108"}'
    end
    # should include corn in the JSON:
    # http://localhost:3000/get_biome.json?lng=-95.25&lat=44.25
    # should NOT include corn in the JSON:
    # http://localhost:3000/get_biome.json?lng=-71.25&lat=33.75
    
    if @braz_sugarcane_num != nil && @braz_sugarcane_num < 0.01
#      @biofuel_names << "brazil sugarcane"
      @biome_data["biofuel"]["BRAZ sugarcane"] = @name_indexed_ecosystems["sugarcane"]
#      @agroecosystem_eco_names << "brazil sugarcane"
      @biome_data["agroecosystem_eco"]["BRAZ sugarcane"] = @name_indexed_ecosystems["sugarcane"]
    end
    

###   AGGRADING
#aggrading temperate non-forest
#aggrading tropical non-forest
#aggrading boreal forest
#aggrading tropical forest
#aggrading temperate forest
    
    
    
    #@biome_data["biomes"]         = { "name"=> @biofuel_names.join(",") }
#    @biome_data["biofuels"]       = { "name"=> @biofuel_names.join(",") }
#    @biome_data["agroecosystems"] = { "name"=> @agroecosystem_names.join(",") }
#    @biome_data["native"]         = { "name"=> @native_names.join(",") }
#    @biome_data["aggrading"]      = { "name"=> @aggrading_names.join(",") }
    

    respond_to do |format|
      format.json { render json: @biome_data }
    end

  end

  # GET /workflows/new
  # GET /workflows/new.json
  def new
    @workflow = Workflow.new
    # open data/default_ecosystems.json and parse
    # object returned is an array of hashes... Ex:
    # p @ecosystems[0] # will return a Hash
    # p @ecosystems[0]["category"] # => "native"
    @ecosystems = JSON.parse( File.open( "#{Rails.root}/data/default_ecosystems.json" , "r" ).read )
    @name_indexed_ecosystems = JSON.parse( File.open( "#{Rails.root}/data/name_indexed_ecosystems.json" , "r" ).read )
    @ecosystem = @ecosystems[0]

# This is where I'll open the Priors from the DB    
#    @priors = Prior.all
# A prior will have a number of variables
# One of those variables can belong to a given citation

# A PFT would be akin to an ecosystem 
#render :partial => "my_partial", :locals => {:player => Player.new}


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workflow }
    end
  end

  # GET /workflows/1/edit
  def edit
    @workflow = Workflow.find(params[:id])
  end

  # POST /workflows
  # POST /workflows.json
  def create
    @workflow = Workflow.new(params[:workflow])

    respond_to do |format|
      if @workflow.save
        format.html { redirect_to @workflow, notice: 'Workflow was successfully created.' }
        format.json { render json: @workflow, status: :created, location: @workflow }
      else
        format.html { render action: "new" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workflows/1
  # PUT /workflows/1.json
  def update
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      if @workflow.update_attributes(params[:workflow])
        format.html { redirect_to @workflow, notice: 'Workflow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflows/1
  # DELETE /workflows/1.json
  def destroy
    @workflow = Workflow.find(params[:id])
    @workflow.destroy

    respond_to do |format|
      format.html { redirect_to workflows_url }
      format.json { head :no_content }
    end
  end
end
