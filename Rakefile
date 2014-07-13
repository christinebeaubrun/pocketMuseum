# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
require 'nokogiri'

namespace :db do

    # desc "Srapes MoMA"
    task :seed do
        html = File.open("moma_museum/visit_moma.txt","r"){|file| file.read}
        data = Nokogiri::HTML(html)
        
        moma_museum ={}

        moma_museum[:name] = data.css('div.visit-section').css('strong').text
        moma_museum[:location] = data.css('div.visit-section').css('span.details').text.split(/\n\s+/)[1,2].join(", ")

        new_museum = Museum.create(moma_museum)
    
        moma_exhibitions = []

        Dir.glob('moma_museum/*.html') do | file |
            html2 = File.read(file)
            data2 = Nokogiri::HTML(html2)

            new_exhibition = {}
            new_exhibition[:name] = data2.css('h2.ex-title').text
            new_exhibition[:date] =  data2.css('div.br-margins p.gray-type').text
            new_exhibition[:image_url] = "http://www.moma.org"+data2.css('div.center').css('img')[0].attributes["src"].value
            new_exhibition[:image_desc] = data2.css('div#caption p#desc.gray-type').text
            if data2.css('div.br-margins div.description p.top').text == ""
                new_exhibition[:description] = data2.css('div.br-margins div.description').text
            else
                new_exhibition[:description] = data2.css('div.br-margins div.description p.top').text
            end
            new_exhibition[:museum_id] = new_museum.id 
            # p.top
            moma_exhibitions << new_exhibition
            
        end

        moma_exhibitions.each do |ex_hash|
            Exhibition.create(ex_hash)
        end
    

