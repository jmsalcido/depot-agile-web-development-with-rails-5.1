module ApplicationHelper
  def render_if(condition, record)
    return false unless condition
    render record
  end
end
