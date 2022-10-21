class Post < ApplicationRecord

    belongs_to :user, foreign_key: "user_id"

    validates :title, presence: { message: " cannot be empty!" }, length: { minimum: 3 }
    validates :description, presence: { message: " cannot be empty!" }
    validates_inclusion_of :public_flg, presence: { message: " must be choosen!" }, :in => [true, false]

    def self.to_csv
        headers = Constants::POST_CSV_HEADER
        CSV.generate(headers: true) do |csv|
          csv << headers
          all.each do |post|
            csv << headers.map{ |attr| post.send(attr) }
          end
        end
      end

      def self.import(file,current_user)
        begin
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8', row_sep: :auto, header_converters: :symbol) do |row|
            Post.create! row.to_hash.merge(created_user: current_user, user_id: current_user, created_at: Time.now, updated_at: Time.now)
          end
          return true
        rescue => exception
          return exception
        end
      end
end
