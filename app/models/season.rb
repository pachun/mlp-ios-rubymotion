class Season
  attr_accessor :id, :created_at, :name, :teams_locked, :league_id,
    :league, :teams

  attr_accessor :error, :created

  def self.from_hash(season_hash)
    season = Season.new
    season.id = season_hash[:id] if season_hash.has_key?(:id)
    season.name = season_hash[:name] if season_hash.has_key?(:name)
    season.teams_locked = season_hash[:teams_locked] if season_hash.has_key?(:teams_locked)
    season.league = season_hash[:league] if season_hash.has_key?(:league)
    season.league_id = season_hash[:league_id] if season_hash.has_key?(:league_id)
    season.created_at = season_hash[:created_at] if season_hash.has_key?(:created_at)
    season
  end

  def create(&block)
    @created = false
    if valid_name?
      save(&block)
    else
      block.call
    end
  end

  def get_teams(player, &block)
    BW::HTTP.get(BaseURL + "/season/#{@id}/teams/#{player.api_key}") do |response|
      puts "response = #{response.body}"
    end
  end

  private

  def valid_name?
    if @name.class == String && @name.length >= 2 && @name.length <= 20
      true
    else
      @error = 'Names are 2-20 long'
      false
    end
  end

  def save(&block)
    data = {:season => {:name => @name,
                        :league_id => @league.id
    }}
    BW::HTTP.post(BaseURL + "/season/#{@league.commissioner.api_key}", {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        @id = json[:id]
        @teams_locked = json[:teams_locked]
        @created_at = json[:created_at]
        @created = true
      else
        @error = 'Couldn\'t create season'
      end
      block.call
    end
  end
end
