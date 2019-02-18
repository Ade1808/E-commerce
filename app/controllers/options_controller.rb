class OptionsController < InheritedResources::Base

  private

    def option_params
      params.require(:option).permit(:name,:value,:price)
    end
end

