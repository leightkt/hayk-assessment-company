class Company
    attr_accessor :name, :num_of_emp
    attr_reader :id

    def initialize(id=nil, name, num_of_emp)
        @id = id
        @name = name
        @num_of_emp = num_of_emp
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS companies
        (id INTEGER PRIMARY KEY,
        name TEXT,
        num_of_emp INTEGER)
        SQL

        DB[:conn].execute(sql)
    end

    def self.drop_table
        sql <<-SQL
        DROP TABLE companies
        SQL

        DB[:conn].execute(sql)
    end

    def self.create(name, num_of_emp)
        company = self.new(name, num_of_emp)
        company.save
        company
    end

    def save
        if self.id
            self.update
        else
        sql = <<-SQL
        INSERT INTO companies
        (name, num_of_emp)
        VALUES(?, ?)
        SQL

        DB[:conn].execute(sql, self.name, self.num_of_emp)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM companies")[0][0]
        end
    end

    def self.new_from_db(row)
        id = row[0]
        name = row[1]
        num_of_emp = row[2]
        new_company = self.new(id, name, num_of_emp)
        new_company
    end

    def self.find_by_name(name)
        sql = <<-SQL
        SELECT * FROM companies
        WHERE name = ?
        LIMIT 1
        SQL

        DB[:conn].execute(sql, name).map do |row|
            self.new_from_db(row)
        end.first
    end

    def self.all
        sql = <<-SQL
        SELECT * FROM companies
        SQL

        DB[:conn].execute(sql).map do |row|
            self.new_from_db(row)
        end
    end

    def update
        sql = <<-SQL
        UPDATE companies SET
        name = ?, num_of_emp = ?
        WHERE id = ?
        SQL

        DB[:conn].execute(sql, self.name, self.num_of_emp, self.id)
    end

    def delete
        sql = <<-SQL
        DELETE FROM companies
        WHERE id = ?
        SQL

        DB[:conn].execute(sql, self.id)
    end
end