module ApplicationHelper
  def render_if(condition, record, args)
    return false unless condition
    render record, args
  end
end
