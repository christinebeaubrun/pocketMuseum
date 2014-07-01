# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
require 'nokogiri'

namespace :db do

    desc "Srapes MoMA"
    task :seed do
        html = File.open("moma_museum/visit_moma.txt","r"){|file| file.read}
        data = Nokogiri::HTML(html)
        
        moma_museum ={}

        moma_museum[:name] = data.css('div.visit-section').css('strong').text
        moma_museum[:location] = data.css('div.visit-section').css('span.details').text.split(/\n\s+/)[1,2].join(", ")
        moma_museum[:image_url] = "moma_museum/moma.jpg"

        new_museum = Museum.create(moma_museum)
    
        all_exhibitions = []

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
            all_exhibitions << new_exhibition
            
        end

        all_exhibitions.each do |ex_hash|
            Exhibition.create(ex_hash)
        end
#########################################################################################################################################

    end

    desc "Srapes museum for name"
    task :met do


    end

    desc "Srapes museum and populates table"
    # task :seed do
        

    # end

end
