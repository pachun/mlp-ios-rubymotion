class PlayerDetailsScreen < ProMotion::Screen
  stylesheet :player_details_sheet

  layout :root do
    subview UIImageView, :gravatar, :image => @player.gravatar
    subview UIView, :important_stats_box do
      subview UILabel, :spp_label
      subview UILabel, :spp, :text => @player.spp.to_s
      subview UILabel, :shp_label
      subview UILabel, :shp, :text => @player.shp.to_s
      subview UILabel, :slc_label
      subview UILabel, :slc, :text => @player.slc.to_s
      subview UILabel, :lpp_label
      subview UILabel, :lpp, :text => @player.lpp.to_s
      subview UILabel, :lhp_label
      subview UILabel, :lhp, :text => @player.lhp.to_s
      subview UILabel, :llc_label
      subview UILabel, :llc, :text => @player.llc.to_s
    end
  end
end
