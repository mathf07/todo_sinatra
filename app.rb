require "sinatra"
require "sinatra/activerecord"

ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3' ,
	:database => 'todos.sqlite3.db'
)

class Todo < ActiveRecord::Base

	ActiveRecord::Base.default_timezone = :local

end

get "/" do
	@todos = Todo.order("created_at DESC")
	erb :"todo/index"
end  

get "/todos/new" do
	@title = "Nouveau Todo"
	@todo = Todo.new
	erb :"todo/new"
end

post "/todos" do
	todo = Todo.new(params[:todo])
	if todo.save
		redirect "/"
	else
		erb :"todo/new"
	end
end

get "/todos/:id" do
	@todo = Todo.find(params[:id])
	@title = "confirm"
	erb :"todo/show"
end

get "/todos/edit/:id" do
	@todo = Todo.find(params[:id])
	@title = "Formulaire edition"
	erb :"todo/edit"
end

put "/todos/:id" do
   @todo = Todo.find(params[:id])
   @todo.completed_at = params[:todo][:done] ?  Time.now : nil
   if @todo.update_attributes(params[:todo])
     redirect "/"
   else
     erb :"todo/edit"
   end
 end

get "/todos/delete/:id" do
	@todo = Todo.find(params[:id])
	erb :"todo/delete"
end

delete "/todos/delete/:id" do
  if params.has_key?("ok")
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect "/"
  else
    redirect "/"
  end
end

def format_date(time)
   	time.strftime("%d/%m/%Y") unless time==nil
end 



 
