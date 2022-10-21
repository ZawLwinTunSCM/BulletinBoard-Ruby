module PostsHelper
    
    def self.check_header(header,csv_file)
        header = CSV.open(csv_file, 'r', encoding:'iso-8859-1:utf-8') { |csv| csv.first }
        error = "" 
        if header.size != header.size 
          error= "WRONG_COLUMN"
        else
          (0..header.size-1).each do |col_name|
            if (header[col_name] == nil || header[col_name].downcase != header[col_name].downcase)
              error = "WRONG_HEADER"
            end
          end
        end
        return error
      end

end
