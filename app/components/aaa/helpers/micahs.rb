
module AAA
  module Helpers
    module Micahs
      def micah_id
        context.fetch('micah_id'){context.fetch('id'){
          raise_parameter_validation 'No micah provided!'
        }}
      end

      def micah
        @micah ||= ::AAA::Queries::Micahs.find(id: micah_id)
      end

      def micahs(filter: nil, sort: [created_at: :desc], page: context[:page]||1)
        ::AAA::Queries::Micahs.all(filter: filter, sort: sort, page: page)
      end

      def micah_fields(micah=nil)
        hidden_field name: :id do
          value micah.id
        end if micah
        text_field name: :name do
          label 'Name'
          value micah.name if micah
        end
      end
    end
  end
end
