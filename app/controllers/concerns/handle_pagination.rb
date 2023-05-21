# Paginable concerns is a module that provides pagination functionality
# for controllers. It automatically gives the paginate method in every controller
# which includes this concern.
module HandlePagination
  # extend ActiveSupport::Concern

  def paginate(relation, order_field, page, per_page, order_direction)
    default_page = 1
    default_per_page = 6
    default_order_direction = :desc

    page ||= default_page
    per_page ||= default_per_page
    order_direction ||= default_order_direction

    relation
      .limit(page)
      .per(per_page)
      .order(order_field => order_direction)
  end
end