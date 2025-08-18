import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScatterChartPage extends StatefulWidget {
  const ScatterChartPage({super.key});

  @override
  State<ScatterChartPage> createState() => _ScatterChartPageState();
}

class _ScatterChartPageState extends State<ScatterChartPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int selectedChart = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scatter Charts',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Chart selector
              Container(
                height: 60,
                margin: const EdgeInsets.all(16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final titles = [
                      'Sales Analysis',
                      'User Behavior',
                      'Performance',
                    ];
                    final isSelected = selectedChart == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChart = index;
                        });
                        _animationController.reset();
                        _animationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.red.shade600
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.red.shade300,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            titles[index],
                            style: GoogleFonts.poppins(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Chart area
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildChartTitle(),
                          const SizedBox(height: 20),
                          Expanded(child: _buildSelectedChart()),
                          const SizedBox(height: 20),
                          _buildLegend(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartTitle() {
    final titles = [
      'Sales vs Marketing Spend',
      'User Engagement Analysis',
      'Performance Metrics',
    ];
    final subtitles = [
      'Correlation between spend and revenue',
      'Time spent vs user retention',
      'Response time vs throughput',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titles[selectedChart],
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        Text(
          subtitles[selectedChart],
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSelectedChart() {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: _getSelectedSpots(),
        minX: 0,
        maxX: _getMaxX(),
        minY: 0,
        maxY: _getMaxY(),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: _getMaxY() / 5,
          verticalInterval: _getMaxX() / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: _getMaxX() / 5,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _getBottomTitle(value),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: _getMaxY() / 5,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  _getLeftTitle(value),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        scatterTouchData: ScatterTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: ScatterTouchTooltipData(
            // tooltipBgColor: Colors.black87,
            getTooltipItems: (ScatterSpot touchedBarSpot) {
              return ScatterTooltipItem(
                _getTooltipText(touchedBarSpot),
                textStyle: TextStyle(
                  height: 1.2,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                bottomMargin: 10,
              );
            },
          ),
        ),
      ),
    );
  }

  List<ScatterSpot> _getSelectedSpots() {
    switch (selectedChart) {
      case 0:
        return _getSalesSpots();
      case 1:
        return _getUserBehaviorSpots();
      case 2:
        return _getPerformanceSpots();
      default:
        return _getSalesSpots();
    }
  }

  List<ScatterSpot> _getSalesSpots() {
    final data = [
      {'x': 10.0, 'y': 25.0, 'color': Colors.blue.shade600},
      {'x': 15.0, 'y': 38.0, 'color': Colors.blue.shade600},
      {'x': 22.0, 'y': 45.0, 'color': Colors.blue.shade600},
      {'x': 28.0, 'y': 52.0, 'color': Colors.blue.shade600},
      {'x': 35.0, 'y': 68.0, 'color': Colors.blue.shade600},
      {'x': 42.0, 'y': 75.0, 'color': Colors.blue.shade600},
      {'x': 48.0, 'y': 82.0, 'color': Colors.blue.shade600},
      {'x': 55.0, 'y': 95.0, 'color': Colors.blue.shade600},
      {'x': 62.0, 'y': 105.0, 'color': Colors.blue.shade600},
      {'x': 70.0, 'y': 118.0, 'color': Colors.blue.shade600},
      // Add some outliers
      {'x': 25.0, 'y': 30.0, 'color': Colors.red.shade600},
      {'x': 40.0, 'y': 58.0, 'color': Colors.red.shade600},
      {'x': 60.0, 'y': 88.0, 'color': Colors.red.shade600},
    ];

    return data.map((point) {
      final animatedX = (point['x'] as double) * _animation.value;
      final animatedY = (point['y'] as double) * _animation.value;
      return ScatterSpot(
        animatedX,
        animatedY,
        // color: point['color'] as Color,
        // radius: 6,
      );
    }).toList();
  }

  List<ScatterSpot> _getUserBehaviorSpots() {
    final data = [
      {'x': 5.0, 'y': 20.0, 'color': Colors.green.shade600},
      {'x': 12.0, 'y': 35.0, 'color': Colors.green.shade600},
      {'x': 18.0, 'y': 48.0, 'color': Colors.green.shade600},
      {'x': 25.0, 'y': 62.0, 'color': Colors.green.shade600},
      {'x': 32.0, 'y': 75.0, 'color': Colors.green.shade600},
      {'x': 38.0, 'y': 85.0, 'color': Colors.green.shade600},
      {'x': 45.0, 'y': 92.0, 'color': Colors.green.shade600},
      {'x': 52.0, 'y': 95.0, 'color': Colors.green.shade600},
      // Mobile users
      {'x': 8.0, 'y': 15.0, 'color': Colors.orange.shade600},
      {'x': 15.0, 'y': 28.0, 'color': Colors.orange.shade600},
      {'x': 22.0, 'y': 42.0, 'color': Colors.orange.shade600},
      {'x': 30.0, 'y': 55.0, 'color': Colors.orange.shade600},
      {'x': 38.0, 'y': 68.0, 'color': Colors.orange.shade600},
      {'x': 45.0, 'y': 78.0, 'color': Colors.orange.shade600},
    ];

    return data.map((point) {
      final animatedX = (point['x'] as double) * _animation.value;
      final animatedY = (point['y'] as double) * _animation.value;
      return ScatterSpot(
        animatedX,
        animatedY,
        // color: point['color'] as Color,
        // radius: 5,
      );
    }).toList();
  }

  List<ScatterSpot> _getPerformanceSpots() {
    final data = [
      {'x': 100.0, 'y': 8.5, 'color': Colors.purple.shade600},
      {'x': 150.0, 'y': 7.2, 'color': Colors.purple.shade600},
      {'x': 200.0, 'y': 6.8, 'color': Colors.purple.shade600},
      {'x': 250.0, 'y': 6.1, 'color': Colors.purple.shade600},
      {'x': 300.0, 'y': 5.5, 'color': Colors.purple.shade600},
      {'x': 350.0, 'y': 4.9, 'color': Colors.purple.shade600},
      {'x': 400.0, 'y': 4.2, 'color': Colors.purple.shade600},
      {'x': 450.0, 'y': 3.8, 'color': Colors.purple.shade600},
      {'x': 500.0, 'y': 3.2, 'color': Colors.purple.shade600},
      // Different server configuration
      {'x': 120.0, 'y': 9.2, 'color': Colors.teal.shade600},
      {'x': 180.0, 'y': 8.1, 'color': Colors.teal.shade600},
      {'x': 240.0, 'y': 7.5, 'color': Colors.teal.shade600},
      {'x': 300.0, 'y': 6.8, 'color': Colors.teal.shade600},
      {'x': 360.0, 'y': 6.0, 'color': Colors.teal.shade600},
      {'x': 420.0, 'y': 5.2, 'color': Colors.teal.shade600},
    ];

    return data.map((point) {
      final animatedX = (point['x'] as double) * _animation.value;
      final animatedY = (point['y'] as double) * _animation.value;
      return ScatterSpot(
        animatedX,
        animatedY,
        // color: point['color'] as Color,
        // radius: 5,
      );
    }).toList();
  }

  double _getMaxX() {
    switch (selectedChart) {
      case 0:
        return 80;
      case 1:
        return 60;
      case 2:
        return 600;
      default:
        return 80;
    }
  }

  double _getMaxY() {
    switch (selectedChart) {
      case 0:
        return 140;
      case 1:
        return 100;
      case 2:
        return 10;
      default:
        return 140;
    }
  }

  String _getBottomTitle(double value) {
    switch (selectedChart) {
      case 0:
        return '\$${value.toInt()}K';
      case 1:
        return '${value.toInt()}h';
      case 2:
        return '${value.toInt()}';
      default:
        return value.toInt().toString();
    }
  }

  String _getLeftTitle(double value) {
    switch (selectedChart) {
      case 0:
        return '\$${value.toInt()}K';
      case 1:
        return '${value.toInt()}%';
      case 2:
        return '${value.toStringAsFixed(1)}s';
      default:
        return value.toInt().toString();
    }
  }

  String _getTooltipText(ScatterSpot spot) {
    switch (selectedChart) {
      case 0:
        return 'Spend: \$${spot.x.toInt()}K\nRevenue: \$${spot.y.toInt()}K';
      case 1:
        return 'Time: ${spot.x.toInt()}h\nRetention: ${spot.y.toInt()}%';
      case 2:
        return 'Throughput: ${spot.x.toInt()}\nResponse: ${spot.y.toStringAsFixed(1)}s';
      default:
        return 'X: ${spot.x.toInt()}, Y: ${spot.y.toInt()}';
    }
  }

  Widget _buildLegend() {
    final legends = [
      [
        {'label': 'Q1-Q3 Performance', 'color': Colors.blue.shade600},
        {'label': 'Q4 Performance', 'color': Colors.red.shade600},
      ],
      [
        {'label': 'Desktop Users', 'color': Colors.green.shade600},
        {'label': 'Mobile Users', 'color': Colors.orange.shade600},
      ],
      [
        {'label': 'Server Config A', 'color': Colors.purple.shade600},
        {'label': 'Server Config B', 'color': Colors.teal.shade600},
      ],
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: legends[selectedChart].map((item) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item['label'] as String,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
