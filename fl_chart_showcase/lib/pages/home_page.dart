import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chart_card.dart';
import 'line_chart_page.dart';
import 'bar_chart_page.dart';
import 'pie_chart_page.dart';
import 'radar_chart_page.dart';
import 'scatter_chart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'FL Chart Showcase',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              // Theme toggle would go here
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF1A1A2E),
                    const Color(0xFF16213E),
                    const Color(0xFF0F3460),
                  ]
                : [
                    const Color(0xFFE8F4FD),
                    const Color(0xFFF8FBFF),
                    const Color(0xFFFFFFFF),
                  ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Beautiful Charts',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            foreground: Paint()
                              ..shader =
                                  LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ],
                                  ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                                  ),
                          ),
                        ),

                        Text(
                          'Powered by FL Chart 🚀',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                            children: _buildChartCards(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChartCards() {
    final cards = [
      ChartCard(
        title: 'Line Charts',
        subtitle: 'Smooth & Interactive',
        icon: Icons.show_chart,
        colors: [Colors.blue.shade400, Colors.blue.shade600],
        onTap: () => _navigateToPage(const LineChartPage()),
        delay: 0,
      ),
      ChartCard(
        title: 'Bar Charts',
        subtitle: 'Dynamic & Animated',
        icon: Icons.bar_chart,
        colors: [Colors.green.shade400, Colors.green.shade600],
        onTap: () => _navigateToPage(const BarChartPage()),
        delay: 100,
      ),
      ChartCard(
        title: 'Pie Charts',
        subtitle: 'Colorful & Engaging',
        icon: Icons.pie_chart,
        colors: [Colors.orange.shade400, Colors.orange.shade600],
        onTap: () => _navigateToPage(const PieChartPage()),
        delay: 200,
      ),
      ChartCard(
        title: 'Radar Charts',
        subtitle: 'Multi-dimensional',
        icon: Icons.radar,
        colors: [Colors.purple.shade400, Colors.purple.shade600],
        onTap: () => _navigateToPage(const RadarChartPage()),
        delay: 300,
      ),
      ChartCard(
        title: 'Scatter Charts',
        subtitle: 'Data Visualization',
        icon: Icons.scatter_plot,
        colors: [Colors.red.shade400, Colors.red.shade600],
        onTap: () => _navigateToPage(const ScatterChartPage()),
        delay: 400,
      ),
      ChartCard(
        title: 'More Charts',
        subtitle: 'Coming Soon...',
        icon: Icons.auto_graph,
        colors: [Colors.teal.shade400, Colors.teal.shade600],
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('More charts coming soon! 🚀')),
          );
        },
        delay: 500,
      ),
    ];

    return cards;
  }

  void _navigateToPage(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
