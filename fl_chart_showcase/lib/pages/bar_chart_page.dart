import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({super.key});

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int selectedChart = 0;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
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
          'Bar Charts',
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
            colors: [Colors.green.shade50, Colors.white],
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
                    final titles = ['Revenue', 'Downloads', 'Performance'];
                    final isSelected = selectedChart == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChart = index;
                          touchedIndex = -1;
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
                              ? Colors.green.shade600
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.green.shade300,
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
    final titles = ['Monthly Revenue', 'App Downloads', 'Team Performance'];
    final subtitles = [
      'Revenue by product category',
      'Downloads across platforms',
      'Performance metrics by department',
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
    switch (selectedChart) {
      case 0:
        return _buildRevenueChart();
      case 1:
        return _buildDownloadsChart();
      case 2:
        return _buildPerformanceChart();
      default:
        return _buildRevenueChart();
    }
  }

  Widget _buildRevenueChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // color: Colors.black87,
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final categories = ['Mobile', 'Web', 'Desktop', 'API', 'Cloud'];
              return BarTooltipItem(
                '${categories[group.x]}\n\$${rod.toY.round()}K',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
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
              getTitlesWidget: (double value, TitleMeta meta) {
                const categories = ['Mobile', 'Web', 'Desktop', 'API', 'Cloud'];
                final style = TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                if (value.toInt() >= 0 && value.toInt() < categories.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(categories[value.toInt()], style: style),
                  );
                }
                return const Text('');
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 20,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '\$${value.toInt()}K',
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
        borderData: FlBorderData(show: false),
        barGroups: _getRevenueBarGroups(),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
          },
        ),
      ),
    );
  }

  Widget _buildDownloadsChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 50,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blue.shade800,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final platforms = ['iOS', 'Android', 'Windows', 'macOS'];
              return BarTooltipItem(
                '${platforms[group.x]}\n${rod.toY.round()}M downloads',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
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
              getTitlesWidget: (double value, TitleMeta meta) {
                const platforms = ['iOS', 'Android', 'Windows', 'macOS'];
                final style = TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                if (value.toInt() >= 0 && value.toInt() < platforms.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(platforms[value.toInt()], style: style),
                  );
                }
                return const Text('');
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 10,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '${value.toInt()}M',
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
        borderData: FlBorderData(show: false),
        barGroups: _getDownloadsBarGroups(),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
          },
        ),
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.purple.shade800,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final departments = ['Sales', 'Marketing', 'Dev', 'Support'];
              return BarTooltipItem(
                '${departments[group.x]}\n${rod.toY.round()}%',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
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
              getTitlesWidget: (double value, TitleMeta meta) {
                const departments = ['Sales', 'Marketing', 'Dev', 'Support'];
                final style = TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                if (value.toInt() >= 0 && value.toInt() < departments.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(departments[value.toInt()], style: style),
                  );
                }
                return const Text('');
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 20,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '${value.toInt()}%',
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
        borderData: FlBorderData(show: false),
        barGroups: _getPerformanceBarGroups(),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> _getRevenueBarGroups() {
    final data = [85.0, 72.0, 65.0, 58.0, 92.0];
    final colors = [
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
      Colors.red.shade600,
    ];

    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value * _animation.value;
      final isTouched = index == touchedIndex;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: colors[index],
            width: isTouched ? 25 : 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: colors[index].withOpacity(0.1),
            ),
          ),
        ],
      );
    }).toList();
  }

  List<BarChartGroupData> _getDownloadsBarGroups() {
    final data = [45.0, 38.0, 25.0, 15.0];
    final colors = [
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
    ];

    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value * _animation.value;
      final isTouched = index == touchedIndex;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: colors[index],
            width: isTouched ? 25 : 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 50,
              color: colors[index].withOpacity(0.1),
            ),
          ),
        ],
      );
    }).toList();
  }

  List<BarChartGroupData> _getPerformanceBarGroups() {
    final data = [88.0, 92.0, 85.0, 78.0];
    final colors = [
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
    ];

    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value * _animation.value;
      final isTouched = index == touchedIndex;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: colors[index],
            width: isTouched ? 25 : 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: colors[index].withOpacity(0.1),
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildLegend() {
    final legends = [
      ['Mobile', 'Web', 'Desktop', 'API', 'Cloud'],
      ['iOS', 'Android', 'Windows', 'macOS'],
      ['Sales', 'Marketing', 'Development', 'Support'],
    ];
    final colors = [
      [
        Colors.blue.shade600,
        Colors.green.shade600,
        Colors.orange.shade600,
        Colors.purple.shade600,
        Colors.red.shade600,
      ],
      [
        Colors.blue.shade600,
        Colors.green.shade600,
        Colors.orange.shade600,
        Colors.purple.shade600,
      ],
      [
        Colors.blue.shade600,
        Colors.green.shade600,
        Colors.orange.shade600,
        Colors.purple.shade600,
      ],
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: legends[selectedChart].asMap().entries.map((entry) {
        final index = entry.key;
        final label = entry.value;
        final color = colors[selectedChart][index];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
