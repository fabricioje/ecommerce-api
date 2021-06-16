module Admin
    class ModelLoadingService
        def initialize(serchable_model, params = {})
            @serchable_model = serchable_model
            @params = params
            @params ||= {}
        end

        def call
            @serchable_model.search_by_name(@params.dig(:search, :name))
                            .order(@params[:order].to_h)
                            .paginate(@params[:page].to_i, @params[:length].to_i)
        end
        
        
    end
end