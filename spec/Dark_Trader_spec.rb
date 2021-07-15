require_relative '../lib/Dark_Trader.rb'

describe "getting the name of at least one currency" do
    it "should give me Bitcoin" do
        expect(crypto().to eq(97))
    end
end

describe "getting a hash with the name and value of the currency" do
    it "should give me Bitcoin and its price" do
        expect(fusion(0).to eq("Bitcoin"=>31936.96))
    end
end
    
