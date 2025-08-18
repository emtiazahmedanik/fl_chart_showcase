import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage>
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
          'Line Charts',
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
            colors: [Colors.blue.shade50, Colors.white],
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
                      'Sales Growth',
                      'Temperature',
                      'Stock Price',
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
                              ? Colors.blue.shade600
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.blue.shade300,
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
      'Monthly Sales Growth',
      'Daily Temperature',
      'Stock Price Movement',
    ];
    final subtitles = [
      'Revenue trends over 12 months',
      'Temperature variation in °C',
      'Price fluctuations this week',
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
        return _buildSalesChart();
      case 1:
        return _buildTemperatureChart();
      case 2:
        return _buildStockChart();
      default:
        return _buildSalesChart();
    }
  }

  Widget _buildSalesChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
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
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                );
                final months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec',
                ];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(months[value.toInt()], style: style);
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '${value.toInt()}K',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 8,
        lineBarsData: [
          LineChartBarData(
            spots: _generateSalesData(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: Colors.blue.shade600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400.withOpacity(0.3),
                  Colors.blue.shade400.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 5,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.orange.shade200, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.orange.shade200, strokeWidth: 1);
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
              reservedSize: 30,
              interval: 2,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '${value.toInt()}h',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 5,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '${value.toInt()}°',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.orange.shade300, width: 1),
        ),
        minX: 0,
        maxX: 23,
        minY: 10,
        maxY: 35,
        lineBarsData: [
          LineChartBarData(
            spots: _generateTemperatureData(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.red.shade500],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.orange.shade600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade300.withOpacity(0.4),
                  Colors.orange.shade300.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 10,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.green.shade200, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.green.shade200, strokeWidth: 1);
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
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < days.length) {
                  return Text(
                    days[value.toInt()],
                    style: const TextStyle(fontSize: 12),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 10,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '\$${value.toInt()}',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.green.shade300, width: 1),
        ),
        minX: 0,
        maxX: 6,
        minY: 100,
        maxY: 180,
        lineBarsData: [
          LineChartBarData(
            spots: _generateStockData(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.green.shade400, Colors.green.shade600],
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: Colors.green.shade600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade400.withOpacity(0.3),
                  Colors.green.shade400.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final colors = [
      [Colors.blue.shade600, Colors.blue.shade400],
      [Colors.orange.shade600, Colors.red.shade500],
      [Colors.green.shade600, Colors.green.shade400],
    ];
    final labels = ['Sales Data', 'Temperature', 'Stock Price'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors[selectedChart]),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          labels[selectedChart],
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  List<FlSpot> _generateSalesData() {
    final data = [1.5, 2.0, 1.8, 3.2, 2.8, 4.1, 3.5, 4.8, 4.2, 5.5, 5.0, 6.2];
    return data.asMap().entries.map((entry) {
      final progress = _animation.value;
      final animatedValue = entry.value * progress;
      return FlSpot(entry.key.toDouble(), animatedValue);
    }).toList();
  }

  List<FlSpot> _generateTemperatureData() {
    final data = [
      12.0,
      13.5,
      15.0,
      18.2,
      22.1,
      26.5,
      28.3,
      30.1,
      28.8,
      25.2,
      20.1,
      16.5,
      14.2,
      12.8,
      11.5,
      10.2,
      12.0,
      14.5,
      16.8,
      18.9,
      17.2,
      15.1,
      13.8,
      12.5,
    ];
    return data.asMap().entries.map((entry) {
      final progress = _animation.value;
      final animatedValue = 10 + (entry.value - 10) * progress;
      return FlSpot(entry.key.toDouble(), animatedValue);
    }).toList();
  }

  List<FlSpot> _generateStockData() {
    final data = [145.0, 142.5, 148.2, 151.8, 149.5, 155.3, 158.7];
    return data.asMap().entries.map((entry) {
      final progress = _animation.value;
      final animatedValue = 100 + (entry.value - 100) * progress;
      return FlSpot(entry.key.toDouble(), animatedValue);
    }).toList();
  }
}