#########################################################################################################################################


    # desc "Srapes Harlem museum"
    # task :harlem do
        harlem_html = File.open("studio_museum_in_harlem/harlem_visit.text","r"){|file| file.read}
        harlem_data = Nokogiri::HTML(harlem_html)

        harlem_museum = {}

        harlem_museum[:name] = harlem_data.css('div.visit-info-header-right h4').text
        harlem_museum[:location] = harlem_data.css('div.visit-info-header-right p')[0].text.gsub(/\r\n\t/,", ")

        new_museum2 = Museum.create(harlem_museum)

        harlem_exhibitions = []

        Dir.glob('studio_museum_in_harlem/*.html') do | file |
            harlem_ex_html = File.read(file)
            harlem_ex_data = Nokogiri::HTML(harlem_ex_html)

            harlem_exhib = {}

            harlem_exhib[:name] = harlem_ex_data.css('div.title-date span.titletype').text.strip.split(/\r\n\s+/).join('\n')
            harlem_exhib[:date] = harlem_ex_data.css('div.field-field-event-date').text
            harlem_exhib[:image_url] = harlem_ex_data.css('img.imagecache').css('img').first.attributes["src"].value
            harlem_exhib[:image_desc] = harlem_ex_data.css('li.slide-caption > p').first.text.gsub(/\"/,"").split(/\r\n\t/).join(".  ")
            harlem_exhib[:description] = harlem_ex_data.css('div.content.clear-block > p').text
            harlem_exhib[:museum_id] = new_museum2.id

            harlem_exhibitions << harlem_exhib
        end


        harlem_exhibitions.each do |harlem_hash|
            Exhibition.create(harlem_hash)
        end

    

    # desc "Srapes museum and populates table"
    # task :seed => [:moma, :harlem]
    #########################################################################################################################################


    # desc "Srapes Brooklyn museum"
    # task :brooklyn do
        brooklyn_html = File.open("brooklyn_museum/brooklyn_visit.text","r"){|file| file.read}
        brooklyn_data = Nokogiri::HTML(brooklyn_html)

        brooklyn_museum = {}

        brooklyn_museum[:name] = brooklyn_data.css('div.footer-header')[0].text
        brooklyn_museum[:location] = brooklyn_data.css('div.footer-section p').text.split(/\n\t\t\t|\t\t\t|\n\s+/)[1,2].join(", ")[0..38]

        new_museum3 = Museum.create(brooklyn_museum)
        brooklyn_exhibitions = []

        Dir.glob('brooklyn_museum/*.html') do | file |
            brooklyn_ex_html = File.read(file)
            brooklyn_ex_data = Nokogiri::HTML(brooklyn_ex_html)

            brooklyn_exhib = {}

            brooklyn_exhib[:name] = brooklyn_ex_data.css('h1#page-title').text.split(/\n\t/).last.strip
            if brooklyn_ex_data.css('p.date').text == ''
                brooklyn_exhib[:date] = "Ongoing"
            else
                brooklyn_exhib[:date] = brooklyn_ex_data.css('p.date').text
            end
            brooklyn_exhib[:image_url] = brooklyn_ex_data.css('div#exhibition-signature').css('img').first.attributes["src"].value
            brooklyn_exhib[:image_desc] = brooklyn_ex_data.css('div#exhibition-signature p').text.strip
            brooklyn_exhib[:description] = brooklyn_ex_data.css('div#exhibition-main p')[3..6].text.strip.gsub(/\n\t/, "  ")
            brooklyn_exhib[:museum_id] = new_museum3.id

            brooklyn_exhibitions << brooklyn_exhib
            
        end

        brooklyn_exhibitions.each do |brooklyn_hash|
            Exhibition.create(brooklyn_hash)
        end
        
    

   
    #########################################################################################################################################
    # # desc "Srapes MET museum and populates table"
    # task :seed

        met_html = File.open("met_museum/met_visit.text","r"){|file| file.read}
        met_data = Nokogiri::HTML(met_html)

        met_museum = {}

        met_museum[:name] = met_data.css('div.general-content p')[0].text
        met_museum[:location] = met_data.css('div.general-content p')[1].text.split("\n")[0..1].join(", ")[0..36]

        new_museum4 = Museum.create(met_museum)
        
        met_exhibitions = []

        Dir.glob('met_museum/*.html') do | file |
            met_ex_html = File.read(file)
            met_ex_data = Nokogiri::HTML(met_ex_html)

            met_exhib = {}

            met_exhib[:name] = met_ex_data.css('div.text-box.first.cleared').text.split(/\r\n\s+/)[1..2].join(": ")
            met_exhib[:date] = met_ex_data.css('div.text-box.first.cleared').text.split(/\r\n\s+/)[3]
            met_exhib[:image_url] = met_ex_data.css('div.poster.visible').css('img').first.attributes["src"].value
            met_exhib[:image_desc] = met_ex_data.css('span.inline-caption').text
            met_exhib[:description] = met_ex_data.css('span#phcontent_0_phfullwidthcontent_0_aboutTheExhibitionBriefBody p').text
            met_exhib[:museum_id] = new_museum4.id

            met_exhibitions << met_exhib

        end
        
        met_exhibitions.each do |met_hash|
            Exhibition.create(met_hash)
        end
    

    #########################################################################################################################################
    # # desc "Srapes MET museum and populates table"
    # task :seed 

        guggenheim_html = File.open("guggenheim_museum/guggenheim_visit.text","r"){|file| file.read}
        guggenheim_data = Nokogiri::HTML(guggenheim_html)

        guggenheim_museum = {}

        guggenheim_museum[:name] = guggenheim_data.css('div#callout-484.box.box-a p').text.split("br /> ")[0]
        guggenheim_museum[:location] = guggenheim_data.css('div#callout-484.box.box-a p').text.split("br /> ")[1].split(" 10128")[0]
       
        new_museum5 = Museum.create(guggenheim_museum)
        guggenheim_exhibitions = []

        Dir.glob('guggenheim_museum/*.html') do | file |
            guggenheim_ex_html = File.read(file)
            guggenheim_ex_data = Nokogiri::HTML(guggenheim_ex_html)

            guggen_exhib = {}

            guggen_exhib[:name] = guggenheim_ex_data.css('div#title-bar h1').text
            guggen_exhib[:date] = guggenheim_ex_data.css('div.exh-dateline').text
            guggen_exhib[:image_url] = guggenheim_ex_data.css('a.thickbox').css('img').first.attributes["src"].value
            guggen_exhib[:image_desc] = guggenheim_ex_data.css('p.caption').text
            guggen_exhib[:description] = guggenheim_ex_data.css('div.img-caption p')[0..-2].text
            guggen_exhib[:museum_id] = new_museum5.id

            guggenheim_exhibitions << guggen_exhib

        end

        guggenheim_exhibitions.each do |guggen_hash|
            Exhibition.create(guggen_hash)
        end

    #########################################################################################################################################
    # # desc "Srapes Whitney museum and populates table"
    # task :seed 

        whitney_html = File.open("whitney_museum/whitney_visit.text","r"){|file| file.read}
        whitney_data = Nokogiri::HTML(whitney_html)

        whitney_museum = {}

        whitney_museum[:name] = whitney_data.css('div.wrapper ul.one-third-width')[0].text.split("\n      ")[1]
        whitney_museum[:location] = whitney_data.css('div.wrapper ul.one-third-width')[0].text.split("\n      ")[2..3].join(", ")
        
        new_museum6 = Museum.create(whitney_museum)
        whitney_exhibitions = []

        Dir.glob('whitney_museum/*.html') do | file |
            whitney_ex_html = File.read(file)
            whitney_ex_data = Nokogiri::HTML(whitney_ex_html)

            whitney_exhib = {}

            whitney_exhib[:name] = whitney_ex_data.css('div.title h1').text
            whitney_exhib[:date] = whitney_ex_data.css('div.title h2')[0].text.gsub(/\n\s+/,"")
            whitney_exhib[:image_url] = "http://www.whitney.org"+whitney_ex_data.css('div.exhibition-image-module-image')[0].children[1].attributes["src"].value
            whitney_exhib[:image_desc] = whitney_ex_data.css('div.exhibition-image-module-image')[0].children[1].attributes["alt"].value
            whitney_exhib[:description] = whitney_ex_data.css('div.text-module-text')[0].text.gsub(/\n+\s+/,"")
            whitney_exhib[:museum_id] = new_museum6.id

            whitney_exhibitions << whitney_exhib

        end 
        whitney_exhibitions.each do |whitney_hash|
            Exhibition.create(whitney_hash)
        end

    #########################################################################################################################################
    # # desc "Srapes Frick museum and populates table"
    # task :seed 

        frick_html = File.open("frick_museum/frick_visit.text","r"){|file| file.read}
        frick_data = Nokogiri::HTML(frick_html)

        frick_museum = {}

        frick_museum[:name] = frick_data.css('div.field-item a')[0].text
        frick_museum[:location] = frick_data.css('div.field-item p')[2].text.split(" 10021")[0].gsub(/\n+\t+/,", ")
        
        new_museum7 = Museum.create(frick_museum)

        frick_exhibitions = []

        Dir.glob('frick_museum/*.html') do | file |
            frick_ex_html = File.read(file)
            frick_ex_data = Nokogiri::HTML(frick_ex_html)

            frick_exhib = {}

            frick_exhib[:name] = frick_ex_data.css('div.field-item em').text
            frick_exhib[:date] = frick_ex_data.css('div.field-item')[1].text
            frick_exhib[:image_url] = frick_ex_data.css('div.field-item a')[0].attributes["href"].value
            frick_exhib[:image_desc] = frick_ex_data.css('div.field-item')[5].text
            frick_exhib[:description] = frick_ex_data.css('div.field-item')[3].text
            frick_exhib[:museum_id] = new_museum6.id

            frick_exhibitions << frick_exhib

        end 
        frick_exhibitions.each do |frick_hash|
            Exhibition.create(frick_hash)
        end

    #########################################################################################################################################
    # # desc "Srapes PS1 museum and populates table"
    # task :seed 

        # ps1_html = File.open("ps1_museum/ps1_visit.text","r"){|file| file.read}
        # ps1_data = Nokogiri::HTML(ps1_html)

        # ps1_museum = {}
        # LOCATION IS WEIRD
        # ps1_museum[:name] = ps1_data.css('div#footer p')[0].children[0].text[7..14]
        # ps1_museum[:location] = ps1_data.css('div#footer p')[0].children[11].text.gsub(/\n\tAddress: /, "")
        
        # new_museum8 = Museum.create(ps1_museum)
        # binding.pry 
        # ps1_exhibitions = []

        # Dir.glob('ps1_museum/*.html') do | file |
        #     ps1_ex_html = File.read(file)
        #     ps1_ex_data = Nokogiri::HTML(ps1_ex_html)

        #     ps1_exhib = {}

        #     ps1_exhib[:name] = ps1_ex_data.css('div.field-item em').text
        #     ps1_exhib[:date] = ps1_ex_data.css('div.field-item')[1].text
        #     ps1_exhib[:image_url] = ps1_ex_data.css('div.field-item a')[0].attributes["href"].value
        #     ps1_exhib[:image_desc] = ps1_ex_data.css('div.field-item')[5].text
        #     ps1_exhib[:description] = ps1_ex_data.css('div.field-item')[3].text
        #     ps1_exhib[:museum_id] = new_museum6.id

        #     ps1_exhibitions << ps1_exhib

        # end 
        # ps1_exhibitions.each do |ps1_hash|
        #     Exhibition.create(ps1_hash)
        # end
    end
end