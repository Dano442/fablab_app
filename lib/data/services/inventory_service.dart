import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/domain/models/inventory_model.dart';

class InventoryService {
  final Dio _dio = ApiClient.createDio();

  Future<List<InventoryModel>> getInventory() async {
    try {
      final response = await _dio.get('/inventario');
      final data = response.data as List;
      return data.map((e) => InventoryModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> createInventory(InventoryModel item) async {
    try {
      await _dio.post('/inventario', data: item.toJsonPost());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateInventory(int id, InventoryModel item) async {
    try {
      await _dio.put('/inventario/$id', data: item.toJsonPut());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteInventory(int id) async {
    try {
      await _dio.delete('/inventario/$id');
      return true;
    } catch (e) {
      return false;
    }
  }
}
