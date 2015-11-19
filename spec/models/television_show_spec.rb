require_relative "../spec_helper"

describe TelevisionShow do

  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  let :tv_show do
    TelevisionShow.new("Sienfeld", "NBC", "1994",
                       "Six friends living in New York city", "Comedy")
  end

  let :tv_show2 do
    TelevisionShow.new("Friends", "NBC", "1994",
                       "Six friends living in New York city", "Comedy")
  end

  before :each do
    CSV.open('television-shows.csv', 'a') do |file|
      title = "Friends"
      network = "NBC"
      starting_year = "1994"
      synopsis = "Six friends living in New York city"
      genre = "Comedy"
      data = [title, network, starting_year, synopsis, genre]
      file.puts(data)
    end
  end

  describe "#initialize" do
    it "should be a TV Show" do
      expect(tv_show).to be_a(TelevisionShow)
    end

    it "has attribues title, network, starting_year, synopsis, genre" do
      expect(tv_show.title).to be_a(String)
      expect(tv_show.starting_year).to be_a(String)
      expect(tv_show.synopsis).to be_a(String)
      expect(tv_show.network).to be_a(String)
      expect(GENRES.include?(tv_show.genre)).to be(true)
    end
  end

  describe "self#all" do
    it "returns all television shows as objects" do
      tv_shows = TelevisionShow.all
      tv_shows.each { |tv_show| expect(tv_show).to be_a(TelevisionShow) }
    end
  end


  describe "#valid?" do
    it "returns true if there are no empty strings" do
      expect(tv_show.valid?).to eq(true)
    end

    it 'returns false if title is already in CSV' do
      expect(tv_show2.valid?).to eq(false)
    end
  end

  describe "#save" do
    it "returns true if it saves tv shows to the CSV file" do
      expect(tv_show.save).to eq(true)
    end

    it "returns true if it saves tv shows to the CSV file" do
      expect(tv_show2.save).to eq(false)
    end
  end

  describe "#errors" do
    it 'returns an empty array when errors are called on a valid object' do
      expect(tv_show.errors).to eq(nil)
    end

    it 'if missing field, returns error string requesting required fields' do
      tv_show3 = TelevisionShow.new("", "NBC", 1994,
                         "Six friends living in New York city", "Comedy")
binding.pry
      expect(tv_show3.errors).to eq (["Please fill in all required fields"])
    end

    it 'if already exists in csv, returns string saying such' do
      expect(tv_show2.errors).to eq (["The show has already been added"])
    end
  end

end
