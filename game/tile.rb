
class Tile
  attr_reader :position, :bombed, :number, :options
  attr_accessor :flagged, :revealed

  def initialize(name, options = {})
    default = { :bombed => false, :number => 0 }

    @name = name
    @options = default.merge(options)
    @flagged = false
    @revealed = false
  end
end

