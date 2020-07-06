module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'ラクック'
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # 男女それ以外表示メソッド
  def display_sex(number)
    if number == 0
      "男性"
    elsif number == 1
      "女性"
    else
      ""
    end
  end
end
