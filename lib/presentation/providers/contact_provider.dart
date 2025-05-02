import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/di/locator.dart';
import '../../data/models/contact_model.dart';
import '../../domain/usecases/contact_service.dart';

class ContactProvider with ChangeNotifier {
  final service = locator<ContactService>();
  List<ContactModel> contacts = [];
  bool isLoading = false;
  String? error;
  Timer? _debounce;

  void searchContacts(String? query, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      loadContacts(context: context, query: query);
    });
  }

  Future<void> loadContacts(
      {required BuildContext context, String? query}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      debugPrint("Carregando contatos...");
      contacts = await service.getContacts(query);
      debugPrint("Contatos carregados com sucesso.");
    } catch (e) {
      error = e.toString();
      debugPrint("Erro ao carregar contatos: $error");
      _showErrorDialog(context, "Erro ao carregar contatos", error!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createContact(ContactModel contact, BuildContext context) async {
    try {
      debugPrint("Criando contato...");
      await service.addContact(contact);
      debugPrint("Contato criado com sucesso.");
      Navigator.pop(context);
      await loadContacts(context: context);
    } catch (e) {
      if (e is DioException) {
        error = e.response?.data['message'] ?? e.message;
      } else {
        error = e.toString();
      }
      debugPrint("Erro ao criar contato: $error");
      _showErrorDialog(context, "Erro ao criar contato", error!);
      notifyListeners();
    }
  }

  Future<void> updateContact(ContactModel contact, BuildContext context) async {
    try {
      debugPrint("Atualizando contato...");
      await service.editContact(contact);
      debugPrint("Contato atualizado com sucesso.");
      Navigator.pop(context);
      await loadContacts(context: context);
    } catch (e) {
      print("Erro ao atualizar contato: $e");
      error = e.toString();
      debugPrint("Erro ao atualizar contato: $error");
      _showErrorDialog(context, "Erro ao atualizar contato", error!);
      notifyListeners();
    }
  }

  Future<void> deleteContact(String id, BuildContext context) async {
    try {
      debugPrint("Deletando contato...");
      await service.removeContact(id);
      debugPrint("Contato deletado com sucesso.");
      await loadContacts(context: context);
    } catch (e) {
      error = e.toString();
      debugPrint("Erro ao deletar contato: $error");
      _showErrorDialog(context, "Erro ao deletar contato", error!);
      notifyListeners();
    }
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
