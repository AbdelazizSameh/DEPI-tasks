import 'package:flutter/material.dart';
import '../cloud_fire_store/cloud_fire_store.dart';
import '../models/expense_model.dart';
import 'add_edit_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';

  @override
  Widget build(BuildContext context) {
    final databaseService = FirebaseDatabase();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Journals"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Journal>>(
        stream: databaseService.getJournal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No journals yet. Add one!"));
          }

          final journals = snapshot.data!;
          journals.sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            itemCount: journals.length,
            itemBuilder: (context, index) {
              final journal = journals[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () =>
                      _navigateToEdit(context, databaseService, journal),
                  leading: CircleAvatar(
                    child: Text(journal.mood.substring(0, 1)),
                  ),
                  title: Text(journal.note),
                  subtitle: Text(journal.date),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            _navigateToEdit(context, databaseService, journal),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await databaseService.deleteJournal(journal.id);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Journal deleted")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEdit(context, databaseService),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _navigateToEdit(
    BuildContext context,
    FirebaseDatabase database, [
    Journal? journal,
  ]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditView(journal: journal)),
    );

    if (result != null && result is Journal) {
      if (journal == null) {
        await database.addJournal(result);

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Journal added")));
        }
      } else {
        await database.updateJournal(result);

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Journal updated")));
        }
      }
    }
  }
}
