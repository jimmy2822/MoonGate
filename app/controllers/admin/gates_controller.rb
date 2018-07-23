module Admin
    class GatesController < Admin::BaseController
        before_action :find_gate_id , only: [:destroy]

        def destroy
            @gate.destroy
            redirect_to '/admin/manage_gates'
        end
        
        private
        def find_gate_id
            @gate = Gate.find(params[:id])
        end
    end
end