require 'open-uri'
require 'nokogiri' 

def prenom_nom

    doc = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique")) 
    list_prenom_nom_brute = [] #array avec M. et Mme prénom et nom tout ensemble

    doc.css('//*[@id="deputes-list"]/div/ul/li/a').each do |depute|
        list_prenom_nom_brute.push(depute.text.split(" "))
    end

    list_prenom_nom = [] #array avec juste prénom et nom
    
    list_prenom_nom_brute.each do |element|
        list_prenom_nom.push(element.drop(1))
    end

    list_prenom = [] #array avec juste prénoms

    list_prenom_nom.each do |couple|
        list_prenom.push(couple[0])
    end
    
    list_nom = [] #array avec juste noms

    list_prenom_nom.each do |triple|
        
        if triple.length == 2
        list_nom.push(triple[1])
        else
        list_nom.push(triple[1..10].join(" "))
        end
    end
    
    
    doc.css('//*[@id="deputes-list"]/div[2]/ul[3]/li[11]/a').each do |depute|
        list_prenom_nom_brute.push(depute.text.split(" "))
    end
    
    
    # méthode pour récupérer les URLs du profil de chaque député

    doc_bis = Nokogiri::HTML(URI.open('https://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
    
    deputes = []
    
    doc_bis.xpath('//a[contains(@href,"fiche")]/@href').each do |lien|
        deputes.push("https://www2.assemblee-nationale.fr/"+lien.content)
    end 
        
    
    courriel=[]
    
    deputes.each do |liens_deputes|
    doc_ter = Nokogiri::HTML(URI.open(liens_deputes))
    doc_ter.css("#haut-contenu-page > article > div.contenu-principal.en-direct-commission.clearfix > div > dl > dd > ul > li:nth-child(2) > a").each do |deputes_fiche|
        courriel << doc_ter.css("#haut-contenu-page > article > div.contenu-principal.en-direct-commission.clearfix > div > dl > dd > ul > li:nth-child(2) > a").text
        end
    end
       p courriel

end

prenom_nom



