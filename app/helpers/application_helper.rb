module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    del = ""
    if current_user.admin
      del = button_to('Destroy', item, method: :delete, form: { style: 'display:inline-block;', data: { 'turbo-confirm': 'Are you sure?' } }, class: "btn btn-danger")
    end
    raw("#{edit} #{del}")
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
