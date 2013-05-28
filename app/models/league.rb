class League
  attr_accessor :id, :name, :commissioner_id, :current_season, :created_at,
    :players_per_team, :plays_balls_back, :rerack_cups, :extra_point_cups,
    :error, :commissioner, :invitable_players

  # UI entry points
  def create(&block)
    @created = false
    if valid_name? && valid_ppt?
      send_create_request(&block)
    else
      block.call
    end
  end

  # only called in code; no error checking
  def populate_invitable_players(&block)
    @invitable_players = []
    BW::HTTP.post(BaseURL + "/league/#{@id}/invitable_players/#{@commissioner.api_key}") do |response|
      BW::JSON.parse(response.body.to_str).each do |p|
        player = InvitedPlayer.new
        player.id = p[:id]
        player.name = p[:name]
        player.invited = p[:invited]
        player.accepted_invite = p[:accepted_invite]
        @invitable_players << player
      end
      block.call
    end
  end

  def invite(player, &block)
    BW::HTTP.post(BaseURL + "/league/#{@id}/invite/#{player.id}/#{@commissioner.api_key}") do |response|
      if response.ok?
        player.invited = true
      end
      block.call
    end
  end

  # shortcuts
  def created?
    @id.class == Fixnum
  end

  # setter overrides for reading formotion input
  def rerack_cups=(formotion_hash)
    @rerack_cups = ''
    formotion_hash.each_with_index do |(_,results_in_rerack), cup_number|
      if results_in_rerack
        @rerack_cups += ',' if @rerack_cups.length > 0
        @rerack_cups += (cup_number + 1).to_s
      end
    end
  end

  def extra_point_cups=(formotion_hash)
    @extra_point_cups = ''
    formotion_hash.each_with_index do |(_,worth_extra_points), cup_number|
      if worth_extra_points
        @extra_point_cups += ',' if @extra_point_cups.length > 0
        @extra_point_cups += (cup_number + 1).to_s
      end
    end
  end

  private

  # validations
  def valid_name?
    if @name.class == String && @name.length >= 2 && @name.length <= 20
      true
    else
      @error = 'Names are 2-20 long'
      false
    end
  end

  def valid_ppt?
    if @players_per_team == 2 || @players_per_team == 3
      true
    else
      @error = 'Either 2 or 3 players per team'
      false
    end
  end

  # requests
  def send_create_request(&block)
    data = {:league => {:name => @name,
                        :commissioner_id => @commissioner.id,
                        :players_per_team => @players_per_team,
                        :plays_balls_back => @plays_balls_back,
                        :rerack_cups => @rerack_cups,
                        :extra_point_cups => @extra_point_cups,
    }}
    BW::HTTP.post(BaseURL + "/league/#{@commissioner.api_key}", {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        @id = json['id']
      else
        @error = 'Couldn\'t create league'
      end
      block.call
    end
  end
end
