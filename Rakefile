# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
require 'nokogiri'

namespace :db do

  desc "Srapes museum for name"
  task :seed do
    html = File.open("moma_museum/visit_moma.txt","r"){|file| file.read}
    data = Nokogiri::HTML(html)
    moma_museum ={}

    moma_museum[:name] = data.css('div.visit-section').css('strong').text
    moma_museum[:location] = data.css('div.visit-section').css('span.details').text.split(/\n\s+/)[1,2].join(", ")
    
    new_museum = Museum.create(moma_museum)
    

  # desc "Scrapes each exhibitions: name,date,img,desc,museum_id"
  # task :exhibitionSeed do 
    all_exhibitions = []

    Dir.glob('moma_museum/*.text') do | file |
        html2 = File.read(file)
        data2 = Nokogiri::HTML(html2)

        new_exhibition = {}
        new_exhibition[:name] = data2.css('h2.ex-title').text
        new_exhibition[:date] =  data2.css('div.br-margins p.gray-type').text
        new_exhibition[:image_url] = "www.moma.org"+data2.css('div.center').css('img')[0].attributes["src"].value
        new_exhibition[:image_desc] = data2.css('div#caption p#desc.gray-type').text
        new_exhibition[:description] = data2.css('div.description p.top').text
        new_exhibition[:museum_id] = Museum.find(new_museum)
        
        all_exhibitions << new_exhibition
        
    end

    all_exhibitions.each do |ex_hash|
        Exhibition.create(ex_hash)
    end

  end

end
