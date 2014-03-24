#require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'axlsx'
require 'date'

todays_date = Date.today.strftime('%m/%d/%Y')

doc = Nokogiri::HTML(open("https://www.fbo.gov/index?s=opportunity&mode=list&tab=list&tabmode=list&pp=10"))

#Classification Code Evaluation. Move codes from "good_class_code" to "bad_class_code" based on your area of expertise.
bad_class_codes =  ["11 -- Nuclear ordnance", "13 -- Ammunition & explosives", "18 -- Space vehicles", 
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
					"58 -- Communication, detection, & coherent radiation equipment", "62 -- Lighting fixtures & lamps", "63 -- Alarm, signal & security detection equipment",
					"65 -- Medical, dental & veterinary equipment &  supplies", "66 -- Instruments & laboratory equipment", "67 -- Photographic equipment",
					"68 -- Chemicals & chemical products", "71 -- Furniture", "72 -- Household & commercial furnishings & appliances", "73 -- Food preparation and serving equipment",
					"74 -- Office machines, text processing systems & visible record equipment", "75 -- Office supplies and devices", "76 -- Books, maps & other publications",
					"77 -- Musical instruments, phonographs & home-type radios", "78 -- Recreational & athletic equipment", "79 -- Cleaning equipment and supplies",
					"80 -- Brushes, paints, sealers & adhesives", "81 -- Containers, packaging, & packing supplies", "83 -- Textiles, leather, furs, apparel & shoe findings, tents & flags",
					"84 -- Clothing, individual equipment & insignia", "85 -- Toiletries", "87 -- Agricultural supplies", "88 -- Live animals", "89 -- Subsistence",
					"91 -- Fuels, lubricants, oils & waxes", "93 -- Nonmetallic fabricated materials", "94 -- Nonmetallic crude materials", "95 -- Metal bars, sheets & shapes",
					"96 -- Ores, minerals & their primary products", "99 -- Miscellaneous", "E -- Purchase of structures & facilities", "F -- Natural resources & conservation services",
					"G -- Social services", "M -- Operation of Government-owned facilities", "P -- Salvage services", "Q -- Medical services", "S -- Utilities and housekeeping services", 
					"T -- Photographic, mapping, printing, & publication services", "V -- Transportation, travel, & relocation services",
					"W -- Lease or Rental of equipment", "X -- Lease or rental of facilities", "Y -- Construction of structures and facilities",
					"Z -- Maintenance, repair, and alteration of real property", 
					 ]

good_class_codes = ["10 -- Weapons", "12 -- Fire control equipment", "14 -- Guided missiles", "15 -- Aircraft & airframe structural components",
					"16 -- Aircraft components & accessories", "17 -- Aircraft launching, landing & ground handling equipment",
					"59 -- Electrical and electronic equipment components", "60 -- Fiber optics materials, components, assemblies & accessories",
					"61 -- Electric wire &  power &  distribution equipment", "69 -- Training aids & devices", "70 -- General purpose information technology equipment",
					"A -- Research & Development", "B -- Special studies and analysis - not R&D", "C -- Architect and engineering services", 
					"D -- Information technology services, including telecommunications services", "H -- Quality control, testing & inspection services",
					"J -- Maintenance, repair & rebuilding of equipment", "K -- Modification of equipment", "L -- Technical representative services", 
					"N -- Installation of equipment", "R -- Professional, administrative, and management support services",
					"U -- Education & training services"
				    ]

bad_set_asides =    ["Total Small Business"]

#Opportunities that match your keywords will be highlighted in output.
good_keywords = ["Aircraft"]
bad_keywords  = ["Toilet"]

#Opportunities that are in following procurement phase will be highlighted in output.
procurement_type = ["Presolicitation", "Combined Synopsis/Solicitation", "Sources Sought"]

opportunity_hash = {}
#Hash counter should be the opportunity with special characters removed. This would prevent overwrites.
hash_counter = 1

base_link = "https://www.fbo.gov/index"

doc.css('tr').each do |table_row|
    opportunity_hash[hash_counter] =  {
			:column_values => [] }
	table_row.css('td').each do |table_division|
		links = table_division.css("a")
		if links.length == 1
			puts "Checking opportunity #{hash_counter}"
			opp_link = links[0]["href"]
			full_link = "#{base_link}#{opp_link}"
			opportunity_hash[hash_counter][:link] = full_link
			puts full_link
			link_doc = Nokogiri::HTML(open(full_link))	
    		response_due = link_doc.css("div[id = 'dnf_class_values_procurement_notice__response_deadline__widget']").text
    		opportunity_hash[hash_counter][:response_due] = response_due
		end
		opportunity_hash[hash_counter][:column_values] << table_division.text 
	end
	hash_counter += 1
end

#Remove scraped rows that are junk. Only rows with data in all four columns are valid.
opportunity_hash.each do |k,v|
	unless v[:response_due]
		v[:valid_record] = false
	end
end

opportunity_hash.each do |k,v| 
	unless v[:valid_record] == false
		v[:classification_code] = "Bad Classification"
		good_class_codes.each do |c_code|
			if v[:column_values][0].include?(c_code)
				bad_set_asides.each do |set_aside|
					unless v[:column_values][2].include?(set_aside)
						v[:classification_code] = "Good Classification"
						v[:opportunity] = v[:column_values][0].split(c_code)[0]
						v[:class_code] = c_code
					end
				end
			end
		end
		v[:procurement_type] = "Bad Procurement"
		procurement_type.each do |p_type|
			if v[:column_values][2].include?(p_type)
				unless v[:column_values][2].include?("Cancelled")
					v[:procurement_type] = "Good Procurement"
				end
			end
		end
	end
end



#writes out a file seed.txt
output = File.open('seed.txt', 'w')
output.puts('ops = Opportunity.create([')
opportunity_hash.each do |k,v|
	unless v[:valid_record] == false
		if v[:classification_code] == "Good Classification" && v[:procurement_type] == "Good Procurement"
			output.puts("{ opportunity: '#{v[:opportunity]}', ")
			output.puts(" class_code: '#{v[:class_code]}', ")
			output.puts(" agency: '#{v[:column_values][1]}', ")
			output.puts(" opp_type: '#{v[:column_values][2]}', ")
			output.puts(" post_date: '#{v[:column_values][3]}', ")
			output.puts(" response_date: '#{v[:response_due]}', ")
			output.puts(" link: '#{v[:link]}' }, ")
			#output.puts(" procurement: '#{v[:procurement_type]}', ")
			#output.puts(" code: '#{v[:classification_code]}'}, ")
		end
	end
end
#manually, remove last "," of prior line
output.puts('])')	


