class Connection

  def self.conn
    @@conn = PG::Connection.new(
      host: 'localhost',
      dbname: 'contacts',
      user: 'development',
      password: 'development')
  end

  def conn
    @@conn
  end

end