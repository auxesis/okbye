#!/usr/bin/env ruby

require 'pathname'
root = Pathname.new(File.expand_path(File.dirname(__FILE__)))

require 'sinatra'
require 'yajl'
require 'haml'
require root.join('lib', 'notmuch')

set :public, root.join('public')
set :views,  root.join('views')

template :layout do 
  File.read('views/layout.haml')
end

get '/thread/:thread_id' do 
  @index = NotMuch::Index.new
  @thread = @index.show("thread:#{params[:thread_id]}")
  haml :thread
end

get '/' do 
  @index = NotMuch::Index.new 
  @query = params[:search].blank? ? "tag:inbox" : params[:search]
  @messages = @index.search(@query)

  haml :index
end

