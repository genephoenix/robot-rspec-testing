class Robot

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end


  attr_reader :position, :items, :health
  attr_accessor :equipped_weapon

  def initialize
    @position =[0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    if item.is_a?(Weapon)
      self.equipped_weapon = item
      #equipped weapon is attr_accessor so use self in above line
    end
    if item.weight + items_weight <= 250
      @items << item
      true
    else
      false
    end
  end

  def items_weight
    items.inject(0){|weight, item| weight + item.weight} 
  end

  def wound(amount)
    if amount > health
      @health = 0
    else
      @health -= amount
    end
  end

  def heal(amount)
    if @health + amount >= 100
      @health = 100
    else
      @health += amount
    end
  end

  def attack(enemy)
    if equipped_weapon
      equipped_weapon.hit(enemy)
    else
      other_robot.wound(5)
    end
  end

  def heal!(amount)
    raise RobotAlreadyDeadError, "You are already dead and are unfortunately unable to be revived." if health <= 0
    heal(amount)
  end

  def attack!(enemy)
    raise UnattackableEnemy, "Can't attack if enemy is not a robot" if !enemy.is_a?(Robot)
    attack(enemy)
  end

end

