import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int totalProjects = 0;
  int totalUsers = 0;
  int totalNews = 0;
  int totalRequests = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    // Simulación temporal hasta conectar con API real
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      totalProjects = 12;
      totalUsers = 8;
      totalNews = 5;
      totalRequests = 3;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final dashboardData = [
      {
        'title': 'Proyectos',
        'value': totalProjects.toString(),
        'icon': Icons.folder_open,
        'color': Colors.blue,
        'route': '/projects',
      },
      {
        'title': 'Usuarios',
        'value': totalUsers.toString(),
        'icon': Icons.people,
        'color': Colors.green,
        'route': '/users',
      },
      {
        'title': 'Noticias',
        'value': totalNews.toString(),
        'icon': Icons.article,
        'color': Colors.orange,
        'route': '/news',
      },
      {
        'title': 'Solicitudes',
        'value': totalRequests.toString(),
        'icon': Icons.notifications_active,
        'color': Colors.purple,
        'route': '/request',
      },
    ];

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Panel Administrativo',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Indicador de carga
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else
                        GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // evita doble scroll
                          shrinkWrap: true, // ajusta el tamaño
                          itemCount: dashboardData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                          itemBuilder: (context, index) {
                            final item = dashboardData[index];
                            return _DashboardCard(
                              title: item['title'] as String,
                              value: item['value'] as String,
                              icon: item['icon'] as IconData,
                              color: item['color'] as Color,
                              onTap: () =>
                                  context.go(item['route'] as String),
                            );
                          },
                        ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: color.withOpacity(0.3),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: colors.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 28,
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: textTheme.headlineMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
