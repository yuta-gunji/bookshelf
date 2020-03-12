# frozen_string_literal: true

module SystemSpecHelper
  def login_as(user, remember: '1')
    visit login_path
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'password'
    if remember == '1'
      check User.human_attribute_name(:remember_me)
    elsif remember == '0'
      uncheck User.human_attribute_name(:remember_me)
    end
    click_button I18n.t(:login)
  end

  def login!
    user = create(:user)
    login_as(user)
  end

  def logout
    click_link I18n.t(:logout)
  end

  def add_to_bookshelf(bookshelf, book)
    bookshelf.books << book
  end
end
