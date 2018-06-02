# frozen_string_literal: true

class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roles, :string, array: true, default: []
    add_index  :users, :roles, using: "gin"

    create_table :challenges, id: :uuid do |t|
      t.belongs_to :rating_aggregator, type: :uuid

      t.text      :description
      t.datetime  :open_from
      t.datetime  :open_until

      t.timestamps
    end

    create_table :tasks, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :challenge, type: :uuid
      t.belongs_to :rating_method, type: :uuid

      t.text      :description
      t.datetime  :open_from
      t.datetime  :open_until

      t.timestamps
    end

    create_table :solutions, id: :uuid do |t|
      t.belongs_to :task, type: :uuid

      t.text     :code
      t.integer  :rating

      t.timestamps
    end

    create_table :creations, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :challenge, type: :uuid

      t.timestamps
    end
    add_index :creations, [:challenge_id, :user_id], unique: true

    create_table :contestants, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :solution, type: :uuid

      t.timestamps
    end
    add_index :contestants, [:user_id, :solution_id], unique: true

    create_table :requirements, id: :uuid do |t|
      t.belongs_to :task, type: :uuid
      t.belongs_to :spec, type: :uuid

      t.timestamps
    end
    add_index :requirements, [:task_id, :spec_id], unique: true

    create_table :specs, id: :uuid do |t|
      t.belongs_to :user, type: :uuid

      t.text :code

      t.timestamps
    end

    create_table :rating_aggregators, id: :uuid do |t|
      t.belongs_to :user, type: :uuid

      t.text :code
      t.text :description

      t.timestamps
    end

    create_table :rating_methods, id: :uuid do |t|
      t.belongs_to :user, type: :uuid

      t.text :code
      t.text :description

      t.timestamps
    end

    create_table :invitations, id: :uuid do |t|
      t.belongs_to :creator, type: :uuid
      t.belongs_to :invitee, type: :uuid
      t.belongs_to :entity, type: :uuid, polymorphic: true

      t.boolean  :answer
      t.string   :description
      t.datetime :expires_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
