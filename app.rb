require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require 'pry'

require_relative 'models/contact'

get '/' do
  @contacts = Contact.all

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
