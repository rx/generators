require 'bundler'
require 'thor'
require_relative 'templates/resource'

puts 'Loaded Resource Generator'
module Voom
  module Generators
    class Resource < Thor::Group
      include Thor::Actions

      argument :resource, types: :string

      def self.source_root
        __dir__
      end

      # These methods need to be located above the block below where they are used
      no_commands do
        def _r_
          ::Resource.new(resource)
        end
      end

      def commands
        %i(create update delete).each do |cmd|
          create_file File.join(_r_.dirs.commands, _r_.plural.lcase.resource, "#{cmd}.rb"),
                      `#{__dir__}/ribosome #{__dir__}/templates/command_#{cmd}.rb.dna #{resource}`

        end
      end

      def controllers
        create_file File.join(_r_.dirs.controller, "#{_r_.plural.lcase.resource}_controller.rb"),
                    `#{__dir__}/ribosome #{__dir__}/templates/controller.rb.dna #{resource}`
      end

      def db
        create_file File.join(_r_.dirs.db_migrations, "add_#{_r_.plural.lcase.resource}.rb"),
                    `#{__dir__}/ribosome #{__dir__}/templates/db_migration.rb.dna #{resource}`
      end

      def helpers
        create_file File.join(_r_.dirs.helpers, "#{_r_.plural.lcase.resource}.rb"),
                    `#{__dir__}/ribosome #{__dir__}/templates/helper.rb.dna #{resource}`
      end

      def models
        create_file File.join(_r_.dirs.models, "#{_r_.lcase.resource}.rb"),
                    `#{__dir__}/ribosome #{__dir__}/templates/model.rb.dna #{resource}`
      end

      def presenters
        create_file File.join(_r_.dirs.presenters, "#{_r_.plural.lcase.resource}.pom"),
                    `#{__dir__}/ribosome #{__dir__}/templates/presenters/top.pom.dna #{resource}`
        create_file File.join(_r_.dirs.presenters, _r_.plural.lcase.resource, 'cards', "#{_r_.lcase.resource}.pom"),
                            `#{__dir__}/ribosome #{__dir__}/templates/presenters/card.pom.dna #{resource}`
        %i(add edit delete).each do |dlg|
          create_file File.join(_r_.dirs.presenters, _r_.plural.lcase.resource, 'dialogs', "#{dlg}.pom"),
                                    `#{__dir__}/ribosome #{__dir__}/templates/presenters/#{dlg}_dialog.pom.dna #{resource}`
        end
        create_file File.join(_r_.dirs.presenters, _r_.plural.lcase.resource, 'lists', "#{_r_.plural.lcase.resource}.pom"),
                                    `#{__dir__}/ribosome #{__dir__}/templates/presenters/list.pom.dna #{resource}`
      end

      def queries
        create_file File.join(_r_.dirs.queries, "#{_r_.plural.lcase.resource}.rb"),
                    `#{__dir__}/ribosome #{__dir__}/templates/query.rb.dna #{resource}`
      end
    end
  end
end

