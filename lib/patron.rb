class Patron

attr_reader(:name, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes. fetch(:id).to_i()
  end
  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patron;")
    patrons = []
    returned_patrons.each() do |patron|
      @name = patron.fetch('name')
      @id = patron.fetch('id')
      patrons.push(Patron.new({:name => @name, :id => @id}))
    end
  patrons
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO patron (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().to_i().==(another_patron.id().to_i()))
  end
  define_singleton_method(:find) do |id|
    @id = id
    results = DB.exec("SELECT * FROM patron WHERE id = #{@id}")
    @name = results.first().fetch('name')
    Patron.new({:name => @name, :id => @id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE patron SET name = '#{@name}' WHERE id = #{@id}")
  end
  define_method(:delete) do
    DB.exec("DELETE FROM patron WHERE id = #{self.id};")
  end
  define_method(:check_out) do |book|
    if book.copies().empty?()
    else
      copy = book.copies()[0]
      DB.exec("DELETE FROM copies WHERE id = #{copy.id()};")
      # copies = book.copies() - 1
      # DB.exec("DELETE FROM copies WHERE book_id = '#{book.id()}'")
      # copies.times() do |copy|
      #   DB.exec("INSERT INTO copies (book_id) VALUES (#{book.id})")
      # end


      DB.exec("INSERT INTO check_out (patron_id, copies_id) VALUES ('#{self.id}', )")
    end
  end
end
