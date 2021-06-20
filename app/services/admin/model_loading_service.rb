module Admin
    class ModelLoadingService
        attr_accessor :records, :pagination
        
        def initialize(serchable_model, params = {})
            @serchable_model = serchable_model
            @params = params || {}
            @records = []
            @pagination = { page: @params[:page].to_i, length: @params[:length].to_i  }
        end

        def call
            fix_pagination_values
            filtered = @serchable_model.search_by_name(@params.dig(:search, :name))
            @records = filtered.order(@params[:order].to_h)
                               .paginate(@pagination[:page], @pagination[:length])

            total_pages = (filtered.count / @pagination[:length].to_f).ceil
            @pagination.merge!(total: filtered.count, total_pages: total_pages)
        end


        private

        def fix_pagination_values
            @pagination[:page] = @serchable_model.model::DEFAULT_PAGE if @pagination[:page] <= 0
            @pagination[:length] = @serchable_model.model::MAX_PER_PAGE if @pagination[:length] <= 0
        end
        
    end
end