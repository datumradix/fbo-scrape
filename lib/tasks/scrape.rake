task :greet do
	puts "hello world"
end

task :clean => :environment do  #heroku scheduler run this every 1 days
    @opportunities = Opportunity.all 
    @opportunities.each do |opportunity| 
    	if opportunity.management_evaluation == "Not Evaluated" && (Date.today - opportunity.post_date).to_i > 8
    		opportunity.destroy
    	end
    	if opportunity.management_evaluation == "Watchlist" && (Date.today - opportunity.post_date).to_i > 365
    		opportunity.destroy
    	end
    	if opportunity.management_evaluation == "Reject" && (Date.today - opportunity.post_date).to_i > 30
    		opportunity.destroy
    	end
    	#this clean task can be removed soon. Opportunities never are imported with nil.
    	if (Date.today - opportunity.post_date).to_i > 8
    		unless opportunity.management_evaluation && opportunity.management_evaluation.length > 1 
    			opportunity.destroy  
    			puts "destroy record"
    		end
    	end
    end
end

task :setup_sandbox_team => :environment do 
	Team.delete_all 
	Team.create(id: 1, name: "Sandbox Team", description: "A place to get started.")
	SelectionCriterium.delete_all 
	SelectionCriterium.create(id: 1, team_id: 1, set_aside_radio_id: 1)
end

task :setup_roles => :environment do 
	Role.delete_all
	roles = ["Administrator", "Team Lead", "Evaluator"]
	rid=1
	roles.each do |role| 
		Role.create(title: role, id: rid)
		rid += 1
	end
end

task :setup_evaluation_codes => :environment do 
	EvaluationCode.delete_all
	evaluation_codes = ["Not Evaluated", "Watchlist", "Reject"]
	rid=1
	evaluation_codes.each do |evaluation_code| 
		EvaluationCode.create(name: evaluation_code, id: rid)
		rid += 1
	end
end

task :setup_set_aside_radio => :environment do 
	SetAsideRadio.delete_all
	radio_values = ["Ignore all set asides", "Ignore opportunities with selected set asides", "Include only opportunities with selected set asides"]
	rid=1
	radio_values.each do |radio_value|
		SetAsideRadio.create(id: rid, name: radio_value)
		rid += 1
	end
end


