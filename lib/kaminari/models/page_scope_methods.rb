module Kaminari
  module PageScopeMethods
    extend ActiveSupport::Concern
    module InstanceMethods
      # Specify the <tt>per_page</tt> value for the preceding <tt>page</tt> scope
      #   Model.page(3).per(10)
      def per(num)
        if (n = num.to_i) <= 0
          self
        else
          limit(n).offset(offset_value / limit_value * n)
        end
      end

      def shift(num)
        offset(offset_value + num.to_i)
      end

      # Total number of pages
      def num_pages
        (total_count.to_f / limit_value).ceil
      end

      # Current page number
      def current_page
        (offset_value / limit_value) + 1
      end

      # First page of the collection ?
      def first_page?
        current_page == 1
      end

      # Last page of the collection?
      def last_page?
        current_page >= num_pages
      end

      # Set the name of the column to use during .count()
      # Setting this will cause call to count to use: count(:id, :distinct => true)
      # Example: User.page(3).per(5).use_distinct(:id)
      def use_distinct(column)
        @distinct_column = column
        self
      end
    end
  end
end
