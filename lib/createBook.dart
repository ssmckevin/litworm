import 'package:flutter/material.dart';
import 'mainBooks.dart'; // To access the Book class

class CreateBookPage extends StatefulWidget {
  const CreateBookPage({super.key});

  @override
  State<CreateBookPage> createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  // Controllers for the new book info
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _genreController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Book Title',
                filled: true, // add text bg,
                fillColor: Colors.white, // color of text bg,
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
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(
                labelText: 'Genre',
                filled: true, // add text bg
                fillColor: Colors.white, // color of text bg
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(
                labelText: 'Year',
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
                // 1. Create the new Book object
                final newBook = Book(
                  title: _titleController.text,
                  author: _authorController.text,
                  genre: _genreController.text,
                  year: int.tryParse(_yearController.text) ?? 2024,
                );

                // 2. Pop and return the new book to the main screen
                Navigator.pop(context, newBook);
              },
              child: const Text('Add to Library'),
            ),
          ],
        ),
      ),
    );
  }
}