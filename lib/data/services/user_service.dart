import 'package:fablab_app/domain/models/user_model.dart';

class UserService {
  final List<UserModel> _users = [
    UserModel(
      id: '1',
      name: 'Daniel Ronceros',
      email: 'daniel@inacapmail.cl',
      rut: '20.345.678-9',
      career: 'Ingeniería Informática',
      role: 'Administrador',
      project: 'Gestión FabLab',
      imageUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    UserModel(
      id: '2',
      name: 'Nicolas Escobar',
      email: 'diego@inacapmail.cl',
      rut: '19.876.543-2',
      career: 'Automatización y Robótica',
      role: 'Colaborador',
      project: 'Impresión 3D Avanzada',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ];

  List<UserModel> getAllUsers() => List.unmodifiable(_users);

  void addUser(UserModel user) => _users.add(user);

  void updateUser(UserModel updatedUser) {
    final index = _users.indexWhere((u) => u.id == updatedUser.id);
    if (index != -1) _users[index] = updatedUser;
  }

  void deleteUser(String id) {
    _users.removeWhere((u) => u.id == id);
  }
}
