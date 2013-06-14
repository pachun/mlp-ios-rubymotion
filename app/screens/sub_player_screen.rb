class SubstitutePlayerScreen < ProMotion::TableScreen
  attr_accessor :league, :scorer, :ommitted_player_ids, :table_data

  title 'Subs'

  def on_load
    puts "in here with league = #{@league}, scorer = #{@scorer}, & ommitted player ids = #{@ommitted_player_ids.inspect}"
  end

  def will_appear
    update_table_data
  end

  def update_table_data
    if @league.players.nil?
      @league.get_players do
        fill_cells
        super
      end
    else
      fill_cells
      super
    end
  end

  def fill_cells
    players = @league.players.select { |p| !ommitted_player_ids.include?(p.id) }
    cells = players.map { |player| cell_for(player) }
    @table_data = [{:cells => cells}]
  end

  def cell_for(player)
    {
      :title => player.name,
      :action => :tapped,
      :arguments => player,
      :cell_style => UITableViewCellStyleDefault,
    }
  end

  def tapped(player)
    close({:player => player})
  end
end
