namespace BookShop
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using BookShop.Models.Enums;
    using Data;
    using Initializer;

    public class StartUp
    {
        public static void Main()
        {
            using var db = new BookShopContext();
            //DbInitializer.ResetDatabase(db);

            //int input = int.Parse(Console.ReadLine());


            //string getBooksByAgeRestriction = GetBooksByAgeRestriction(db, input);
            //string getGoldenBooks = GetGoldenBooks(db);
            //string getBooksByPrice = GetBooksByPrice(db);
            //string getBooksNotReleasedIN = GetBooksNotReleasedIn(db, year);
            //string getBooksByCategory = GetBooksByCategory(db, categories);
            //string getBooksReleasedBefore = GetBooksReleasedBefore(db, date);
            //string getAuthorNamesEndingIn = GetAuthorNamesEndingIn(db, input);
            //string getBookTitlesContaining = GetBookTitlesContaining(db, input);
            //string getBooksByAuthor = GetBooksByAuthor(db, input);
            //int booksCount = CountBooks(db, input);
            //string countCoppiesByAuthor = CountCopiesByAuthor(db);
            //string getTotalProfitByCategory = GetTotalProfitByCategory(db);
            string getMostRecentBooks = GetMostRecentBooks(db);
            //IncreasePrices(db);
            //int deletedBooksCount = RemoveBooks(db);
            Console.WriteLine(getMostRecentBooks);
        }

        //P02.Age Restriction
        public static string GetBooksByAgeRestriction(BookShopContext context, string command)
        {
            command = command.ToLower();

            var bookTitles = context.Books
                .AsEnumerable()
                .Where(b => b.AgeRestriction.ToString().ToLower() == command)
                .Select(b => b.Title)
                .OrderBy(b => b)
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var title in bookTitles)
            {
                sb.AppendLine(title);
            }

            return sb.ToString().TrimEnd();
        }

        //P03.Golden Books
        public static string GetGoldenBooks(BookShopContext context)
        {
            var bookTitles = context.Books
                .Where(b => b.EditionType == EditionType.Gold && b.Copies < 5000)
                .OrderBy(b => b.BookId)
                .Select(b => b.Title)
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var title in bookTitles)
            {
                sb.AppendLine(title);
            }

            return sb.ToString().TrimEnd();
        }

        //P04.Books by Price
        public static string GetBooksByPrice(BookShopContext context)
        {
            var books = context.Books
                .Where(b => b.Price > 40)
                .Select(b => new
                {
                    b.Title,
                    b.Price
                })
                .OrderByDescending(b => b.Price)
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var book in books)
            {
                sb.AppendLine($"{book.Title} - ${book.Price:f2}");
            }

            return sb.ToString().TrimEnd();
        }

        //P05.Not Released In
        public static string GetBooksNotReleasedIn(BookShopContext context, int year)
        {
            var bookTitles = context.Books
                .Where(b => b.ReleaseDate.Value.Year != year)
                .OrderBy(b => b.BookId)
                .Select(b => b.Title)
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var title in bookTitles)
            {
                sb.AppendLine(title);
            }

            return sb.ToString().TrimEnd();
        }

        //P06.Book Titles by Category
        public static string GetBooksByCategory(BookShopContext context, string input)
        {
            string[] categories = input.ToLower()
                .Split(" ", StringSplitOptions.RemoveEmptyEntries)
                .ToArray();

            List<string> bookTitles = new List<string>();

            var books = context.Books
                .Select(b => new
                {
                    b.Title,
                    Categories = b.BookCategories.Select(bc => bc.Category.Name).ToList()

                })
                .ToList();

            foreach (var category in categories)
            {
                foreach (var book in books)
                {
                    if (book.Categories.Any(c => c.ToLower() == category))
                    {
                        bookTitles.Add(book.Title);
                    }
                }

            }
   
            bookTitles = bookTitles.OrderBy(t => t).ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var title in bookTitles)
            {
                sb.AppendLine(title);
            }

            return sb.ToString().TrimEnd();
        }

        //P07.Released Before Date
        public static string GetBooksReleasedBefore(BookShopContext context, string date)
        {
            DateTime dateTime = DateTime.Parse(date);

            var books = context.Books
                .Where(b => b.ReleaseDate < dateTime)
                .OrderByDescending(b => b.ReleaseDate)
                .Select(b => new
                {
                    Title = b.Title,
                    Edition = b.EditionType.ToString(),
                    Price = b.Price
                })
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var book in books)
            {
                sb.AppendLine($"{book.Title} - {book.Edition} - {book.Price:f2}");
            }

            return sb.ToString().TrimEnd();
        }

        //P08.Author Search
        public static string GetAuthorNamesEndingIn(BookShopContext context, string input)
        {
            var authors = context.Authors
                .Where(a => a.FirstName.EndsWith(input))
                .OrderBy(a => a.FirstName)
                .ThenBy(a => a.LastName)
                .Select(a => new
                {
                    FullName = $"{a.FirstName} {a.LastName}"
                })
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var author in authors)
            {
                sb.AppendLine(author.FullName);
            }

            return sb.ToString().TrimEnd();
        }

        //P09.Book Search
        public static string GetBookTitlesContaining(BookShopContext context, string input)
        {
            input = input.ToLower();

            var bookTitles = context.Books
                .Where(b => b.Title.ToLower().Contains(input))
                .Select(b => b.Title)
                .OrderBy(x => x)
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var title in bookTitles)
            {
                sb.AppendLine(title);
            }

            return sb.ToString().TrimEnd();
        }

        //P10.Book Search by Author
        public static string GetBooksByAuthor(BookShopContext context, string input)
        {
            input = input.ToLower();

            var books = context.Books
                .Where(b => b.Author.LastName.ToLower().StartsWith(input))
                .OrderBy(b => b.BookId)
                .Select(b => new 
                {
                    b.Title,
                    AuthorName = $"{b.Author.FirstName} {b.Author.LastName}"
                })
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var book in books)
            {
                sb.AppendLine($"{book.Title} ({book.AuthorName})");
            }

            return sb.ToString().TrimEnd();
        }

        //P11.Count Books
        public static int CountBooks(BookShopContext context, int lengthCheck)
        {
            var booksCount = context.Books
                .Where(b => b.Title.Length > lengthCheck)
                .Count();

            return booksCount;
        }

        //P12.Total Book Copies
        public static string CountCopiesByAuthor(BookShopContext context)
        {
            var authors = context.Authors
                .Select(a => new
                {
                    FullName = $"{a.FirstName} {a.LastName}",
                    TotalCoppies = a.Books.Select(b => b.Copies).Sum()
                })
                .OrderByDescending(a => a.TotalCoppies)
                .ToList();
                

            StringBuilder sb = new StringBuilder();

            foreach (var author in authors)
            {
                sb.AppendLine($"{author.FullName} - {author.TotalCoppies}");
            }

            return sb.ToString().TrimEnd();
        }

        //P13.Profit by Category
        public static string GetTotalProfitByCategory(BookShopContext context)
        {
            var categories = context.Categories
                .Select(c => new
                {
                    c.Name,
                    TotalProfit = c.CategoryBooks.Select(cb => new
                    {
                        TotalBookPice = cb.Book.Copies * cb.Book.Price
                    })
                    .Sum(x => x.TotalBookPice)
                })
                .OrderByDescending(c => c.TotalProfit)
                .ThenBy(c => c.Name)
                .ToList();

            StringBuilder sb = new StringBuilder();

            foreach (var category in categories)
            {
                sb.AppendLine($"{category.Name} ${category.TotalProfit:f2}");
            }

            return sb.ToString();
        }

        //P14.Most Recent Books
        public static string GetMostRecentBooks(BookShopContext context)
        {
            var books = context.Categories
                .Select(x => new
                {
                    x.Name,
                    Books = x.CategoryBooks
                    .OrderByDescending(x => x.Book.ReleaseDate)
                    .Take(3)
                    .Select(x => new
                    {
                        x.Book.Title,
                        Date = x.Book.ReleaseDate.Value.Year
                    })
                        
                        .ToList()
                })
                .OrderBy(x => x.Name)
                .ToList();

            var sb = new StringBuilder();

            foreach (var category in books)
            {
                sb.AppendLine($"--{category.Name}");

                foreach (var book in category.Books)
                {
                    sb.AppendLine($"{book.Title} ({book.Date})");
                }
            }

            return sb.ToString().TrimEnd();
        }

        //P15.Increase Prices
        public static void IncreasePrices(BookShopContext context)
        {
            var books = context.Books
                .Where(b => b.ReleaseDate.Value.Year < 2010)
                .ToList();

            foreach (var book in books)
            {
                book.Price += 5;
            }

            context.SaveChanges();
        }

        //P16.Remove Books
        public static int RemoveBooks(BookShopContext context)
        {
            var books = context.Books
                .Where(b => b.Copies < 4200)
                .ToList();

            var bookCategories = context.BooksCategories
                .Where(bc => bc.Book.Copies < 4200)
                .ToList();

            context.BooksCategories.RemoveRange(bookCategories);
            context.Books.RemoveRange(books);

            context.SaveChanges();

            return books.Count();
        }


    }
}
