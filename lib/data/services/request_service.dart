import 'package:fablab_app/domain/models/request_model.dart';

class RequestService {
  final List<RequestModel> _requests = [
    RequestModel(
      id: '1',
      title: 'Uso de Impresora 3D',
      description:
          'Solicitud para imprimir piezas de un prototipo de robot educativo.',
      requester: 'Daniel Ronceros',
      status: 'Pendiente',
      date: DateTime(2025, 10, 21),
    ),
    RequestModel(
      id: '2',
      title: 'Corte Láser en MDF',
      description:
          'Solicitud para corte láser de estructuras para proyecto de maqueta.',
      requester: 'Alexis Pérez',
      status: 'Aprobada',
      date: DateTime(2025, 10, 18),
    ),
    RequestModel(
      id: '3',
      title: 'Préstamo de Arduino UNO',
      description:
          'Solicitud para préstamo de kit Arduino para prácticas de automatización.',
      requester: 'María Gutiérrez',
      status: 'Rechazada',
      date: DateTime(2025, 10, 15),
    ),
  ];

  List<RequestModel> getAll() => List.unmodifiable(_requests);

  void add(RequestModel request) {
    _requests.add(request);
  }

  void update(RequestModel updated) {
    final index = _requests.indexWhere((r) => r.id == updated.id);
    if (index != -1) _requests[index] = updated;
  }

  void delete(String id) {
    _requests.removeWhere((r) => r.id == id);
  }
}