task :setup_codes => :environment do 
	classification_codes = ["10 -- Weapons", "11 -- Nuclear ordnance", "12 -- Fire control equipment", "13 -- Ammunition & explosives", 
		      "14 -- Guided missiles", "15 -- Aircraft & airframe structural components", "16 -- Aircraft components & accessories", 
	        "17 -- Aircraft launching, landing & ground handling equipment", "18 -- Space vehicles", 
					"19 -- Ships, small craft, pontoons & floating docks", "20 -- Ship and marine equipment", "22 -- Railway equipment", 
					"23 -- Ground effects vehicles, motor vehicles, trailers & cycles", "24 -- Tractors", "25 -- Vehicular equipment components", 
					"26 -- Tires and tubes", "28 -- Engines, turbines & components", "29 -- Engine accessories", 
					"30 -- Mechanical power transmission equipment", "31 -- Bearings", "32 -- Woodworking machinery and equipment", 
					"34 -- Metalworking machinery", "35 -- Service and trade equipment", "36 -- Special industry machinery", 
					"37 -- Agricultural machinery & equipment", "38 -- Construction, mining, excavating & highway maintenance equipment", 
					"39 -- Materials handling equipment", "40 -- Rope, cable, chain & fittings", 
					"41 -- Refrigeration, air-conditioning & air circulating equipment", "42 -- Fire fighting, rescue & safety equipment", 
					"43 -- Pumps &  compressors", "44 -- Furnace, steam plant & drying equipment; & nuclear reactors", 
					"45 -- Plumbing, heating, & sanitation equipment", "46 -- Water purification & sewage treatment equipment",
					"47 -- Pipe, tubing, hose & fittings", "48 -- Valves", "49 -- Maintenance & repair shop equipment", 
					"51 -- Hand tools", "52 -- Measuring tools", "53 -- Hardware & abrasives", "54 -- Prefabricated structures and scaffolding",
					"55 -- Lumber, millwork, plywood & veneer", "56 -- Construction & building materials", "58 -- Communication, detection, & coherent radiation equipment", 
					"59 -- Electrical and electronic equipment components", "60 -- Fiber optics materials, components, assemblies & accessories",
					"61 -- Electric wire &  power &  distribution equipment", "62 -- Lighting fixtures & lamps", "63 -- Alarm, signal & security detection equipment",
					"65 -- Medical, dental & veterinary equipment &  supplies", "66 -- Instruments & laboratory equipment", "67 -- Photographic equipment",
					"68 -- Chemicals & chemical products", "69 -- Training aids & devices", "70 -- General purpose information technology equipment", 
					"71 -- Furniture", "72 -- Household & commercial furnishings & appliances", "73 -- Food preparation and serving equipment",
					"74 -- Office machines, text processing systems & visible record equipment", "75 -- Office supplies and devices", "76 -- Books, maps & other publications",
					"77 -- Musical instruments, phonographs & home-type radios", "78 -- Recreational & athletic equipment", "79 -- Cleaning equipment and supplies",
					"80 -- Brushes, paints, sealers & adhesives", "81 -- Containers, packaging, & packing supplies", "83 -- Textiles, leather, furs, apparel & shoe findings, tents & flags",
					"84 -- Clothing, individual equipment & insignia", "85 -- Toiletries", "87 -- Agricultural supplies", "88 -- Live animals", "89 -- Subsistence",
					"91 -- Fuels, lubricants, oils & waxes", "93 -- Nonmetallic fabricated materials", "94 -- Nonmetallic crude materials", "95 -- Metal bars, sheets & shapes",
					"96 -- Ores, minerals & their primary products", "E -- Purchase of structures & facilities", "F -- Natural resources & conservation services",
					"G -- Social services", "H -- Quality control, testing & inspection services", "J -- Maintenance, repair & rebuilding of equipment", 
					"K -- Modification of equipment", "L -- Technical representative services", "M -- Operation of Government-owned facilities", "N -- Installation of equipment", "P -- Salvage services", 
					"Q -- Medical services", "R -- Professional, administrative, and management support services", "S -- Utilities and housekeeping services", 
					"T -- Photographic, mapping, printing, & publication services", "U -- Education & training services", "V -- Transportation, travel, & relocation services",
					"W -- Lease or Rental of equipment", "X -- Lease or rental of facilities", "Y -- Construction of structures and facilities",
					"Z -- Maintenance, repair, and alteration of real property" 
					 ]

	set_asides = ["Competitive 8(a)", "Emerging Small Business", "HUBZone", "Woman Owned Small Business",
	              "Partial HBCU / MI", "Partial Small Business", "Service-Disabled Veteran-Owned Small Business", 
	              "Economically Disadvantaged Woman Owned Small Business", "Total HBCU / MI", "Total Small Business", 
	              "Veteran-Owned Small Business", "Very Small Business"]

	procurement_types = ["Presolicitation", "Modification/Amendment/Cancel", "Foreign Government Standard", 
											 "Intent to Bundle Requirements (DoD-Funded)", "Combined Synopsis/Solicitation", "Sale of Surplus Property", 
											 "Fair Opportunity / Limited Sources Justification", "Sources Sought", "Special Notice",
											 "Justification and Approval (J&A)", "Award"]

	ClassificationCode.delete_all
	SetAside.delete_all
	ProcurementType.delete_all
	cc_id = 1
	sa_id = 1
	pt_id = 1
	
	classification_codes.each do |cc|
	 ClassificationCode.create(id: cc_id, name: cc)
	 cc_id += 1
	end

	set_asides.each do |sa| 
		SetAside.create(id: sa_id, name: sa)
		sa_id += 1
	end

	procurement_types.each do |pt| 
		ProcurementType.create(id: pt_id, name: pt)
		pt_id += 1
	end
end

task :teams_evaluate_opportunities => :environment do |team_evaluate_opportunity|

	teams =Team.all 
	teams.each do |team|
		team.opportunities = []
		team_criterium_classification_codes = []
		team_procurement_types = []
		team_criterium_set_asides = []

		team.selection_criterium.classification_codes.each do |cc|
			team_criterium_classification_codes << cc.name 
		end

		team.selection_criterium.set_asides.each do |sa|
			team_criterium_set_asides << sa.name 
		end

		team.selection_criterium.procurement_types.each do |pt|
			team_procurement_types << pt.name 
		end

		opportunities = Opportunity.all 
		opportunities.each do |opportunity|
			team_class_code = false 
			team_procurement_type = false
			team_set_aside = false

			if team_criterium_classification_codes.include?(opportunity.class_code)
				team_class_code = true 
			end

			team_procurement_types.each do |criterium_type|
				if /#{criterium_type}/.match opportunity.opp_type 
					team_procurement_type = true
				end
			end

			case team.selection_criterium.set_aside_radio_id 
			when 1
				team_set_aside = true 
			when 2
				team_set_aside = true
				team_criterium_set_asides.each do |set_aside|
					if /#{set_aside}/.match opportunity.opp_type
						team_set_aside = false
					end
				end
			when 3
				team_criterium_set_asides.each do |set_aside|
					if /#{set_aside}/.match opportunity.opp_type
						team_set_aside = true 
					end
				end
			end

			if team_class_code && team_procurement_type &&  team_set_aside  
		  	team.opportunities << opportunity
			end
		end
	end
end




