namespace :app do
  desc 'Generate given number of books'
  task :generate_books, [:num_of_books] => :environment do |t, args|
    raise "Count is not provided" if args.num_of_books.to_i < 1
    1.upto(args.num_of_books.to_i) do |i|
      Book.create(
        title: "Generated book #{i}",
        authors: "Efi code",
        isbn: "978-0-9776-1663-3",
        description: "Hadouken! Shouryuken! Up up down down left right left right B A!"
      )
    end
  end
end