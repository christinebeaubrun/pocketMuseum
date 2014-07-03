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
    # end

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
    end

    # desc "Srapes museum and populates table"
    # task :seed => [:moma, :harlem]
        

end
