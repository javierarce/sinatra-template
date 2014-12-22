# encoding: utf-8

require "rubygems"
require './lib/helper'
require "json"

require "net/https"

#if ENV['RACK_ENV'] == 'development'
  #require 'sinatra/reloader'
#end

require 'will_paginate'
require 'will_paginate/data_mapper' 
require 'will_paginate/view_helpers/sinatra'

require "time"
require "data_mapper"
require "logger"
require "open-uri"
require "uri"
require "fileutils"

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/production.db")
DataMapper::Property::String.length(255)

class App < Sinatra::Base

  use Rack::Session::Cookie

  helpers do

    def cycle
      @_cycle ||= reset_cycle
      @_cycle = [@_cycle.pop] + @_cycle
      @_cycle.first
    end

    def reset_cycle
      @_cycle = %w(even odd)
    end

    def protected!
      halt [ 401, 'Not Authorized' ] unless admin? 
    end

    def link_to(text, url, opts={}) attributes = ""
      opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
      "<a href=\"#{url}\"#{attributes}>#{text}</a>"
    end

  end

  configure :development do
    helpers Sinatra::MyHelper
    #register Sinatra::Reloader

    enable :logging, :dump_errors
    set :raise_errors, true
    LOGGER = Logger.new("log/development.log")
  end

  configure :production do
    helpers Sinatra::MyHelper

    enable :logging, :dump_errors
    set :raise_errors, true
    LOGGER = Logger.new("log/production.log")
  end

  set :static, true
  set :root, File.dirname(__FILE__)
  set :public, 'public'

  def self.info(message, options = nil) 
    App.log(:info, message, options)
  end

  def self.error(message, options = nil) 
    App.log(:error, message, options)
  end

  def self.log(kind, message, options = nil)

    if kind == :info
      LOGGER.info message
    elsif kind == :error
      LOGGER.error message
    end

  end

  # Main URL
  get '/' do
    erb :index
  end


end
