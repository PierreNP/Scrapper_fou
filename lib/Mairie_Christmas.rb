require 'open-uri'
require 'nokogiri' 


def nom_villes

    doc = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html")) 
    list_villes = []

    doc.css('td > p > a.lientxt').each do |ville|
        list_villes.push(ville.text)
    end

    return list_villes
end

def lien_villes

    doc = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html")) 
    list_url = []

    doc.xpath('//a[contains(@href,"95")]/@href').each do |lien|
        url_mairie = lien.to_s
        list_url << "http://annuaire-des-mairies.com" + url_mairie[1, 1000]
    end

    return list_url
end

def couple

    list_villes = nom_villes
    list_url = lien_villes
    courriel = []

    list_url.each do |url_mairie|
        doc = Nokogiri::HTML(URI.open(url_mairie))
        doc.css("body > div > main > section:nth-child(2) > div > table > tbody > tr:nth-child(4) > td:nth-child(2)").each do |mail_mairie|
            if mail_mairie.text == ""
                str = "pas de mail"
                courriel << str
            else
                courriel << mail_mairie.text
            end
        end
    end

    duo = list_villes.zip(courriel).map { |x, y| {x => y} }

    return duo
end

puts couple