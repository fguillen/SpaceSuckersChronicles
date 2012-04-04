ActiveRecord::Schema.define :version => 0 do
  create_table :universe do |t|
    t.integer :tick
    t.string :name
    t.timestamps
  end

  create_table :units do |t|
    t.string  :type
    t.integer :base_id
    t.integer :universe_id
    t.integer :target_id
    t.string  :position
    t.integer :level
    t.integer :production
    t.integer :stuff
    t.integer :capacity
    t.integer :building_ships
    t.integer :life
    t.integer :power
    t.integer :attack
    t.integer :defense
    t.timestamps
  end

  create_table :jobs do |t|
    t.string  :type
    t.integer :unit_id
    t.integer :target_id
    t.string  :callback
    t.integer :ticks_total
    t.integer :ticks_remain
    t.integer :cost
    t.timestamps
  end

  create_table :events do |t|
    t.integer   :tick
    t.string    :family
    t.string    :message
    t.integer   :universe_id
    t.timestamps
  end
end