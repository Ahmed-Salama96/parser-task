#!/usr/bin/ruby -w

class Parser
  def initialize(args)
    @args = args
    validate_args
    @file = args[0]
  end

  def validate_args
    if !@args || @args.length < 1
      raise "arguments not provided!"
    end

    if @args.length > 1
      raise "extra arguments found!"
    end

    accepted_formats = [".log"]
    unless accepted_formats.include? File.extname(@args[0])
      raise "sorry currently we are accepting .log formats only!"
    end
  end

  def get_webpages_views
    pages_hash = {}

    File.foreach(@file) do |line|
      page = line.split(' ')[0]

      if pages_hash.keys.include?(page)
        pages_hash[page] += 1
      else
        pages_hash[page] = 1
      end
    end

    pages_hash.sort_by{ |k, v| v }.reverse.to_h
  end
end

if __FILE__ == $0
  parser = Parser.new(ARGV)
  webpages_views = parser.get_webpages_views

  puts webpages_views
end

