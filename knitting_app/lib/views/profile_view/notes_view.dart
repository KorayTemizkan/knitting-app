import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();

    if (!provider.isInitialized || provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Notlarım')),
      body: provider.notes.isEmpty
          ? const Center(child: Text('Henüz not yok'))
          : ListView.builder(
              itemCount: provider.notes.length,
              itemBuilder: (_, i) {
                final note = provider.notes[i];
                return ListTile(
                  title: Text(note.note),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.deleteNote(note.id!);
                    },
                  ),
                );
              },
            ),
            
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addNote('Yeni not');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
