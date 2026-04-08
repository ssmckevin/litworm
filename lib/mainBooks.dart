import 'dart:io';

import 'package:flutter/material.dart';
import 'viewBook.dart';
import 'createBook.dart';
import 'profile.dart';

// 1. Book class to hold our data
class Book {
  String title;
  String author;
  String genre;
  int year;
  bool isFavorite;
  bool isRead;
  int currentChapter;
  String? imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.genre,
    required this.year,
    this.isFavorite = false,
    this.isRead = false,
    this.currentChapter = 1,
    this.imageUrl,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Book> myBooks = [
    Book(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', genre: 'Classic', year: 1925),
    Book(title: '1984', author: 'George Orwell', genre: 'Dystopian', year: 1949),
    Book(title: 'The Hobbit', author: 'J.R.R. Tolkien', genre: 'Fantasy', year: 1937),
    Book(title: 'To Kill a Mockingbird', author: 'Harper Lee', genre: 'Classic', year: 1960),
    Book(title: 'The Catcher in the Rye', author: 'J.D. Salinger', genre: 'Classic', year: 1951),
    Book(title: 'Pride and Prejudice', author: 'Jane Austen', genre: 'Romance', year: 1813),
    Book(title: 'Brave New World', author: 'Aldous Huxley', genre: 'Dystopian', year: 1932),
    Book(title: 'Fahrenheit 451', author: 'Ray Bradbury', genre: 'Sci-Fi', year: 1953),
    Book(title: 'The Book Thief', author: 'Markus Zusak', genre: 'Historical', year: 2005),
    Book(title: 'The Alchemist', author: 'Paulo Coelho', genre: 'Adventure', year: 1988),
    Book(title: 'The Hunger Games', author: 'Suzanne Collins', genre: 'YA', year: 2008),
    Book(title: 'Harry Potter', author: 'J.K. Rowling', genre: 'Fantasy', year: 1997),
    Book(title: 'The Da Vinci Code', author: 'Dan Brown', genre: 'Thriller', year: 2003),
    Book(title: 'The Little Prince', author: 'Antoine de Saint-Exupéry', genre: 'Fable', year: 1943),
    Book(title: 'The Chronicles of Narnia', author: 'C.S. Lewis', genre: 'Fantasy', year: 1950),
    Book(title: 'Animal Farm', author: 'George Orwell', genre: 'Satire', year: 1945),
    Book(title: 'The Lord of the Rings', author: 'J.R.R. Tolkien', genre: 'Fantasy', year: 1954),
    Book(title: 'The Shining', author: 'Stephen King', genre: 'Horror', year: 1977),
    Book(title: 'Dune', author: 'Frank Herbert', genre: 'Sci-Fi', year: 1965),
    Book(title: 'Frankenstein', author: 'Mary Shelley', genre: 'Horror', year: 1818),
    Book(title: 'The Handmaid\'s Tale', author: 'Margaret Atwood', genre: 'Dystopian', year: 1985),
    Book(title: 'The Road', author: 'Cormac McCarthy', genre: 'Post-Apocalyptic', year: 2006),
    Book(title: 'Life of Pi', author: 'Yann Martel', genre: 'Adventure', year: 2001),
    Book(title: 'The Martian', author: 'Andy Weir', genre: 'Sci-Fi', year: 2011),
    Book(title: 'Gone Girl', author: 'Gillian Flynn', genre: 'Thriller', year: 2012),
    Book(title: 'The Fault in Our Stars', author: 'John Green', genre: 'YA', year: 2012),
    Book(title: 'Where the Crawdads Sing', author: 'Delia Owens', genre: 'Mystery', year: 2018),
    Book(title: 'Circe', author: 'Madeline Miller', genre: 'Mythology', year: 2018),
    Book(title: 'Project Hail Mary', author: 'Andy Weir', genre: 'Sci-Fi', year: 2021),
    Book(title: 'The Seven Husbands of Evelyn Hugo', author: 'Taylor Jenkins Reid', genre: 'Historical', year: 2017),
    Book(title: 'Normal People', author: 'Sally Rooney', genre: 'Contemporary', year: 2018),
    Book(title: 'Educated', author: 'Tara Westover', genre: 'Memoir', year: 2018),
    Book(title: 'Becoming', author: 'Michelle Obama', genre: 'Biography', year: 2018),
    Book(title: 'Sapiens', author: 'Yuval Noah Harari', genre: 'Non-Fiction', year: 2011),
    Book(title: 'The Silent Patient', author: 'Alex Michaelides', genre: 'Thriller', year: 2019),
    Book(title: 'A Game of Thrones', author: 'George R.R. Martin', genre: 'Fantasy', year: 1996),
    Book(title: 'The Name of the Wind', author: 'Patrick Rothfuss', genre: 'Fantasy', year: 2007),
    Book(title: 'Ready Player One', author: 'Ernest Cline', genre: 'Sci-Fi', year: 2011),
    Book(title: 'The Night Circus', author: 'Erin Morgenstern', genre: 'Fantasy', year: 2011),
    Book(title: 'Little Fires Everywhere', author: 'Celeste Ng', genre: 'Fiction', year: 2017),
    Book(title: 'The Goldfinch', author: 'Donna Tartt', genre: 'Fiction', year: 2013),
    Book(title: 'The Midnight Library', author: 'Matt Haig', genre: 'Fantasy', year: 2020),
    Book(title: 'Atomic Habits', author: 'James Clear', genre: 'Self-Help', year: 2018),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade500,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: myBooks.length,
        itemBuilder: (context, index) {
          final book = myBooks[index];

          return Card(
            child: ListTile(
              // --- LEADING: BOOK LOGO ---
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                // If imageUrl exists, show the file. Otherwise, show nothing (null)
                backgroundImage: book.imageUrl != null
                    ? FileImage(File(book.imageUrl!))
                    : null,
                // If imageUrl is null, show the default book icon
                child: book.imageUrl == null
                    ? const Icon(Icons.book, color: Colors.deepPurple)
                    : null,
              ),
              title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${book.author} • ${book.genre}\nReleased: ${book.year}'),
              isThreeLine: true,
              onTap: () async {
                if (_selectedIndex == 1) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewBookPage(book: book)),
                  );
                  if (result == 'delete') {
                    setState(() { myBooks.removeAt(index); });
                  } else if (result == true) {
                    setState(() {});
                  }
                }
              },
              // --- TRAILING: FIXED OVERFLOW VERSION ---
              trailing: SizedBox(
                width: 60, // Fixed width helps prevent layout shifts
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Chapter Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Ch. ${book.currentChapter}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade900,
                        ),
                      ),
                    ),
                    // Star Toggle with minimal padding
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          book.isFavorite = !book.isFavorite;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, right: 4),
                        child: Icon(
                          book.isFavorite ? Icons.star : Icons.star_border,
                          color: book.isFavorite ? Colors.orange : Colors.grey,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) async {
          if (index == 2) {
            final Book? newBook = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateBookPage()),
            );
            if (newBook != null) {
              setState(() { myBooks.insert(0, newBook); });
            }
          } else if (index == 3) {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
            setState(() { _selectedIndex = 0; });
          } else {
            setState(() { _selectedIndex = index; });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'New Book'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.deepPurple.shade900,
      ),
    );
  }
}