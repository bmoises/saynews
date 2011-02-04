require 'rubygems'
require 'mechanize'
require 'digest/md5'
require 'pp'
require 'nokogiri'

$:.unshift File.join(File.dirname(__FILE__),'..')
require 'lib/downloader.rb'
require 'lib/reader.rb'
require 'lib/string.rb'

Dir["#{File.join(File.dirname(__FILE__),'sites',"*.rb")}"].collect{|file| require file }

SAYNEWS_CACHE = File.join(File.dirname(__FILE__),'..','cache')

