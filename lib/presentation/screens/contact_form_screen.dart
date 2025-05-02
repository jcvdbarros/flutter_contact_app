import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/contact_model.dart';
import '../providers/contact_provider.dart';

class ContactFormScreen extends StatefulWidget {
  final ContactModel? contact;
  const ContactFormScreen({super.key, this.contact});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact?.name ?? '');
    emailController = TextEditingController(text: widget.contact?.email ?? '');
    phoneController = TextEditingController(text: widget.contact?.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context, listen: false);

    void submit() {
      if (_formKey.currentState!.validate()) {
        final newContact = ContactModel(
          id: widget.contact?.id,
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
        );
        if (widget.contact == null) {
          provider.createContact(newContact, context);
        } else {
          provider.updateContact(newContact, context);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.contact == null ? "Novo Contato" : "Editar Contato")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? "Informe o nome" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? "Informe o email" : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) =>
                    value!.isEmpty ? "Informe o telefone" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: submit, child: Text("Salvar")),
            ],
          ),
        ),
      ),
    );
  }
}
