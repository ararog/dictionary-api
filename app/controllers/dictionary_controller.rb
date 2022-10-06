class DictionaryController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    path = Rails.root.join('storage', 'dictionary.txt')
    file = File.open(path)

    entries = file.readlines.map(&:chomp)
    query = params["q"]

    if query.nil? || query.empty? then
      render :json => [], :status => :bad_request 
    else
      matches = entries.select{|entry| entry.downcase.include? query.downcase}
      render :json => matches
    end
  end

  def add
    word = params["word"]
    path = Rails.root.join('storage', 'dictionary.txt')
    entries = []
    File.open(path,  "r") do |file|
      entries = file.readlines.map(&:chomp)
    end
    
    File.open(path,  "w") do |file|
      if ! entries.include?(word) then
        entries.push(word)
        file.puts(entries.sort_by(&:downcase))
      end

      render :json => { "code": "success" }
    end
  end

  def remove
    word = params["word"]
    path = Rails.root.join('storage', 'dictionary.txt')
    entries = []
    File.open(path,  "r") do |file|
      entries = file.readlines.map(&:chomp)
    end
    
    File.open(path,  "w") do |file|
      if entries.include?(word) then
        entries.delete_if{|w| w == word}
        file.puts(entries.sort_by(&:downcase));
      else
        file.puts(entries)
      end

      render :json => { "code": "success" }
    end
  end
end
