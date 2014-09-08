require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require_relative 'models/contact'

get '/' do
  @page = (params[:page]).to_i

  if @page == nil || @page < 1
    @page = 1
  end

  @contacts = Contact.all.limit(3).offset(@page * 3 - 3)
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.all.find(params[:id])
  erb :show
end

get '/create' do
  erb :create
end

get '/error' do
  erb :error
end

post '/create' do
  first = params['firstname']
  last = params['lastname']
  phone = params['phone']

  if first == "" || last == "" || phone == ""
    redirect '/error'
  else
    new_contact = Contact.create(first_name: "#{first}", last_name: "#{last}", phone_number: "#{phone}")
    new_contact.save
    redirect '/'
  end
end

post '/search' do
  first = params['firstname']
  last = params['lastname']
  @results = Contact.all.where("first_name like ? and last_name like?", "%#{first}%", "%#{last}%")
  erb :search
end
