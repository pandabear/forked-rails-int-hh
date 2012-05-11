class BookSweeper < ActionController::Caching::Sweeper
  observe Book

  def after_create(book)
    expire_cache_for(book)
  end

  def after_update(book)
    expire_cache_for(book)
  end

  def after_destroy(book)
    expire_cache_for(book)
  end

  private

  def expire_cache_for(book)
    expire_page(controller: 'books', action: 'index')
  end
end