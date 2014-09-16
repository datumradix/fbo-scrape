task :reset_development do   #will still need to either rake db:seed or rake scrape and rake teams_evaluate_opportunities
	reset_files = ["db:drop", "db:migrate", "build_all"] 
	reset_files.each do |t|
	Rake::Task[t].invoke
	end
end

task :reset_production do 
	reset_files = ["db:migrate", "build_all"] 
	reset_files.each do |t|
	Rake::Task[t].invoke
	end
end

task :build_all do
	setup_files = ["setup_companies", "setup_sandbox_team", "setup_roles", "setup_evaluation_codes", "setup_set_aside_radio", "setup_codes", "setup_users"]
	setup_files.each do |t|
		Rake::Task[t].invoke
	end
end

task :clean => :environment do  #heroku scheduler run this every 1 days
  @opportunities = Opportunity.all 
  @opportunities.each do |opportunity| 
  	if (Date.today - opportunity.post_date).to_i > 3 #over a 4 old is a purge opportunity
  		purge_opportunity = true
  		if Evaluation.where(opportunity_id: opportunity.id).first
  			evaluations = Evaluation.where(opportunity_id: opportunity.id)
  			evaluations.each do |evaluation|
  				if evaluation.evaluation_code_id == 1 #purge only if team opportunity is not evaluated
  					evaluation.destroy
  				end
  			end
  		else  #the opportunity is not part of any team's evaluation criteria
  			opportunity.destroy
  		end
  	end
  end
end

task :setup_companies => :environment do 
	Company.delete_all
	Company.create(id: 1, name: "Sandbox")
	Company.create(id: 2, name: "NGC")
end

task :setup_sandbox_team => :environment do 
	Team.delete_all 
	SelectionCriterium.delete_all 
	Team.create(id: 1, company_id: 1, name: "Sandbox Team", description: "A place to get started. Please click around and get to know the service.  You cannot break anything.")
	SelectionCriterium.create(id: 1, team_id: 1, set_aside_radio_id: 1)
	Team.create(id: 2, company_id: 2, name: "Indy", description: "We look for complex jobs that no one else can do.")
	SelectionCriterium.create(id: 2, team_id: 2, set_aside_radio_id: 1)
end

task :setup_roles => :environment do 
	Role.delete_all
	roles = ["Administrator", "Team Lead", "Evaluator", "Capture Lead"]
	rid=1
	roles.each do |role| 
		Role.create(title: role, id: rid)
		rid += 1
	end
	role = Role.find(3)
	role.description ="The Capture Lead oversees opportunities for all teams under their area of responsibility. Teams under the Capture Lead may be organized by geography, area of expertise, or business area.  It is the responsibility of the Capture Lead to organize Teams and provide feedback on a team's charter, selection criteria, and opportunity evaluations."
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
	radio_values = ["Include all set asides", "Ignore selected", "Include selected"]
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
					"96 -- Ores, minerals & their primary products", "99 -- Miscellaneous", "A -- Research & Development", "B -- Special studies and analysis - not R&D",
					"C -- Architect and engineering services", "D -- Information technology services, including telecommunications services", 
					"E -- Purchase of structures & facilities", "F -- Natural resources & conservation services",
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

task :setup_users => :environment do 
	User.delete_all
	User.create(id: 1, username: "admin", email: "matthew.r.newell@gmail.com", team_id: 1, role_id: 1, password: "test", password_confirmation: "test")
	User.create(id: 2, username: "alpha", email: "alpha@test.com", team_id: 1, role_id: 2, password: "test", password_confirmation: "test")
	User.create(id: 3, username: "beta", email: "beta@test.com", team_id: 1, role_id: 3, password: "test", password_confirmation: "test")
	User.create(id: 4, username: "scott", email: "scott@test.com", team_id: 2, role_id: 2, password: "test", password_confirmation: "test")
end

task :teams_evaluate_opportunities => :environment do |team_evaluate_opportunity|
	teams =Team.all 
	teams.each do |team|
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
			unless team.opportunities.where(id: opportunity.id).first
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
			  	
			  	evaluation = team.evaluations.last 
			  	evaluation.evaluation_code_id = 1
			  	evaluation.save
				end
			end
		end
	end
end

