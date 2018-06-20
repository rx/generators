module AAA
  module Queries
    class Micahs
      def self.all(filter:nil, sort: :created_at, page: 1)
        scope = Micah.order(sort)
        scope = scope.page(page) unless page==:no_paging
        scope.where(filter)
      end

      def self.find(id:)
        Micah.find_by!(id: id)
      end
    end
  end
end
