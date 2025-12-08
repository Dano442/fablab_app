import 'dart:async';
import 'package:fablab_app/data/services/ingreso_service.dart';
import 'package:fablab_app/data/services/local_notification_service.dart';

class RegistroMonitorService {
  final IngresoService _ingresoService = IngresoService();
  int _ultimoConteo = 0;
  Timer? _timer;

  void iniciarMonitoreo() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      await _verificarCambios();
    });

    _verificarCambios();
  }

  Future<void> _verificarCambios() async {
    final ingresos = await _ingresoService.getIngresos();
    final cantidadActual = ingresos.length;

    if (_ultimoConteo != 0 && cantidadActual > _ultimoConteo) {
      final nuevoUsuario = ingresos.last;

      final nombre = nuevoUsuario['nombre'] ?? 'Nuevo usuario';

      await LocalNotificationService.showNotification(
        title: "Nuevo registro",
        body: "$nombre ha enviado una solicitud",
      );
    }

    _ultimoConteo = cantidadActual;
  }

  void detenerMonitoreo() {
    _timer?.cancel();
  }
}