task :scrape => :environment do  #heroku scheduler run every hour with list of 400
  require 'open-uri'
  todays_date = Date.today.strftime('%m/%d/%Y')
  doc = Nokogiri::HTML(open("https://www.fbo.gov/index?s=opportunity&mode=list&tab=list&tabmode=list&pp=400"))
  puts doc.css("title")[0].text 

	base_link = "https://www.fbo.gov/index"

	doc.css('table.list').each do |table|
 		table.search('tr').each do |table_row|
		#doc.css('tr').each do |table_row|

			opportunity_row = []
			opportunity_link = "none"
			response_due = "none"
			opportunity_description = "none"
			full_link = "none"

			table_row.css('td').each do |table_division|
				links = table_division.css("a")
				if links.length == 1
					opportunity_link = links[0]["href"] 
					full_link = "#{base_link}#{opportunity_link}"
					link_doc = Nokogiri::HTML(open(full_link))	
	    		response_due = link_doc.css("div[id = 'dnf_class_values_procurement_notice__response_deadline__widget']").text
	    		opportunity_description = link_doc.css("div[id = 'dnf_class_values_procurement_notice__description__widget']").text
				end
				opportunity_row << table_division.text 
				#opportunity_row[0] merged opportunity title and classification code
				#opportunity_row[1] agency
				#opportunity_row[2] state & set aside code
				#opportunity_row[3] submit date
				#opportunity_row[4] = opportunity title
				#opportunity_row[5] = classification code
				#opportunity_link is a link to the opportunity
				#response_due is the day the response is expected
				#opportunity_description is a description of the opportunity
				#full_link is a url to opportunity
			end

			def title_and_classification_code_splitter(opportunity_row, classification_codes)
				#puts opportunity_row
	    	#unless response_due == "none" #none means the table row is not valid
		  		classification_codes.each do |classification_code|
						if opportunity_row[0] && opportunity_row[0].include?(classification_code)
			 				opportunity_row << opportunity_row[0].split(classification_code)[0]
			 				opportunity_row << classification_code
						end
					end
				#end
			end

			def opportunity_database_evaluation(opportunity_row, response_due, opportunity_description, full_link)		
		   	if opportunity_row.length > 1 
		   		puts "now evaluating #{opportunity_row[5]}"
		   		duplicate_title = false 
		   		duplicate_procurement_type = false
	   			if Opportunity.find_by(opportunity: opportunity_row[4]) 
	   				potential_duplicate = Opportunity.find_by(opportunity: opportunity_row[4]) 
	   				duplicate_title = true    
						if potential_duplicate.post_date == opportunity_row[3]
	   					duplicate_procurement_type = true
	   					puts "dupe record is #{potential_duplicate.id}"
	   				end
	   			end 

	   			if duplicate_title && duplicate_procurement_type
	   				puts opportunity_row[4]
	   				puts opportunity_row[2]
						raise "Killing the script! We have been here before!. See Opportunity "
					else
						Opportunity.create(opportunity: opportunity_row[4],
														   class_code: opportunity_row[5],
															 agency: opportunity_row[1],
														   opp_type: opportunity_row[2],
												  	   post_date: opportunity_row[3],
														   response_date: response_due,
														   opportunity_description: opportunity_description,
														   link: full_link,
														   management_evaluation: nil) 
					end
				end
			end

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
						"96 -- Ores, minerals & their primary products", "99 -- Miscellaneous", "A -- Research & Development", "B -- Special studies and analysis - not R&D",
						"C -- Architect and engineering services", "D -- Information technology services, including telecommunications services", 
						"E -- Purchase of structures & facilities", "F -- Natural resources & conservation services",
						"G -- Social services", "H -- Quality control, testing & inspection services", "J -- Maintenance, repair & rebuilding of equipment", 
						"K -- Modification of equipment", "L -- Technical representative services", "M -- Operation of Government-owned facilities", "N -- Installation of equipment", "P -- Salvage services", 
						"Q -- Medical services", "R -- Professional, administrative, and management support services", "S -- Utilities and housekeeping services", 
						"T -- Photographic, mapping, printing, & publication services", "U -- Education & training services", "V -- Transportation, travel, & relocation services",
						"W -- Lease or Rental of equipment", "X -- Lease or rental of facilities", "Y -- Construction of structures and facilities",
						"Z -- Maintenance, repair, and alteration of real property" 
						 ]

			#ok, lets do this thing!
			title_and_classification_code_splitter(opportunity_row, classification_codes)
			opportunity_database_evaluation(opportunity_row, response_due, opportunity_description, full_link)
		end
	end
end
