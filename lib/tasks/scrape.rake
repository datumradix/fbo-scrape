task :greet do
	puts "hello world"
end

task :clean => :environment do  #heroku scheduler run this every 2 days?
    @opportunities = Opportunity.all 
    @opportunities.each do |opportunity| 
    	if (Date.today - opportunity.post_date).to_i > 8
    		unless opportunity.management_evaluation && opportunity.management_evaluation.length > 1 && opportunity.management_evaluation != "Reject Opportunity"
    			opportunity.destroy  #cleaner than delete
    			puts "deleted record"
    		end
    	end
    end
end

task :scrape => :environment do  #heroku scheduler run every hour with a size of 500?
    require 'open-uri'
    todays_date = Date.today.strftime('%m/%d/%Y')
    $been_there = false #will change to true when scraper detects duplicate opportunity. when true, script terminates
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
					"96 -- Ores, minerals & their primary products", "E -- Purchase of structures & facilities", "F -- Natural resources & conservation services",
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
					bad_set_asides.each do |set_aside|
					 	unless opportunity_row[2].include?(set_aside)
					 		opportunity_classification[0] = "Good Classification"
					 		opportunity_row << opportunity_row[0].split(c_code)[0]
					 		opportunity_row << c_code
					 	end
					end
				end
			end
			procurement_type.each do |p_type|
				if opportunity_row[2].include?(p_type)
					bad_set_asides.each do |bad_set_aside|
						unless opportunity_row[2].include?(bad_set_aside)
							opportunity_classification[1] = "Good Procurement"
						end
					end
				end
			end
		end
		puts "#{opportunity_row[5]} is a #{opportunity_classification[0]} and #{opportunity_classification[1]}"
		#puts ""
	end

	def opportunity_database_evaluation(opportunity_row, response_due, opportunity_classification, full_link)
	   	if opportunity_classification[0] == "Good Classification" && opportunity_classification[1] == "Good Procurement"
		   	if Opportunity.where(opportunity: opportunity_row[4]).none? #|| opportunity_row[3].to_date != Date.today
		   		puts "Adding new record to Opportunity table"
		 		Opportunity.create(opportunity: opportunity_row[4],
					               class_code: opportunity_row[5],
					               agency: opportunity_row[1],
			        	           opp_type: opportunity_row[2],
			            	       post_date: opportunity_row[3],
				            	   response_date: response_due,
					               link: full_link)
			else
				$been_there = true
				raise "hey, stop the script! been_there value is #{$been_there}"
			end
		end
	end

	base_link = "https://www.fbo.gov/index"

	doc.css('tr').each do |table_row|
		puts "been_there value is #{$been_there}"
		if $been_there == false #checks for new opportunity 
			opportunity_row = []
			opportunity_link = "none"
			response_due = "none"
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
		    		#opportunity_hash[hash_counter][:response_due] = response_due
				end
				opportunity_row << table_division.text 
				#opportunity_row[0] merged opportunity title and classification code
				#opportunity_row[1] agency
				#opportunity_row[2] state & setaside code
				#opportunity_row[3] submit date
				#opportunity_link   link to the opportunity
				#response_due       the day the response is expected
				#opportunity_checker output opportunity_row[4] = opportunity title
				#opportunity_checker output opportunity_row[5] = classification code
				#full_link   url to opportunity
			end
			
			opportunity_checker(opportunity_row, response_due, opportunity_classification, 
				good_class_codes, procurement_type, bad_set_asides)

			opportunity_database_evaluation(opportunity_row, response_due, opportunity_classification, 
				full_link)
		else
			"been there, stop the sceipt"
		end
	end
end




