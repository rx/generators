require "dry/inflector"

class Resource
  def initialize(resource=ARGV[0])
    classified = /::/ =~ resource ? resource : inflector.classify(resource)
    @resource = classified.split('::')
  end

  def component
    @resource.first
  end

  def resource
    @resource.last
  end

  def modules
    @resource[0..-2]
  end

  def command
    '::'+modules.join('::')+'::Commands::'+plural.resource
  end

  def query
    '::'+modules.join('::')+'::Queries::'+plural.resource
  end

  class Dir
    def initialize(resource)
      @resource = resource
    end

    def component
      File.join('app', 'components', @resource.lcase.component)
    end

    def controller
      File.join(component, 'controllers')
    end

    def commands
      File.join(component, 'commands')
    end
    
    def db_migrations
      File.join(component, 'db', 'migrate')
    end

    def helpers
      File.join(component, 'helpers')
    end

    def models
      File.join(component, 'models')
    end

    def presenters
      File.join(component, 'presenters')
    end

    def queries
      File.join(component, 'queries')
    end
  end

  def dirs
    Dir.new(self)
  end

  class LCase
    def initialize(resource)
      @resource = resource
    end

    def resource
      @resource.resource.downcase
    end

    def component
      @resource.component.downcase
    end
  end

  def lcase(resource=self)
    LCase.new(resource)
  end

  class Plural
    def initialize(resource)
      @resource = resource
    end

    def resource
      inflector.pluralize(@resource.resource)
    end

    def lcase(resource=self)
      LCase.new(resource)
    end

    private
    def inflector
      Dry::Inflector.new
    end
  end

  def plural(resource=self)
    Plural.new(resource)
  end

  class Humanize
      def initialize(resource)
        @resource = resource
      end

      def resource
        inflector.humanize(@resource.resource)
      end
      
      private
      def inflector
        Dry::Inflector.new
      end
    end

    def humanize(resource=self)
      Humanize.new(resource)
    end
end