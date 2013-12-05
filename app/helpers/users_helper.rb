module UsersHelper
  
  def link_to_user(user_or_id, show_exclude_div=false)
    user = user_or_id.is_a?(User) ? user_or_id : User.find(user_or_id) rescue nil
    return '' if user.blank?

    ret_val = link_to(user.show_name, user_path(user), class: 'user_link')
    ret_val << ' ' << link_to('X', exclude_user_path(user), class: 'action_button_min') if show_exclude_div

    content_tag(:div, ret_val, class: 'user_link')
  end
end