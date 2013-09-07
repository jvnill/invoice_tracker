class Ability
  include CanCan::Ability

  def initialize(user)
    user ? can(:manage, :all) : cannot(:manage, :all)
  end
end
