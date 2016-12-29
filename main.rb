require "sinatra"
require "sinatra/reloader"
require "active_record"
require "json"

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./jobs.db"
)

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

class Jobs < ActiveRecord::Base
end

get "/" do
  @jobs = Jobs.order("id desc").all
  erb :index
end

post "/new" do
  Jobs.create({
    :title => params[:title],
    :content_overview => params[:content_overview],
    :content_detail => params[:content_detail]
  })
  redirect "/"
end

get "/:id/edit" do
  @jobs = Jobs.find(params[:id])
  erb :edit
end

put "/:id" do
  @jobs = Jobs.find(params[:id])
  if @jobs.update_attributes(params[:jobs])
    redirect "/id=#{@jobs.id}"
  else
    redirect "/"
  end
end

get "/jobs.json" do
  content_type :json
  jobs = Jobs.all
  jobs.to_json
end

post "/delete" do
  Jobs.find(params[:id]).destroy
end