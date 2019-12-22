class UserBooksFacade
  def initialize(params)
    @title = params['title']
    @author = params['author']
    @user_id = params['user_id']
    @guten_id = params['guten_id']
  end

  def can_create_or_add_book?
    Book.create_or_add_book(@guten_id, @title, @author)
  end

  def checkout_book(book)
    return false if UserBook.user_checked_out_book?(book.id, @user_id)
    UserBook.checkout_book(book.id, @user_id)
  end
end
