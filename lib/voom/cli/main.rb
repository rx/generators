require 'thor'
require 'voom/cli/version'
require "dry/inflector"

Dir.glob(File.join(__dir__ ,'..','generators','*.rb'), &method(:require))

module Voom
  module CLI
    # The command line interface for voom
    class Main < Thor
      desc 'version', 'Display version'
      map %w(-v --version) => :version

      def version
        say Voom::CLI::VERSION
      end

      # These methods need to be located above the block below where they are used
      no_commands do
        def inflector
          Dry::Inflector.new
        end
      end
      
      desc 'generate [resource] mycomponent/myresource', 'Runs a generator'

      def generate(generator, *args)
        puts generator
        puts args.inspect
        puts "Voom::Generators::#{inflector.classify(generator)}"
        inflector.constantize("Voom::Generators::#{inflector.classify(generator)}").start(args)
      end
    end
  end
end
