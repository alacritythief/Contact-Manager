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

post '/search' do
  first = params['firstname']
  last = params['lastname']
  @results = Contact.all.where("first_name like ? and last_name like?", "%#{first}%", "%#{last}%")
  erb :search
end
