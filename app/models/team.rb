class Team
  attr_accessor :id, :name, :season, :players,
    :proposed_at, :finalized_at, :playoff_seat, :eliminated, :wins, :losses,
    :player1_accepted, :player2_accepted, :player3_accepted,
    :player1_responded, :player2_responded, :player3_responded

  attr_accessor :error, :created

  def self.from_hash(team_hash, with_season:season)
    team = Team.new
    team.id = team_hash[:id]
    team.name = team_hash[:name]
    team.wins = team_hash[:wins]
    team.losses = team_hash[:losses]
    team.season = season
    team.players = []
    team.players[0] = season.league.player_with_id(team_hash[:p1_id])
    team.players[1] = season.league.player_with_id(team_hash[:p2_id])
    team.players[2] = season.league.player_with_id(team_hash[:p3_id]) if season.league.players_per_team == 3
    team.proposed_at = team_hash[:proposed_at]
    team.finalized_at = team_hash[:finalized_at]
    team.player1_accepted = team_hash[:p1_accepted]
    team.player2_accepted = team_hash[:p2_accepted]
    team.player3_accepted = team_hash[:p3_accepted]
    team.player1_responded = team_hash[:p1_responded]
    team.player2_responded = team_hash[:p2_responded]
    team.player3_responded = team_hash[:p3_responded]
    team.playoff_seat = team_hash[:playoff_seat]
    team.eliminated = team_hash[:eliminated]
    team
  end

  def initialize
    @finalized = false
  end

  def create(&block)
    @created = false
    if valid_name? && enough_members?
      save(&block)
    else
      block.call
    end
  end

  def finalized?
    !@finalized_at.nil?
  end

  def nullified?
    if @season.league.players_per_team == 3
      (@player1_responded && !@player1_accepted) || (@player2_responded && !@player2_accepted) || (@player3_responded && !@player3_accepted)
    else
      (@player1_responded && !@player1_accepted) || (@player2_responded && !@player2_accepted)
    end
  end

  def was_accepted_by(player)
    if player.id == @players[0].id && @player1_responded && @player1_accepted
      true
    elsif player.id == @players[1].id && @player2_responded && @player2_accepted
      true
    elsif @season.league.players_per_team == 3 && player.id == @players[2].id && @player3_responded && @player3_accepted
      true
    else
      false
    end
  end

  def has_response_for(player)
    if player.id == @players[0].id
      @player1_responded
    elsif player.id == @players[1].id
      @player2_responded
    else
      @player3_responded
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

  def enough_members?
    @players.select!{ |p| !p.nil? }
    if @season.league.players_per_team == @players.count
      true
    else
      @error = 'Choose another teammate'
      false
    end
  end

  def save(&block)
    data = {:team => {:name => @name,
                      :season_id => @season.id,
                      :p1_id => @players[0].id,
                      :p2_id => @players[1].id,
    }}
    data[:team][:p3_id] = @players[2].id if @season.league.players_per_team == 3
    BW::HTTP.post(BaseURL + "/team/#{@players.first.api_key}", {payload: data}) do |response|
      if response.ok?
        @created = true
        team_json = BW::JSON.parse(response.body.to_str)
        @id = team_json[:id]
        @wins = 0
        @losses = 0
        @nullified = false
        @finalized = false
        @proposed_at = team_json[:proposed_at]
        @player1_accepted = true
        @player2_accepted = false
        @player3_accepted = false
        @players[0] = @season.league.player_for(@players[0])
      end
      block.call
    end
  end
end
