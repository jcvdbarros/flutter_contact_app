import 'package:dio/dio.dart';
import '../models/contact_model.dart';

class ContactRepository {
  final Dio _dio = Dio(BaseOptions(
      baseUrl:
          "https://d204-2804-954-fe48-4c00-8d08-ce74-c856-ef09.ngrok-free.app/contacts"));

  Future<List<ContactModel>> getAllContacts([String? search]) async {
    print(search);
    final response = await _dio.get("/", queryParameters: {"name": search});
    return (response.data as List)
        .map((e) => ContactModel.fromJson(e))
        .toList();
  }

  Future<void> createContact(ContactModel contact) async {
    await _dio.post("/", data: contact.toJson());
  }

  Future<void> updateContact(ContactModel contact) async {
    await _dio.put("/${contact.id}", data: contact.toJson());
  }

  Future<void> deleteContact(String id) async {
    await _dio.delete("/$id");
  }
}
