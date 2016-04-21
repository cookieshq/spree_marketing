module Spree
  module Reports
    class TopProducts < Base

      def query
        Spree::InventoryUnit.includes(variant: :product)
                            .group("spree_variants.id")
                            .order("COUNT(spree_inventory_units.id) DESC")
                            .references(:variant)
                            .limit(@count)
                            .map { |inventory_unit| inventory_unit.variant.product }
      end

    end
  end
end
