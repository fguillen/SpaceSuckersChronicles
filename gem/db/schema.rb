ActiveRecord::Schema.define :version => 0 do
  create_table :universes do |t|

  end

  create_table :units do |t|
    t.string  :type
    t.integer :base_id
    t.integer :target_id
    t.string  :position
    t.integer :level
    t.integer :production
    t.integer :stuff
    t.integer :capacity
    t.integer :building_ships
    t.integer :live
    t.integer :power
    t.integer :attack
    t.integer :defense
  end

  create_table :jobs do |t|
    t.string  :type
    t.integer :unit_id
    t.integer :target_id
    t.string  :callback
    t.integer :ticks_total
    t.integer :ticks_remain
  end
end