task :scrape => :environment do  #heroku scheduler run every hour with list of 400
    require 'open-uri'
    todays_date = Date.today.strftime('%m/%d/%Y')
    doc = Nokogiri::HTML(open("https://www.fbo.gov/index?s=opportunity&mode=list&tab=list&tabmode=list&pp=400"))
    puts doc.css("title")[0].text 

	bad_class_codes =  ["10 -- Weapons", "11 -- Nuclear ordnance", "13 -- Ammunition & explosives", "14 -- Guided missiles", "15 -- Aircraft & airframe structural components",
	                "17 -- Aircraft launching, landing & ground handling equipment", "18 -- Space vehicles", 
					"19 -- Ships, small craft, pontoons & floating docks", "20 -- Ship and marine equipment", "22 -- Railway equipment", 
					"23 -- Ground effects vehicles, motor vehicles, trailers & cycles", "24 -- Tractors", "25 -- Vehicular equipment components", 
					"26 -- Tires and tubes", "28 -- Engines, turbines & components", "29 -- Engine accessories", 
					"30 -- Mechanical power transmission equipment", "31 -- Bearings", "32 -- Woodworking machinery and equipment", 
					"34 -- Metalworking machinery", "35 -- Service and trade equipment", "36 -- Special industry machinery", 
					"37 -- Agricultural machinery & equipment", "38 -- Construction, mining, excavating & highway maintenance equipment", 
					"39 -- Materials handling equipment", "40 -- Rope, cable, chain & fittings", 
					"41 -- Refrigeration, air-conditioning & air circulating equipment", "42 -- Fire fighting, rescue & safety equipment", 
					"43 -- Pumps &  compressors", "44 -- Furnace, steam plant & drying equipment; & nuclear reactors", 
					"45 -- Plumbing, heating, & sanitation equipment", "46 -- Water purification & sewage treatment equipment",
					"47 -- Pipe, tubing, hose & fittings", "48 -- Valves", "49 -- Maintenance & repair shop equipment", 
					"51 -- Hand tools", "52 -- Measuring tools", "53 -- Hardware & abrasives", "54 -- Prefabricated structures and scaffolding",
					"55 -- Lumber, millwork, plywood & veneer", "56 -- Construction & building materials", 
					"61 -- Electric wire &  power &  distribution equipment", "62 -- Lighting fixtures & lamps", "63 -- Alarm, signal & security detection equipment",
					"65 -- Medical, dental & veterinary equipment &  supplies", "66 -- Instruments & laboratory equipment", "67 -- Photographic equipment",
					"68 -- Chemicals & chemical products", "71 -- Furniture", "72 -- Household & commercial furnishings & appliances", "73 -- Food preparation and serving equipment",
					"74 -- Office machines, text processing systems & visible record equipment", "75 -- Office supplies and devices", "76 -- Books, maps & other publications",
					"77 -- Musical instruments, phonographs & home-type radios", "78 -- Recreational & athletic equipment", "79 -- Cleaning equipment and supplies",
					"80 -- Brushes, paints, sealers & adhesives", "81 -- Containers, packaging, & packing supplies", "83 -- Textiles, leather, furs, apparel & shoe findings, tents & flags",
					"84 -- Clothing, individual equipment & insignia", "85 -- Toiletries", "87 -- Agricultural supplies", "88 -- Live animals", "89 -- Subsistence",
					"91 -- Fuels, lubricants, oils & waxes", "93 -- Nonmetallic fabricated materials", "94 -- Nonmetallic crude materials", "95 -- Metal bars, sheets & shapes",
					"96 -- Ores, minerals & their primary products", "99 -- Miscellaneous", 
					"A -- Research & Development", "B -- Special studies and analysis - not R&D", "C -- Architect and engineering services", 
					"D -- Information technology services, including telecommunications services", "E -- Purchase of structures & facilities", 
					"F -- Natural resources & conservation services",
					"G -- Social services", "M -- Operation of Government-owned facilities", "N -- Installation of equipment", "P -- Salvage services", "Q -- Medical services", "S -- Utilities and housekeeping services", 
					"T -- Photographic, mapping, printing, & publication services", "V -- Transportation, travel, & relocation services",
					"W -- Lease or Rental of equipment", "X -- Lease or rental of facilities", "Y -- Construction of structures and facilities",
					"Z -- Maintenance, repair, and alteration of real property" 
					 ]

	good_class_codes = ["12 -- Fire control equipment", 
					"16 -- Aircraft components & accessories", "58 -- Communication, detection, & coherent radiation equipment", 
					"59 -- Electrical and electronic equipment components", "60 -- Fiber optics materials, components, assemblies & accessories",
					"69 -- Training aids & devices", "70 -- General purpose information technology equipment", "99 -- Miscellaneous", 
					"A -- Research & Development", "B -- Special studies and analysis - not R&D", "C -- Architect and engineering services", 
					"D -- Information technology services, including telecommunications services", "H -- Quality control, testing & inspection services",
					"J -- Maintenance, repair & rebuilding of equipment", "K -- Modification of equipment", "L -- Technical representative services", 
					"R -- Professional, administrative, and management support services",
					"U -- Education & training services"
				    ]
	bad_set_asides = ["Total Small Business", "Award", "Justification and Approval", "J&A", "Fair Opportunity / Limited Sources Justification", 
	                 "Cancelled", "Competitive 8(a)", "Emerging Small Business", "HUBZone", "Woman Owned Small Business",
	                "Partial HBCU / MI", "Partial Small Business", "Service-Disabled Veteran-Owned Small Business", 
	                "Economically Disadvantaged Woman Owned Small Business", "Total HBCU / MI", "Veteran-Owned Small Business",
	                "Very Small Business"]

    procurement_type = ["Presolicitation", "Combined Synopsis/Solicitation", "Sources Sought"]


	def opportunity_checker(opportunity_row, response_due, opportunity_classification, 
		good_class_codes, procurement_type, bad_set_asides)
	    unless response_due == "none"
		  	good_class_codes.each do |c_code|
				if opportunity_row[0] && opportunity_row[0].include?(c_code)
			 		opportunity_classification[0] = "Good Classification"
			 		opportunity_row << opportunity_row[0].split(c_code)[0]
			 		opportunity_row << c_code
				end
			end
			procurement_type.each do |p_type|
				if opportunity_row[2].include?(p_type)
					opportunity_classification[1] = "Good Procurement"
				end
			end
			bad_set_asides.each do |bad_set_aside|
				if opportunity_row[2].include?(bad_set_aside)
					opportunity_classification[1] = "Bad Procurement"
				end
			end
		end
		#puts "#{opportunity_row[5]} is a #{opportunity_classification[0]} and #{opportunity_classification[1]}"
		#puts ""
	end

	def opportunity_database_evaluation(opportunity_row, response_due, opportunity_description, opportunity_classification, full_link)
	   	if opportunity_classification[0] == "Good Classification" && opportunity_classification[1] == "Good Procurement"
	   		puts "THIS IS GOOD #{opportunity_row[2]}"
	   		puts "THE GOOD CLASSIFICATION IS #{opportunity_classification[1]}"
		   	if Opportunity.where(opportunity: opportunity_row[4]).none? #|| opportunity_row[3].to_date != Date.today
		   		puts "Adding new record to Opportunity table"
		 			Opportunity.create(opportunity: opportunity_row[4],
					               class_code: opportunity_row[5],
					               agency: opportunity_row[1],
			        	         opp_type: opportunity_row[2],
			            	     post_date: opportunity_row[3],
				            	   response_date: response_due,
				            	   opportunity_description: opportunity_description,
					               link: full_link,
					               management_evaluation: "Not Evaluated")
			else
				puts opportunity_row[4]
				raise "Killing the script! We have been here before!. See Opportunity "
			end
		end
	end

	base_link = "https://www.fbo.gov/index"

	doc.css('tr').each do |table_row|
		opportunity_row = []
		opportunity_link = "none"
		response_due = "none"
		opportunity_description = "none"
		full_link = "none"
		opportunity_classification = ["Bad Classification", "Bad Procurement"]

		table_row.css('td').each do |table_division|
			
			links = table_division.css("a")
			if links.length == 1
				#puts "Checking opportunity #{hash_counter}"
				opportunity_link = links[0]["href"] 
				full_link = "#{base_link}#{opportunity_link}"
				#opportunity_hash[hash_counter][:link] = full_link
				#puts full_link
				link_doc = Nokogiri::HTML(open(full_link))	
	    		response_due = link_doc.css("div[id = 'dnf_class_values_procurement_notice__response_deadline__widget']").text
	    		opportunity_description = link_doc.css("div[id = 'dnf_class_values_procurement_notice__description__widget']").text
	    		#opportunity_hash[hash_counter][:response_due] = response_due
			end
			opportunity_row << table_division.text 
			#opportunity_row[0] merged opportunity title and classification code
			#opportunity_row[1] agency
			#opportunity_row[2] state & setaside code
			#opportunity_row[3] submit date
			#opportunity_link   link to the opportunity
			#response_due       the day the response is expected
			#opportunity_description
			#opportunity_checker output opportunity_row[4] = opportunity title
			#opportunity_checker output opportunity_row[5] = classification code
			#full_link   url to opportunity
		end
		
		opportunity_checker(opportunity_row, response_due, opportunity_classification, 
			good_class_codes, procurement_type, bad_set_asides)

		opportunity_database_evaluation(opportunity_row, response_due, opportunity_description, opportunity_classification, 
			full_link)
	end
end




