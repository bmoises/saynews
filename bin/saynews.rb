$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require 'saynews.rb'

a = NewYorker.new({:uri => ARGV.first})
a.download

reader = Reader.new(a)

# trap("SIGINT","IGNORE") { 
trap("SIGINT") { 
  reader.done = true 
}
reader.read

