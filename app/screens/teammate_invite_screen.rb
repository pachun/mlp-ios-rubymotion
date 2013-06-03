class TeammateInviteScreen < ProMotion::TableScreen
  attr_accessor :league, :excluded_players

  title 'Teammate'

  def table_data
    [{:cells => cells}]
  end

  def selected(player)
    close(teammate: player)
  end

  private

  def cells
    players.map do |player|
      {
        :title => player.name,
        :action => :selected,
        :arguments => player,
      }
    end
  end

  def players
    @league.players.select do |p|
      p.id != @excluded_players[0].id && (@excluded_players[1].nil? || p.id != @excluded_players[1].id)
    end
  end
end
