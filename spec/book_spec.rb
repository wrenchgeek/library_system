require('spec_helper')

describe(Book) do
  describe('#title') do
    it('returns the title of the book')do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => 0})
      expect(test_book.title()).to(eq("Welcome to the neighborhood"))
    end
  end
  describe('#author') do
    it('returns the author of the book')do
    test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => 0})
      expect(test_book.author()).to(eq("Mr. Rogers"))
    end
  end
  describe('#id') do
    it('returns the id of the book')do
    test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => 1, :copy_id => 0})
      expect(test_book.id()).to(eq(1))
    end
  end
  describe('.all') do
    it('returns all the books') do
    expect(Book.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('saves the book to database') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => 0})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end
  describe('.find_by_id') do
    it('finds the book by its id') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => 0})
      test_book.save()
      expect(Book.find_by_id(test_book.id())).to(eq(test_book))
    end
  end
  describe('.find_by_title') do
    it('finds the book by its title') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => 0})
      test_book.save()
      expect(Book.find_by_title(test_book.title())).to(eq(test_book))
    end
  end
  describe('.find_by_author') do
    it('finds the book by its author') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => 0})
      test_book.save()
      expect(Book.find_by_author(test_book.author())).to(eq(test_book))
    end
  end
  describe('#update') do
    it('lets you update books in the database') do
      test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => nil, :copy_id => 0})
      test_book.save()
      test_book.update({:title => "The giving tree"})
      expect(test_book.title()).to(eq("The giving tree"))
      test_book.update({:author => "Dr. Suess"})
      expect(test_book.author()).to(eq("Dr. Suess"))
    end
  end
  describe('#delete') do
    it('lets you delete a book from the database') do
      test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => nil, :copy_id => 0})
      test_book.save()
      test_book.delete()
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#all_copies') do
    it('creates an array containing how many copies are on hand') do
      test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => nil, :copy_id => 0})
      test_book.save()
      2.times() do
        test_book.make_copy()
      end
      expect(test_book.all_copies()).to(eq([test_book, test_book]))
    end
  end
  describe('.overdue') do
    it('returns an array of overdue books') do
      test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => nil, :copy_id => 0})
      test_book.save()
      test_book.make_copy()
      test_patron = Patron.new({:name => "Samnson", :id => nil})
      test_patron.save()
      test_patron.check_out(test_book)
      DB.exec("UPDATE check_out SET due = '4-4-2014' where patron_id = #{test_patron.id()};")
      expect(Book.overdue()).to(eq([test_book]))
    end
  end

end
