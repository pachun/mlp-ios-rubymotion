class InvitedLeaguePlayer
  attr_accessor :id, :name, :invited, :accepted_invite

  def self.from_hash(invite_hash)
    invite = InvitedLeaguePlayer.new
    invite.id = invite_hash[:id] if invite_hash.has_key?(:id)
    invite.name = invite_hash[:name] if invite_hash.has_key?(:name)
    invite.invited = invite_hash[:invited] if invite_hash.has_key?(:invited)
    invite.accepted_at = invite_hash[:accepted_at] if invite_hash.has_key?(:accepted_at)
    invite
  end
end
