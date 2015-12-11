# algorithm keypoints:
#
# 

namespace :myfrenchstartup do
  desc "Ecrire un scrapper qui extrait vers une database le maximum d’informations pertinentes depuis l'annuaire: http://www.myfrenchstartup.com/fr/liste­-startup-­france"
  task :scrapper => :environment do
    require 'nokogiri'
    require 'rest-client'
    require 'json'

    # We can also pass this URL via a task argument
    BASE_URL = "http://www.myfrenchstartup.com/fr/liste-startup-france"

    companies = {}
    startup_count = 0
      
      1.upto(270) do |page_number|
        
        url = "#{BASE_URL}/-#{page_number}"

        page = Nokogiri::HTML(RestClient.get(url))
        
        links = page.css("table.table tr a").select # Select all links

        links.each do |link|

        startup_page = Nokogiri::HTML(RestClient.get(link["href"]))

        # Scrapping company's information

        public_name = startup_page.css(".main-header h1.nom_sup_fiche span").children.first.to_s.squish
        description = startup_page.css(".description_detail p").select.map {|p| p.children.first.to_s }.join('')
        logo        = startup_page.css(".bloc_right .logo_sup img").select.map{ |img| img['src'].squish }.first

        startup = Startup.create(public_name: public_name, description: description, logo: logo)

        # Scrapping Founders information

        founders = startup_page.css("body > div:nth-child(8) > div > div.col-md-9.col-xs-12 > div:nth-child(5) > div.row > div").select
        
        founders.each do |founder|
          name      = founder.css(".nom_fondateur_equipe").children.first.to_s.squish
          job_title = founder.css("div:eq(3)").children.first.to_s.squish
          picture   = founder.css("img").map{ |img| img['src'].squish }.first

          startup.founders.create(name: name, job_title: job_title, picture: picture)
        end

        # Scrapping Social Networks information

        social_networks = startup_page.css("body > div:nth-child(8) > div > div.col-md-3.col-xs-12 > div > div:nth-child(5) > div:nth-child(4) > span").select

        social_networks.each do |social_network|
          name = case social_network.css("a img").select.first["id"]
          when "tw" then "Twitter"
          when "fb" then "Facebook"
          when "in" then "LinkedIn"
          end
          link = social_network.css('a').select.first["href"]
          
          startup.social_networks.create(name: name, link: link)
        end

        startup_count += 1
        print("\rscrapped startups: #{startup_count}")

      end # startup_links.each
    
    end # 1.upto(270)
    puts
  end
end
