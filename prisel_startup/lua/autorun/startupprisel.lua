function PrecacheDir( dir )
    local files, directories = file.Find( dir.."*", "GAME" )
    for _, fdir in pairs(directories) do
        if fdir != ".svn" then
            PrecacheDir(dir..fdir.."/")
        end
    end

    for k,v in pairs(files) do
        local fname = string.lower(dir..v)
        local ismodel = -1
        local ismaterial = -1
        local isparticle = -1
        local issound = -1
        ismodel = (string.find(fname,".mdl"))
        ismaterial = (string.find(fname,".vtf") or string.find(fname,".vmt"))
        isparticle = (string.find(fname,".pcf"))
        issound = (string.find(fname,".wav") or string.find(fname,".mp3")  )
        if ismaterial then
            if ismaterial >= 0 then
                local tmpmat = Material(fname,"mips")
            end
        elseif isparticle then
            if isparticle >= 0 then
                PrecacheParticleSystem(fname)
            end
        elseif issound then
            if issound >= 0 then
                util.PrecacheSound(fname)
            end
        else

            if ismodel then
                if ismodel >= 0 then
                    util.PrecacheModel(fname)
                end
            end
        end
    end
end

if SERVER then
    AddCSLuaFile()
end

/*---------------------------------------------------------
StartupPrisel() Function
---------------------------------------------------------*/
function StartupPrisel()
    if SERVER then
        --MsgC( Color( 255, 0, 0 ), "#############################################", "\n" )
        MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Préchargement des véhicules", "\n" )

        --[[TDMCars - Base Pack | 112606459]]
        PrecacheDir("models/tdmcars/")
        -- PrecacheDir("sound/vehicles/tdmcars/airtug/")
        -- PrecacheDir("sound/vehicles/tdmcars/miscsounds/")

        --[[TDMCars - Multi Brand | 225810491]]
        -- PrecacheDir("sound/vehicles/tdmcars/bowler/")
        -- PrecacheDir("sound/vehicles/tdmcars/delorean/")
        -- PrecacheDir("sound/vehicles/tdmcars/morganaero/")
        -- PrecacheDir("sound/vehicles/tdmcars/teslamodels/")
        -- PrecacheDir("sound/vehicles/tdmcars/xbow/")
        -- PrecacheDir("sound/vehicles/tdmcars/zenvo/")

        --[[TDMCars - BMW | 113118541]]
        -- PrecacheDir("sound/vehicles/tdmcars/507/")
        -- PrecacheDir("sound/vehicles/tdmcars/bmw_340i/")
        -- PrecacheDir("sound/vehicles/tdmcars/bmw_isetta/")
        -- PrecacheDir("sound/vehicles/tdmcars/bmw1m/")
        -- PrecacheDir("sound/vehicles/tdmcars/bmwm3gtr/")
        -- PrecacheDir("sound/vehicles/tdmcars/bmwm5e60/")
        -- PrecacheDir("sound/vehicles/tdmcars/m1/")
        -- PrecacheDir("sound/vehicles/tdmcars/m3e92/")
        -- PrecacheDir("sound/vehicles/tdmcars/m5e34/")
        -- PrecacheDir("sound/vehicles/tdmcars/m6/")

        --[[TDMCars - Audi | 113120185]]
        -- PrecacheDir("sound/vehicles/tdmcars/audir8/")
        -- PrecacheDir("sound/vehicles/tdmcars/auditt/")
        -- PrecacheDir("sound/vehicles/tdmcars/r8plus/")
        -- PrecacheDir("sound/vehicles/tdmcars/r8v10/")
        -- PrecacheDir("sound/vehicles/tdmcars/rs4/")
        -- PrecacheDir("sound/vehicles/tdmcars/s5/")

        --[[TDMCars - Ford | 113999373]]
        -- PrecacheDir("sound/vehicles/tdmcars/coupe40/")
        -- PrecacheDir("sound/vehicles/tdmcars/cvpi/")
        -- PrecacheDir("sound/vehicles/tdmcars/f100/")
        -- PrecacheDir("sound/vehicles/tdmcars/f350/")
        -- PrecacheDir("sound/vehicles/tdmcars/focusrs/")
        -- PrecacheDir("sound/vehicles/tdmcars/focussvt/")
        -- PrecacheDir("sound/vehicles/tdmcars/for_focusrs16/")
        -- PrecacheDir("sound/vehicles/tdmcars/for_she_gt500/")
        -- PrecacheDir("sound/vehicles/tdmcars/gt05/")
        -- PrecacheDir("sound/vehicles/tdmcars/mustanggt/")
        -- PrecacheDir("sound/vehicles/tdmcars/raptorsvt/")
        -- PrecacheDir("sound/vehicles/tdmcars/transit/")

        --[[TDMCars - Emergency Vehicles pack | 349281554]]
        PrecacheDir("models/tdmcars/emergency/")
        PrecacheDir("models/tdmcars/trucks/")
        PrecacheDir("models/tdmcars/")
        -- PrecacheDir("sound/tdmsirens/")
        -- PrecacheDir("sound/vcmod/els/danishsiren/")
        -- PrecacheDir("sound/vehicles/tdmcars/charger2012/")
        -- PrecacheDir("sound/vehicles/tdmcars/cvpi/")
        -- PrecacheDir("sound/vehicles/tdmcars/focussvt/")
        -- PrecacheDir("sound/vehicles/tdmcars/for_taurus_13/")
        -- PrecacheDir("sound/vehicles/tdmcars/hsvgts/")
        -- PrecacheDir("sound/vehicles/tdmcars/mere63/")
        -- PrecacheDir("sound/vehicles/tdmcars/mitsuevox/")
        -- PrecacheDir("sound/vehicles/tdmcars/scania/")

        --[[TDMCars - Ferrari | 119148996]]
        -- PrecacheDir("sound/vehicles/tdmcars/512tr/")
        -- PrecacheDir("sound/vehicles/tdmcars/enzo/")
        -- PrecacheDir("sound/vehicles/tdmcars/fer_f430/")
        -- PrecacheDir("sound/vehicles/tdmcars/fer250gto/")
        -- PrecacheDir("sound/vehicles/tdmcars/fer458/")
        -- PrecacheDir("sound/vehicles/tdmcars/ferf12/")
        -- PrecacheDir("sound/vehicles/tdmcars/laferrari/")

        --[[[TDM] Orion VII NG - Bus RATP | 853515746]]
        PrecacheDir("materials/models/tdmcars/bus/")
        -- PrecacheDir("sound/vehicles/tdmcars/bus/")

        --[[Perryn's Ported Vehicles - Shared Textures | 743588549]]
        PrecacheDir("materials/models/perrynsvehicles/shared/")

        --[[PV - 2015 Ford F-550 Ambulance | 951954297]]
        --PrecacheDir("materials/vgui/entities/")
        PrecacheDir("models/perrynsvehicles/ford_f550_ambulance/")
        -- PrecacheDir("sound/vehicles/perryn/ford_f550_ambulance/")

        --[[[Photon] Fourgon GIGN | 776983582]]
        PrecacheDir("materials/models/tdmcars/gtav/riot/")

        --[[GTA V Drivable Vehicles for Garry's Mod | 323285641]]
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/adder/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/bati")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/bmx/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/bus/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/caddy/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/camper/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/gauntlet/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/mesa3/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/nemesis/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/polcruiser/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/policeb/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/polsedan/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/thewrangler/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/tractor/")
        -- PrecacheDir("sound/vehicles/tdmcars/gtav/turismor/")

        --[[Metro's Shared Textures + Props | 769908782]]
        PrecacheDir("models/metrohd/")

        --[[Mercedes-Benz CLA45 AMG | 797587795]]
        -- PrecacheDir("sound/vehicles/metrohd/merc_cla45/")

        --[[CrSk Autos - Peugeot 308 GTi 2011 | 875095111]]
        PrecacheDir("models/crsk_autos/peugeot/")
        -- PrecacheDir("sound/vehicles/lwcars/ren_meganers/")

        --[[[LW] Wheel Props | 413924233]]
        PrecacheDir("models/lonewolfie/wheels/")

        --[[[LW] Shared Textures | 266579667]]
        PrecacheDir("models/lonewolfie/nuberplates/")

        --[[[LW] Ford F350 Ambulance | 343729375]]
        PrecacheDir("models/lonewolfie/")
        --  PrecacheDir("sound/vehicles/lwcars/ford_f350_ambu/")

        --[[TDMCars - Alfa Romeo | 469162158]]
        -- PrecacheDir("sound/vehicles/tdmcars/alf_giulietta/")
        -- PrecacheDir("sound/vehicles/tdmcars/alf_stradale/")

        --[[TDMCars - Mercedes | 131246684]]
        -- PrecacheDir("sound/vehicles/tdmcars/c32/")
        -- PrecacheDir("sound/vehicles/tdmcars/gullwing/")
        -- PrecacheDir("sound/vehicles/tdmcars/mere63/")
        -- PrecacheDir("sound/vehicles/tdmcars/merslr/")
        -- PrecacheDir("sound/vehicles/tdmcars/ml63/")
        -- PrecacheDir("sound/vehicles/tdmcars/slsamg/")

        --[[Ronnie's Cars -- The Patty Wagon -- 250k | 857944866]]
        PrecacheDir("models/ronniecars/spongebob/")

        --[[[LW] Smart ForTwo | 246873784]]
        -- PrecacheDir("sound/vehicles/lwcars/fiat_595/")

        --[[[LW] Ferrari Pack | 603593385]]
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_312/")
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_365_gts/")
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_458/")
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_458_risi/")
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_f40/")
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_ff/")
        -- PrecacheDir("sound/vehicles/lwcars/ferrari_laferrari/")

        --[[[LW] Lamborghini Reventon | 414446616]]
        -- PrecacheDir("sound/vehicles/lwcars/lam_reventon/")

        --[[[LW] Mercedes-Benz G65 AMG | 223767390]]
        -- PrecacheDir("sound/vehicles/lwcars/mer_g65/")

        --[[[LW] W Motors Lykan Hypersport | 446701063]]
        -- PrecacheDir("sound/vehicles/lwcars/lykan_hypersport/")

        --[[[OtherGaming] Sickness Tow Truck | 480526823]]
        -- PrecacheDir("models/sickness/")
        -- PrecacheDir("sound/vehicles/lt/")

        --[[[LW] Jaguar XFR | 348750045]]
        --PrecacheDir("sound/vehicles/lwcars/jag_xfr/")

        --[[Tetra - Peugeot 308 Police Nationale | 1379438474]]
        PrecacheDir("models/azok30_rampe_police_nationale/")
        PrecacheDir("models/crsk_autos/peugeop/")
        PrecacheDir("models/lonewolfie/")
        PrecacheDir("models/tdmcars/emergency/equipment/")
        -- PrecacheDir("sound/siren/")

        --[[[LW] Hummer Pack | 664483053]]
        -- PrecacheDir("sound/vehicles/lwcars/hummer_h1/")

        --  MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Préchargement des armes", "\n")

    
        --[[M9K Assault Rifles | 128089118]]
        -- PrecacheDir("models/items/")
        -- PrecacheDir("models/weapons/")
        -- PrecacheDir("models/wystan/attachments/")
    end
    if CLIENT then
        -- PrecacheDir("sound/weapons/amd65/")
        -- PrecacheDir("sound/weapons/an94/")
        -- PrecacheDir("sound/weapons/auga3/")
        -- PrecacheDir("sound/weapons/aykayforty/")
        -- PrecacheDir("sound/weapons/dmg_m4a1/")
        -- PrecacheDir("sound/weapons/dmg_m16a4/")
        -- PrecacheDir("sound/weapons/dmg_val/")
        -- PrecacheDir("sound/weapons/dmg_vikhr/")
        -- PrecacheDir("sound/weapons/fn_fal/")
        -- PrecacheDir("sound/weapons/fnscarh/")
        -- PrecacheDir("sound/weapons/fokku_tc_ak47/")
        -- PrecacheDir("sound/weapons/fokku_tc_f2000/")
        -- PrecacheDir("sound/weapons/fokku_tc_famas/")
        -- PrecacheDir("sound/weapons/fokku_tc_m14/")
        -- PrecacheDir("sound/weapons/g36/")
        -- PrecacheDir("sound/weapons/hk_g3/")
        -- PrecacheDir("sound/weapons/masadamagpul/")
        -- PrecacheDir("sound/weapons/tavor/")
        -- PrecacheDir("sound/weapons/twinkie_hk416/")
        -- PrecacheDir("sound/weapons/winchester73/")

        --[[M9K Small Arms pack | 128093075]]
        -- PrecacheDir("sound/weapons/627/")
        -- PrecacheDir("sound/weapons/beretta92/")
        -- PrecacheDir("sound/weapons/brightmp5/")
        -- PrecacheDir("sound/weapons/coltpython/")
        -- PrecacheDir("sound/weapons/dmg_colt1911/")
        -- PrecacheDir("sound/weapons/dmg_glock/")
        -- PrecacheDir("sound/weapons/fokku_tc_deagle/")
        -- PrecacheDir("sound/weapons/fokku_tc_usp/")
        -- PrecacheDir("sound/weapons/hb/")
        -- PrecacheDir("sound/weapons/hk_ump45/")
        -- PrecacheDir("sound/weapons/hk45/")
        -- PrecacheDir("sound/weapons/hkmp5sd/")
        -- PrecacheDir("sound/weapons/kac_pdw/")
        -- PrecacheDir("sound/weapons/kriss/")
        -- PrecacheDir("sound/weapons/luger/")
        -- PrecacheDir("sound/weapons/model3/")
        -- PrecacheDir("sound/weapons/model500/")
        -- PrecacheDir("sound/weapons/mp7/")
        -- PrecacheDir("sound/weapons/mp9/")
        -- PrecacheDir("sound/weapons/mp40/")
        -- PrecacheDir("sound/weapons/p19/")
        -- PrecacheDir("sound/weapons/p90_smg/")
        -- PrecacheDir("sound/weapons/pdr/")
        -- PrecacheDir("sound/weapons/r_bull/")
        -- PrecacheDir("sound/weapons/remington/")
        -- PrecacheDir("sound/weapons/satan1/")
        -- PrecacheDir("sound/weapons/sig_p228/")
        -- PrecacheDir("sound/weapons/sten/")
        -- PrecacheDir("sound/weapons/tec9/")
        -- PrecacheDir("sound/weapons/tmg/")
        -- PrecacheDir("sound/weapons/usc/")
        -- PrecacheDir("sound/weapons/uzi/")

        --[[M9K Heavy Weapons | 128091208]]
        -- PrecacheDir("sound/weapons/590/")
        -- PrecacheDir("sound/weapons/1887winchester/")
        -- PrecacheDir("sound/weapons/1897trench/")
        -- PrecacheDir("sound/weapons/7615p/")
        -- PrecacheDir("sound/weapons/aw50/")
        -- PrecacheDir("sound/weapons/benellim3/")
        -- PrecacheDir("sound/weapons/browninga5/")
        -- PrecacheDir("sound/weapons/dbarrel/")
        -- PrecacheDir("sound/weapons/dmg_m24/")
        -- PrecacheDir("sound/weapons/fg42/")
        -- PrecacheDir("sound/weapons/fokku_tc_intrv/")
        -- PrecacheDir("sound/weapons/g2contender/")
        -- PrecacheDir("sound/weapons/hksl8/")
        -- PrecacheDir("sound/weapons/jackhammer/")
        -- PrecacheDir("sound/weapons/jen.ak/")
        -- PrecacheDir("sound/weapons/m37/")
        -- PrecacheDir("sound/weapons/m60/")
        -- PrecacheDir("sound/weapons/m82/")
        -- PrecacheDir("sound/weapons/m98/")
        -- PrecacheDir("sound/weapons/pkm/")
        -- PrecacheDir("sound/weapons/psg1/")
        -- PrecacheDir("sound/weapons/schmung.m249/")
        -- PrecacheDir("sound/weapons/shrike/")
        -- PrecacheDir("sound/weapons/spas_12/")
        -- PrecacheDir("sound/weapons/striker12/")
        -- PrecacheDir("sound/weapons/svd/")
        -- PrecacheDir("sound/weapons/svt40/")
        -- PrecacheDir("sound/weapons/svu/")
        -- PrecacheDir("sound/weapons/tact870/")
        -- PrecacheDir("sound/weapons/usas12/")

        --[[M9K Specialties | 144982052]]
        -- PrecacheDir("sound/gdc/rockets/")
        -- PrecacheDir("sound/impacts/")
        -- PrecacheDir("sound/punchies/")
        -- PrecacheDir("sound/weapons/blades/")
        -- PrecacheDir("sound/weapons/ex41/")
        -- PrecacheDir("sound/weapons/knife/")
        -- PrecacheDir("sound/weapons/m79/")
        -- PrecacheDir("sound/weapons/satellite/")
        -- PrecacheDir("sound/weapons/suicidebomb/")
    

        -- MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Préchargement des accessoires","\n")

        -- --[[GMod Tower: Accessories Pack | 148215278]]
        -- PrecacheDir("models/captainbigbutt/skeyler/accessories/")
        -- PrecacheDir("models/captainbigbutt/skeyler/hats/")
        -- PrecacheDir("models/gmod_tower/")
        -- PrecacheDir("models/lordvipes/billyhatcherhat/")
        -- PrecacheDir("models/lordvipes/blackmage/")
        -- PrecacheDir("models/lordvipes/cuboneskull/")
        -- PrecacheDir("models/lordvipes/daftpunk/")
        -- PrecacheDir("models/lordvipes/generalpepperhat/")
        -- PrecacheDir("models/lordvipes/keatonmask/")
        -- PrecacheDir("models/lordvipes/klonoahat/")
        -- PrecacheDir("models/lordvipes/luigihat/")
        -- PrecacheDir("models/lordvipes/majoramask/")
        -- PrecacheDir("models/lordvipes/makarmask/")
        -- PrecacheDir("models/lordvipes/mariohat/")
        -- PrecacheDir("models/lordvipes/peachcrown/")
        -- PrecacheDir("models/lordvipes/redshat/")
        -- PrecacheDir("models/lordvipes/servbothead/")
        -- PrecacheDir("models/lordvipes/toadhat/")
        -- PrecacheDir("models/lordvipes/viewtifuljoehelmet/")

        -- --[[[GTA V] Giant Accessories Pack | 572310302]]
        -- PrecacheDir("models/modified/")
        -- PrecacheDir("models/sal/")
        -- PrecacheDir("models/sal/acc/")
        -- PrecacheDir("models/sal/acc/fix/")
        -- PrecacheDir("models/sal/halloween/")

        -- MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Préchargement des props RolePlay","\n")

        -- --[[Full RolePlay Props - [Base] | 1325748271]]
        -- PrecacheDir("models/als/speed_bump/")
        -- PrecacheDir("models/azok30_barriere/")
        -- PrecacheDir("models/coldfusion/signs/")
        -- PrecacheDir("models/contron/playstation/")
        -- PrecacheDir("models/de_vegas/")
        -- PrecacheDir("models/env/decor/gents_display/")
        -- PrecacheDir("models/env/decor/plant_decofern/")
        -- PrecacheDir("models/env/decor/tall_plant_b/")
        -- PrecacheDir("models/env/decor/vous_display/")
        -- PrecacheDir("models/env/furniture/bed_andrea/")
        -- PrecacheDir("models/env/furniture/bed_secondclass/")
        -- PrecacheDir("models/env/furniture/bstoolred/")
        -- PrecacheDir("models/env/furniture/cornerbar/")
        -- PrecacheDir("models/env/furniture/decosofa_wood/")
        -- PrecacheDir("models/env/furniture/ensuite1_bath/")
        -- PrecacheDir("models/env/furniture/ensuite1_sink/")
        -- PrecacheDir("models/env/furniture/ensuite1_toilet/")
        -- PrecacheDir("models/env/furniture/largedesk/")
        -- PrecacheDir("models/env/furniture/pool_recliner/")
        -- PrecacheDir("models/env/furniture/shower/")
        -- PrecacheDir("models/env/furniture/showerbase/")
        -- PrecacheDir("models/env/furniture/square_sink/")
        -- PrecacheDir("models/env/furniture/wc_double_cupboard/")
        -- PrecacheDir("models/env/lighting/corridor_ceil_lamp/")
        -- PrecacheDir("models/env/lighting/corridorlamp/")
        -- PrecacheDir("models/env/lighting/dance_spots/")
        -- PrecacheDir("models/env/lighting/jelly_lamp/")
        -- PrecacheDir("models/env/lighting/lamp_trumpet/")
        -- PrecacheDir("models/francis115/")
        -- PrecacheDir("models/gm_forest/")
        -- PrecacheDir("models/gmod_tower/")
        -- PrecacheDir("models/highrise/")
        -- PrecacheDir("models/macbookair/")
        -- PrecacheDir("models/macbookair_sg/")
        -- PrecacheDir("models/macbookair_silver/")
        -- PrecacheDir("models/maxib123/")
        -- PrecacheDir("models/pg_props/pg_hospital/")
        -- PrecacheDir("models/props/de_inferno/")
        -- PrecacheDir("models/props/de_piranesi/")
        -- PrecacheDir("models/props/de_tides/")
        -- PrecacheDir("models/props_computers/")
        -- PrecacheDir("models/props_downtown/")
        -- PrecacheDir("models/props_equipment/")
        -- PrecacheDir("models/props_furniture/")
        -- PrecacheDir("models/props_generic/")
        -- PrecacheDir("models/props_interiors/")
        -- PrecacheDir("models/props_junk/")
        -- PrecacheDir("models/props_office/")
        -- PrecacheDir("models/props_plants/")
        -- PrecacheDir("models/props_street/")
        -- PrecacheDir("models/props_unique/")
        -- PrecacheDir("models/props_unique/hospital/")
        -- PrecacheDir("models/props_unique/spawn_apartment/")
        -- PrecacheDir("models/props_urban/")
        -- PrecacheDir("models/props_vehicles/")
        -- PrecacheDir("models/props_vtmb/")
        -- PrecacheDir("models/props_warehouse/")
        -- PrecacheDir("models/props_waterfront/")
        -- PrecacheDir("models/rusroadsigns/1/")
        -- PrecacheDir("models/rusroadsigns/2/")
        -- PrecacheDir("models/rusroadsigns/3/")
        -- PrecacheDir("models/rusroadsigns/4/")
        -- PrecacheDir("models/rusroadsigns/5/")
        -- PrecacheDir("models/rusroadsigns/6/")
        -- PrecacheDir("models/rusroadsigns/7/")
        -- PrecacheDir("models/rusroadsigns/8/")
        -- PrecacheDir("models/rusroadsigns/led/")
        -- PrecacheDir("models/rusroadsigns/planned/")
        -- PrecacheDir("models/sal/office/")
        -- PrecacheDir("models/sal/trash/")
        -- PrecacheDir("models/sal/vending/")
        -- PrecacheDir("models/scenery/furniture/coffeetable1/")
        -- PrecacheDir("models/scenery/structural/vesuvius/")
        -- PrecacheDir("models/sickness/")
        -- PrecacheDir("models/sonysmarttv42inch/")
        -- PrecacheDir("models/statua/")
        -- PrecacheDir("models/statua/shell/")
        -- PrecacheDir("models/testmodels/")
        -- PrecacheDir("models/trees/")
        -- PrecacheDir("models/u4lab/")
        -- PrecacheDir("models/unconid/")
        -- PrecacheDir("models/unconid/atari/")
        -- PrecacheDir("models/unconid/dreamcast/")
        -- PrecacheDir("models/unconid/gameboy/")
        -- PrecacheDir("models/unconid/n64/")
        -- PrecacheDir("models/unconid/nintendo_3ds/")
        -- PrecacheDir("models/unconid/nintendo_switch_new")
        -- PrecacheDir("models/unconid/pc_models/monitors/")
        -- PrecacheDir("models/unconid/playstation_1/")
        -- PrecacheDir("models/unconid/playstation_2/")
        -- PrecacheDir("models/unconid/playstation_3/")
        -- PrecacheDir("models/unconid/playstation_4/")
        -- PrecacheDir("models/unconid/playstation_portable/")
        -- PrecacheDir("models/unconid/ps4/")
        -- PrecacheDir("models/unconid/sega_saturn/")
        -- PrecacheDir("models/unconid/snes/")
        -- PrecacheDir("models/unconid/wii")
        -- PrecacheDir("models/unconid/wii_u/")
        -- PrecacheDir("models/unconid/xbox_360/")
        -- PrecacheDir("models/unconid/xbox_one/")
        -- PrecacheDir("models/unconid/xbox_one_x/")
        -- PrecacheDir("models/wilderness/")

        -- MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Préchargement des PlayerModels","\n")

        -- PrecacheDir("models/player/zelpa/")
        -- PrecacheDir("models/player/")
        -- PrecacheDir("models/fearless/")
        -- PrecacheDir("models/player/Group03m/")
        -- PrecacheDir("models/player/hostage/")
        -- PrecacheDir("models/player/portal/")
        -- PrecacheDir("models/player/kuma/")
        -- PrecacheDir("models/player/bloodz/")
        -- PrecacheDir("models/player/cripz/")
        -- PrecacheDir("models/SD/Players/")
        -- PrecacheDir("models/player/kerry/")
        -- PrecacheDir("models/player/police_agent/")
        -- PrecacheDir("models/player/RAID/")

        -- MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Préchargement des entitées","\n")

        -- PrecacheDir("models/props_c17/")
        -- PrecacheDir("models/props/cs_office/")
        -- PrecacheDir("models/props_junk/")
        -- PrecacheDir("models/props_interiors/")
        -- PrecacheDir("models/props_wasteland/")
        -- PrecacheDir("models/drug_mod/")
        -- PrecacheDir("models/katharsmodels/syringe_out/")
        -- PrecacheDir("models/smile/")
        -- PrecacheDir("models/katharsmodels/contraband/zak_wiet/")
        -- PrecacheDir("models/katharsmodels/contraband/metasync/")
        -- PrecacheDir("models/oldbill/")
        -- PrecacheDir("models/arc/")
        -- PrecacheDir("models/combine_vests/")
        -- PrecacheDir("models/vcmod/")
        -- PrecacheDir("models/props_lab/")
        -- PrecacheDir("models/dav0r/tnt/")
        -- PrecacheDir("models/winningrook/gtav/weed/weed_bud01/")
        -- PrecacheDir("models/props/RS/weed/")
        -- PrecacheDir("models/winningrook/gtav/weed/weed_bucket01/")
        -- PrecacheDir("models/sterling/")

        -- Optimize FPS client
        
            -- MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,255,0)," Optimisation des FPS côté client","\n")

            -- RunConsoleCommand("gmod_mcore_test", "1")
            -- RunConsoleCommand("mat_queue_mode", "-1")
            -- RunConsoleCommand("cl_threaded_bone_setup", "1")
            -- RunConsoleCommand("cl_threaded_client_leaf_system", "1")
            -- RunConsoleCommand("r_queued_ropes", "1")
            -- RunConsoleCommand("r_threaded_renderables", "1")
            -- RunConsoleCommand("r_threaded_particles", "1")
            -- RunConsoleCommand("r_threaded_client_shadow_manager", "1")
            -- RunConsoleCommand("studio_queue_mode", "1")
            -- RunConsoleCommand("r_fastzreject", "-1")
            -- RunConsoleCommand("cl_playerspraydisable", "1")
            -- RunConsoleCommand("r_spray_lifetime", "0")
            -- RunConsoleCommand("cl_phys_props_enable", "0")
            -- RunConsoleCommand("cl_phys_props_max", "0")
            -- RunConsoleCommand("props_break_max_pieces", "0")
            -- RunConsoleCommand("r_propsmaxdist", "1")
            -- RunConsoleCommand("violence_agibs", "0")
            -- RunConsoleCommand("violence_hgibs", "0")
            -- RunConsoleCommand("r_drawmodeldecals", "0")
            -- RunConsoleCommand("mat_specular", "0")
            -- RunConsoleCommand("mat_bumpmap", "1")

            -- Verify CSS on client 
        
            if IsMounted("cstrike") and util.IsValidModel("models/props/cs_assault/money.mdl") then 
                return
            else
                MsgC(Color(0,255,0),"[Prisel.fr]",Color(255,0,0)," CSS non détecté.",Color(255,128,0)," Pour l'installation de celui-ci, suivez ce lien :",Color(0,128,255)," https://www.prisel.fr/forum/index.php?threads/probleme-de-textures-css-textures.5069/","\n")
            end
        end
        --MsgC( Color( 255, 0, 0 ), "#############################################", "\n" )
end

/*---------------------------------------------------------
Run the above code when the player first spawns.
---------------------------------------------------------*/
StartupPrisel()