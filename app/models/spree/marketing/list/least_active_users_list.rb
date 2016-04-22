module Spree
  module Marketing
    class LeastActiveUsersList < List

      # Constants
      MAXIMUM_PAGE_EVENT_COUNT = 5

      def user_ids
        Spree::PageEvent.group(:actor_id)
                        .having("COUNT(spree.page_events.id) < :maximum_count", MAXIMUM_PAGE_EVENT_COUNT)
                        .of_registered_users
                        .where("created_at >= :time_frame", time_frame: computed_time)
                        .where(actor_type: Spree.user_class)
                        .order("COUNT(spree_orders.id)")
                        .pluck(:actor_id)
      end
    end
  end
end