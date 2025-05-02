import '../../data/models/contact_model.dart';
import '../../data/repositories/contact_repository.dart';

class ContactService {
  final ContactRepository repository;

  ContactService(this.repository);

  Future<List<ContactModel>> getContacts([String? search]) =>
      repository.getAllContacts(search);

  Future<void> addContact(ContactModel contact) =>
      repository.createContact(contact);

  Future<void> editContact(ContactModel contact) =>
      repository.updateContact(contact);

  Future<void> removeContact(String id) => repository.deleteContact(id);
}
