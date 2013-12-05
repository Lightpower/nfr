module IconsHelper

  def pic_link_to_show(url, options={})
    options.merge!(class: 'action_pic')
    link_to (image_tag '/images/pictograms/show.png'), url, options
  end

  def pic_link_to_edit(url, options={})
    options.merge!(class: 'action_pic')
    link_to (image_tag '/images/pictograms/edit.png'), url, options
  end

  def pic_link_to_delete(url, options={})
    options.merge!(class: 'action_pic')
    link_to (image_tag '/images/pictograms/delete.png'), url, options
  end
end
