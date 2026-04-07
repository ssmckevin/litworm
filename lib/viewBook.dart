import 'package:flutter/material.dart';
import 'mainBooks.dart'; // Import this to access the Book class

class ViewBookPage extends StatefulWidget {
  final Book book;

  const ViewBookPage({super.key, required this.book});

  @override
  State<ViewBookPage> createState() => _ViewBookPageState();
}

class _ViewBookPageState extends State<ViewBookPage> {
  // Controllers to handle the text input
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _chapterController;
  late TextEditingController _yearController;   // New Controller
  late TextEditingController _genreController;  // New Controller

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _chapterController = TextEditingController(text: widget.book.currentChapter.toString());
    _yearController = TextEditingController(text: widget.book.year.toString()); // Initialize Year
    _genreController = TextEditingController(text: widget.book.genre);          // Initialize Genre
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _chapterController.dispose();
    _yearController.dispose();  // Clean up
    _genreController.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView( // Added this so the keyboard doesn't cover fields
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Book Title',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Author',
                filled: true, // add text bg
                fillColor: Colors.white, // color of text bg
              ),
            ),
            const SizedBox(height: 10),
            // --- NEW GENRE FIELD ---
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(
                labelText: 'Genre',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // --- NEW YEAR FIELD ---
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(
                labelText: 'Release Year',
                filled: true, // add text bg
                fillColor: Colors.white, // color of text bg
              ),
              keyboardType: TextInputType.number, // Shows number pad
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _chapterController,
              decoration: const InputDecoration(
                labelText: 'Current Chapter',
                filled: true, // add text bg
                fillColor: Colors.white, // color of text bg
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  // Save all changes back to the book object
                  widget.book.title = _titleController.text;
                  widget.book.author = _authorController.text;
                  widget.book.genre = _genreController.text;

                  // Convert text back to numbers safely
                  widget.book.currentChapter = int.tryParse(_chapterController.text) ?? 0;
                  widget.book.year = int.tryParse(_yearController.text) ?? 0;
                });

                // Go back and tell mainBooks.dart to refresh the list
                Navigator.pop(context, true);
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 12), // Space between buttons
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: Colors.red, // Makes the text red
              ),
              onPressed: () {
                // Show a confirmation dialog before deleting
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Book"),
                      content: const Text("Are you sure you want to remove this book from your library?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), // Close dialog
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            // Pop the ViewBookPage and return 'delete' as the result
                            Navigator.pop(context, 'delete');
                          },
                          child: const Text("Delete", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Delete Book'),
            ),
          ],
        ),
      ),
    );
  }
}