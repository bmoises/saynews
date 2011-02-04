$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require 'saynews.rb'

url = ARGV.first

url =~ /www.(.*?).com/; 
klass = $1.capitalize
Klass = Kernel.const_get(klass)

a = Klass.new({:uri => url})
a.download

reader = Reader.new(a)

# trap("SIGINT","IGNORE") { 
trap("SIGINT") { 
  reader.done = true
  reader.count += 1 
}

reader.read

