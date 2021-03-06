# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180313190125) do

  create_table "assigned_projects_participants", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "assigned_projects_participants", ["project_id"], name: "index_assigned_projects_participants_on_project_id"
  add_index "assigned_projects_participants", ["user_id"], name: "index_assigned_projects_participants_on_user_id"

  create_table "assigned_tasks_assignees", id: false, force: :cascade do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  add_index "assigned_tasks_assignees", ["task_id"], name: "index_assigned_tasks_assignees_on_task_id"
  add_index "assigned_tasks_assignees", ["user_id"], name: "index_assigned_tasks_assignees_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.boolean  "deleted",    default: false
    t.boolean  "edit",       default: false
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "comments", ["task_id"], name: "index_comments_on_task_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "hours", force: :cascade do |t|
    t.float    "work_time"
    t.text     "explanation"
    t.boolean  "deleted",     default: false
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "hours", ["task_id"], name: "index_hours_on_task_id"
  add_index "hours", ["user_id"], name: "index_hours_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "deleted",     default: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "role_maps", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "role_maps", ["role_id"], name: "index_role_maps_on_role_id"
  add_index "role_maps", ["user_id"], name: "index_role_maps_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.string   "assignment_status"
    t.integer  "assignment_confirmed_user_id"
    t.boolean  "deleted",                      default: false
    t.integer  "parent_task_id"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "task_type_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "tasks", ["parent_task_id"], name: "index_tasks_on_parent_task_id"
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"
  add_index "tasks", ["task_type_id"], name: "index_tasks_on_task_type_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "activated",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
  end

end
