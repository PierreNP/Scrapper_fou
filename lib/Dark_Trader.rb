require 'open-uri'
require 'nokogiri' 


# Scrap the cryptocurrencies

def crypto

    doc = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))  
    list_c = []

    doc.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div/a[2]').each do |crypto|
        list_c.push(crypto.text)       
    end
    
    return list_c
end

def price

    doc = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
    list_p = []

    doc.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a').each do |price|
        list_p.push(price.text)
    end
    
    return list_p
end

def fusion

    list_crypto = crypto
    list_price = price 

    return list_crypto.zip(list_price).map { |x, y| {x => y.delete("$,").to_f} }
end

def perform
    print fusion    
end

perform




