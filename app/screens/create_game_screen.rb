class CreateGameScreen < UIViewController
  attr_accessor :signedin_player, :season,
    :table_view, :calendar, :time_picker, :create_game_button,
    :home_team_id, :away_team_id, :date, :hours, :minutes, :am_pm,
    :time_cell, :date_cell

  def viewWillAppear(animated)
    super(animated)
    setup_navbar
    setup_view
  end

  def numberOfSectionsInTableView(table_view)
    3
  end

  def tableView(table_view, numberOfRowsInSection:section)
    2
  end

  def tableView(table_view, heightForHeaderInSection:section)
    40
  end

  def tableView(table_view, viewForHeaderInSection:section)
    header = UIView.alloc.initWithFrame [[0,0],[320,40]]
    header << UILabel.alloc.init.tap do |l|
      l.text = 'Who?' if section == 0
      l.text = 'When?' if section == 1
      l.font = :bold.uifont(12)
      l.frame = [[5,30],[315,10]]
    end
    header
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    table_view.deselectRowAtIndexPath(index_path, animated:true)
    section = index_path.section
    row = index_path.row
    if section == 0
      show_team_picker
      ids = @season.teams.map{ |team| team.id }
      if row == 0
        @selecting_home_team = true
        index = ids.find_index(@home_team_id)
        if index.nil?
          index = 0
          @home_team_id = @season.teams.first
        end
        @team_picker.selectRow((index || 0), inComponent:0, animated:true)
      else
        @selecting_home_team = false
        index = ids.find_index(@away_team_id)
        if index.nil?
          index = 0
          @away_team_id = @season.teams.first
        end
        @team_picker.selectRow((index || 0), inComponent:0, animated:true)
      end
    elsif section == 1
      if row == 0
        hide_team_picker
        hide_time_picker
        show_calendar
      else
        show_time_picker
      end
    end
  end

  def hide_time_picker
    @time_picker.slide :left, 320 unless @time_picker.nil? || @time_picker.frame.x < 0
  end

  def hide_team_picker
    @team_picker.slide :left, 320 unless @team_picker.nil? || @team_picker.frame.x < 0
  end

  TableHeight = 320
  def show_time_picker
    unless @time_picker
      @am_pm = 'pm'; @hours = 9; @minutes = 0
      @time_picker = UIPickerView.alloc.initWithFrame [[-320,TableHeight],[320,162]]
    end
    @time_picker.dataSource = self
    @time_picker.delegate = self
    @time_picker.selectRow(AM_PM.find_index(@am_pm), inComponent:0, animated:true)
    @time_picker.selectRow(@hours-1, inComponent:1, animated:true)
    @time_picker.selectRow(@minutes/15, inComponent:2, animated:true)
    @time_picker.showsSelectionIndicator = true
    view << @time_picker
    hide_team_picker
    @time_picker.slide :right, 320 unless @time_picker.frame.x == 0
  end

  def show_team_picker
    unless @team_picker
      @team_picker = UIPickerView.alloc.initWithFrame [[-320,TableHeight],[320,162]]
    end
    @team_picker.dataSource = self
    @team_picker.delegate = self
    # @team_picker.selectRow(@minutes/15, inComponent:2, animated:true)
    @team_picker.showsSelectionIndicator = true
    view << @team_picker
    hide_time_picker
    @team_picker.slide :right, 320 unless @team_picker.frame.x == 0
  end

  def numberOfComponentsInPickerView(picker)
    if picker == @time_picker
      3
    else
      1
    end
  end

  AM_PM = ['am', 'pm']
  Hours = [1,2,3,4,5,6,7,8,9,10,11,12]
  Minutes = [00, 15, 30, 45]
  def pickerView(picker, numberOfRowsInComponent:column)
    if picker == @time_picker
      if column == 0
        AM_PM.count
      elsif column == 1
        Hours.count
      elsif column == 2
        Minutes.count
      end
    else
      @season.teams.count
    end
  end

  def pickerView(picker, titleForRow:row, forComponent:column)
    if picker == @time_picker
      if column == 0
        AM_PM[row]
      elsif column == 1
        Hours[row].to_s
      else
        Minutes[row].to_s
      end
    else
      @season.teams[row].name
    end
  end

  def selecting_home_team?
    @selecting_home_team
  end

  def pickerView(picker, didSelectRow:row, inComponent:col)
    if picker == @time_picker
      time_selected(row, col)
    else
      if selecting_home_team?
        @home_team_id = @season.teams[row].id
        @home_team_cell.detailTextLabel.text = @season.teams[row].name
        SVProgressHUD.showSuccessWithStatus('Home Team Set')
      else
        @away_team_id = @season.teams[row].id
        @away_team_cell.detailTextLabel.text = @season.teams[row].name
        SVProgressHUD.showSuccessWithStatus('Away Team Set')
      end
    end
  end

  def time_selected(row, column)
    if column == 0
      @am_pm = AM_PM[row]
    elsif column == 1
      @hours = Hours[row]
    else
      @minutes = Minutes[row]
    end
    if @minutes == 0
      minutes = '00'
    else
      minutes = @minutes.to_s
    end
    @time_cell.detailTextLabel.text = "#{@hours.to_s}:#{minutes} #{@am_pm}"
  end

  def show_calendar
    @calendar = CKCalendarView.new
    @calendar.frame = [[0,280], [320,293]]
    @calendar.delegate = self
    view << @calendar
  end

  def calendar(cal, didSelectDate:date)
    @calendar.removeFromSuperview
    @date = date
    @date_cell.detailTextLabel.text = date.string_with_format('LL/dd/yyyy')
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    # cell = recycled_cell
    cell = new_cell
    section = index_path.section
    row = index_path.row
    if section == 1
      if row == 0
        cell.textLabel.text = 'Day'
        @date_cell = cell
      else
        cell.textLabel.text = 'Time'
        @time_cell = cell
      end
    elsif section == 0
      if row == 0
        cell.textLabel.text = 'Home Team'
        @home_team_cell = cell
      else
        cell.textLabel.text = 'Away Team'
        @away_team_cell = cell
      end
    end
    cell
  end

  private
  def recycled_cell
    @table_view.dequeueReusableCellWithIdentifier('create game cell')
  end

  def new_cell
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:'create game cell')
    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell
  end

  def setup_navbar
    navigationItem.title = 'New Game'
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage('back_arrow.png'.uiimage, style:UIBarButtonItemStylePlain, target:self, action: :go_back_to_games_screen)
  end

  def setup_view
    view.backgroundColor = :white.uicolor
    setup_table_view
    add_submit_button
  end

  def add_submit_button
    @submit_button = UIButton.custom
    @submit_button.layer.borderWidth = 1
    @submit_button.layer.borderColor = 0xE3E3E5.uicolor
    @submit_button.backgroundColor = 0xdddddd.uicolor
    @submit_button.setTitle('Create Game', forState:UIControlStateNormal)
    @submit_button.frame = [[-10,480], [340,60]]
    @submit_button.when_tapped{ create_game if no_form_errors? }
    view << @submit_button
  end

  def no_form_errors?
    if @date.nil?
      SVProgressHUD.showErrorWithStatus('Enter a date')
      return false
    elsif @home_team_id.nil?
      SVProgressHUD.showErrorWithStatus('Add a home team')
      return false
    elsif @away_team_id.nil?
      SVProgressHUD.showErrorWithStatus('Add an away team')
      return false
    elsif @home_team_id == @away_team_id
      SVProgressHUD.showErrorWithStatus('Home and Away teams must be different')
      return false
    end
    true
  end

  def create_game
    @new_game = Game.new
    @new_game.season = @season
    hours = @hours
    hours += 12 if @am_pm == 'pm'
    @new_game.scheduled_time = @date + hours.hours + 4.hours + @minutes.minutes
    @new_game.home_team = @season.team_with_id(@home_team_id)
    @new_game.away_team = @season.team_with_id(@away_team_id)
    @new_game.create(@signedin_player) do
      if @new_game.created
        SVProgressHUD.showSuccessWithStatus('Game scheduled!')
        dismiss_modal
      else
        SVProgressHUD.showErrorWithStatus(@new_game.error)
      end
    end
  end

  def setup_table_view
    @table_view = UITableView.alloc.initWithFrame([[0,0],[320,TableHeight]], style: :plain.uitableviewstyle)
    @table_view.scrollEnabled = false
    @table_view.delegate = self
    @table_view.dataSource = self
    view << @table_view
  end

  def go_back_to_games_screen
    dismiss_modal
  end
end

# class CreateGameScreen < Formotion::FormController
#   include ProMotion::ScreenModule
# 
#   def viewWillAppear(animated)
#     super(animated)
#     navigationItem.title = 'New Game'
#     navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage('back_arrow.png'.uiimage, style:UIBarButtonItemStylePlain, target:self, action: :go_back_to_games_screen)
#   end
# 
#   def go_back_to_games_screen
#     dismiss_modal
#   end
# end
