module Searchable
  extend ActiveSupport::Concern

  private

  def search_params
    params_q = params[:q]&.delete_if { |key, value| value.blank? }

    character_enums = Character.defined_enums
    character_enums.each do |enum_name, _|
      key = "character_#{enum_name}_eq"
      if params_q&.key?(key)
        enum_value = Character.send(enum_name.pluralize)[params_q[key]]
        params_q[key] = enum_value unless enum_value.nil?
      end
    end

    params_q
  end
end