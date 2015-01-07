require "fogpry"
require "yaml"
require "pry"
require "fog"

module Fogpry
  class Fogpry

    attr_reader :profiles, :profile, :connection

    def initialize
      begin
        @profiles = YAML.load_file(File.expand_path("~/.fogpry"))
      rescue
        @profiles = {}
      end
      @profile = nil
      @connection = nil
    end

    def list_profiles
      @profiles.keys.each do |p|
        puts p
      end
    end

    def connect(profile)
      @profile = profile
      @connection = Fog::Compute.new(symbolize(@profiles[@profile]))
    end

    protected

    def symbolize(hash)
      hash.keys.each do |key|
        hash[(key.to_sym rescue key) || key] = hash.delete(key)
        return hash
      end
    end
  end
end
