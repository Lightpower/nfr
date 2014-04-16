# encoding: UTF-8
module DomainsHelper

  ##
  # Show preview for not allowed tasks
  #
  # Params:
  # - params {Hash}:
  #   - exclude {Array of Integer} - List of ID's of team that should be excluded from the list
  #   - f {ActionView::Helpers::FormBuilder} - builder of form which this select belongs to
  #
  def domain_select(params)
    f = params[:f]
    domains = Domain.all.map {|domain| [domain.full_name, domain.id] }
    if f
      f.select(:domain_id, domains)
    else
      select_tag(:domain_id, domains)
    end
  end
end
