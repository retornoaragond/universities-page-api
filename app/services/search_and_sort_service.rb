# frozen_string_literal: true

# This service is used to search and sort records in a given scope
class SearchAndSortService

  def initialize(scope, params, searchable_columns, order_columns)
    @scope = scope
    @params = params
    @searchable_columns = searchable_columns
    @order_columns = order_columns
  end

  def call
    scoped = apply_search(@scope)
    apply_sort(scoped)
  end

  private

  def apply_search(scope)
    return scope if @params[:search].blank?

    search_query = "%#{@params[:search]}%"
    conditions = @searchable_columns.map { |column| "#{column} ILIKE :search" }.join(" OR ")

    scope.where(conditions, search: search_query)
  end

  def apply_sort(scope)
    return scope unless @params[:sort_by].present? && @params[:sort_order].present?

    sort_column = @params[:sort_by]
    sort_order = @params[:sort_order].downcase

    if @order_columns.include?(sort_column) && %w[asc desc].include?(sort_order)
      scope.order("#{sort_column} #{sort_order}")
    else
      scope
    end
  end

end
