# frozen_string_literal: true

class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roles, :string, array: true, default: []
    add_index  :users, :roles, using: "gin"

    create_table :competitions, id: :uuid do |t|
      t.text      :description
      t.text      :rating_method
      t.datetime  :open_from
      t.datetime  :open_until
      t.timestamps
    end

    create_table :organizers, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :competition, type: :uuid
      t.timestamps
    end
    add_index :organizers, [:competition_id, :user_id], unique: true

    create_table :tasks, id: :uuid do |t|
      t.text      :description
      t.text      :spec
      t.datetime  :open_from
      t.datetime  :open_until
      t.timestamps
    end

    create_table :challengers, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :task, type: :uuid
      t.timestamps
    end
    add_index :challengers, [:user_id, :task_id], unique: true

    create_table :challenges, id: :uuid do |t|
      t.belongs_to :competition, type: :uuid
      t.belongs_to :task, type: :uuid
      t.timestamps
    end
    add_index :challenges, [:competition_id, :task_id], unique: true

    create_table :solutions, id: :uuid do |t|
      t.belongs_to :competition, type: :uuid
      t.belongs_to :task, type: :uuid
      t.text :code
      t.timestamps
    end
    add_index :solutions, [:competition_id, :task_id], unique: true

    create_table :contestants, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :solution, type: :uuid
      t.integer :rating
      t.timestamps
    end
    add_index :contestants, [:user_id, :solution_id], unique: true

    create_table :invitations, id: :uuid do |t|
      t.belongs_to :creator, type: :uuid
      t.belongs_to :invitee, type: :uuid
      t.belongs_to :entity, type: :uuid, polymorphic: true
      t.boolean  :answer
      t.string   :description
      t.datetime :expires_at
      t.timestamps
    end
  end
end
