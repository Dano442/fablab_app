import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fablab_app/data/services/metrics_service.dart';

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
    final metrics = await MetricsService().loadMetrics();

    setState(() {
      totalProjects = metrics["totalProjects"]!;
      totalUsers = metrics["totalUsers"]!;
      totalNews = metrics["totalNews"]!;
      totalRequests = metrics["totalRequests"]!;
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Panel Administrativo',
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Monitorea las métricas clave en tiempo real',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.onPrimaryContainer.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                            onTap: () => context.go(item['route'] as String),
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
