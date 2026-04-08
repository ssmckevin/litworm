import 'package:flutter/material.dart';
import 'dart:io'; // Required for File
import 'package:image_picker/image_picker.dart'; // Required for picking images
import 'mainBooks.dart'; // To access the Book class

class ViewBookPage extends StatefulWidget {
  final Book book;
  const ViewBookPage({super.key, required this.book});

  @override
  State<ViewBookPage> createState() => _ViewBookPageState();
}

class _ViewBookPageState extends State<ViewBookPage> {
  // Controllers for text fields
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _chapterController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _chapterController = TextEditingController(text: widget.book.currentChapter.toString());
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        widget.book.imageUrl = image.path; // Save the path to the book object
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Book"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => Navigator.pop(context, 'delete'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- IMAGE PICKER SECTION ---
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.deepPurple.shade100,
                backgroundImage: widget.book.imageUrl != null
                    ? FileImage(File(widget.book.imageUrl!))
                    : null,
                child: widget.book.imageUrl == null
                    ? const Icon(Icons.add_a_photo, size: 40, color: Colors.deepPurple)
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            const Text("Tap to change cover", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),

            // --- TEXT FIELDS ---
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Book Title",
                filled: true,
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                  labelText: "Author",
                  filled: true,
                  fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _chapterController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Current Chapter",
                  filled: true,
                  fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                // Save changes back to the object
                widget.book.title = _titleController.text;
                widget.book.author = _authorController.text;
                widget.book.currentChapter = int.tryParse(_chapterController.text) ?? 1;

                Navigator.pop(context, true); // Return true to refresh main list
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}