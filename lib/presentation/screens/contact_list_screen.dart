import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/contact_model.dart';
import '../providers/contact_provider.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context);

    void showPopup(String title, String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Contatos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(labelText: "Pesquisar contato"),
              onChanged: (value) => provider.searchContacts(value, context),
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : provider.contacts.isEmpty
                    ? Center(child: Text("Nenhum contato encontrado"))
                    : ListView.builder(
                        itemCount: provider.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = provider.contacts[index];
                          return ListTile(
                            title: Text(contact.name),
                            subtitle: Text(contact.phone),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ContactFormScreen(contact: contact),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await provider.deleteContact(
                                        contact.id!, context);
                                    if (provider.error != null) {
                                      showPopup(
                                        "Erro",
                                        "Erro ao deletar contato: ${provider.error}",
                                      );
                                    } else {
                                      showPopup(
                                        "Sucesso",
                                        "Contato deletado com sucesso.",
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ContactFormScreen(),
            ),
          );
        },
      ),
    );
  }
}
