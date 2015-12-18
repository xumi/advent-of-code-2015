class Grid

  def initialize(source, corners=false)
    # The flag saying if we have to force the corners to stay on or not (question 2)
    @as_forced_corners = corners
    # We assign our grid
    self.grid = source
  end

  # When we update our grid
  def grid=(grid)
    # We save it
    @grid = grid
    # If we need to force the corners then we override them here
    self.force_corners! if @as_forced_corners
    # We return the instance itself
    self
  end

  def next
    # We create a temporary object to hold the next version of the grid
    next_grid = []
    @grid.each_with_index do |line, x|
      next_grid[x] = []
      line.each_with_index do |state, y|
        # We get the next light state and save it
        next_grid[x][y] = get_next_state_at(x,y)
      end
    end
    # We return the new grid
    next_grid
  end

  def next!
    # We get the next grid and replace the current one with it
    self.grid = self.next
    # We return the instance itself
    self
  end

  def get_next_state_at(x,y)
    # We get the power of a position (based on the neighbors)
    power = self.get_power_at(x,y)
    # If thie light is on
    if self.is_powered_at?(x,y)
      # If the power is 2 or 3 it stays on, otherwise we turn it off
      value = [2,3].include?(power) ? 1 : 0
    # If thie light is off
    else
      # If the power is 3 it stays off, otherwise we turn it on
      value = [3].include?(power) ? 1 : 0
    end
    # We return the new value
    value
  end

  def get_power_at(x,y)
    power = 0
    power += 1 if self.is_powered_at?(x,y-1)    # TOP
    power += 1 if self.is_powered_at?(x,y+1)    # BOTTOM
    power += 1 if self.is_powered_at?(x+1,y)    # RIGHT
    power += 1 if self.is_powered_at?(x+1,y+1)  # BOTTOM RIGHT
    power += 1 if self.is_powered_at?(x+1,y-1)  # BOTTOM RIGHT
    power += 1 if self.is_powered_at?(x-1,y)    # LEFT
    power += 1 if self.is_powered_at?(x-1,y+1)  # BOTTOM LEFT
    power += 1 if self.is_powered_at?(x-1,y-1)  # TOP LEFT
    power
  end

  def is_powered_at?(x,y)
    # We validate that the coordinates are not off grid
    return false if x < 0 || x >= @grid.length
    return false if y < 0 || y >= @grid.length
    # We return the state of this light
    @grid[x][y] == 1
  end

  def isnt_powered_at?(x,y)
    # Because I love sugar.
    !is_powered_at?(x,y)
  end

  def force_corners!
    last_x = @grid.length-1
    last_y = @grid.first.length-1
    @grid[0][0]           = 1 # TOP LEFT
    @grid[0][last_y]      = 1 # TOP RIGHT
    @grid[last_x][0]      = 1 # BOTTOM LEFT
    @grid[last_x][last_y] = 1 # BOTTOM RIGHT
    self
  end

  def power
    # We calculate the power of the grid
    count = 0
    # For each line
    @grid.each do |line|
      # We add the sum of all the line to the count
      count += line.inject(:+)
    end
    # We return the grid power
    count
  end

  def to_i
    self.power
  end

  def to_s
    @grid.map{|line| line.join(',')}.join("\n")
  end

end