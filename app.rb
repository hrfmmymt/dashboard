# coding:utf-8
require "sinatra"
require "sinatra/reloader"
require "active_record"
require "json"

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "sqlite3:db/development.db")

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

class Jobs < ActiveRecord::Base
end

get "/" do
  @title = "Dashboard"
  @jobs = Jobs.order("id desc").all
  erb :index
end

post "/new" do
  Jobs.create({
    :title => params[:title],
    :content_overview => params[:content_overview],
    :content_detail => params[:content_detail],
    :device => params[:device],
    :langs => params[:langs],
    :tools => params[:tools],
    :dev_process => params[:devs]
  })
  redirect "/"
end

get "/:id/edit" do
  @jobs = Jobs.find(params[:id])
  erb :edit
end

put "/:id/edit" do
  @jobs = Jobs.find(params[:id])
  @jobs.update({
    :title => params[:title],
    :content_overview => params[:content_overview],
    :content_detail => params[:content_detail],
    :device => params[:device],
    :langs => params[:langs],
    :tools => params[:tools],
    :dev_process => params[:devs]
  })
  redirect "/"
end

get "/jobs.json" do
  content_type :json
  jobs = Jobs.all
  jobs.to_json
end

post "/delete" do
  Jobs.find(params[:id]).destroy
end
