import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadarChartPage extends StatefulWidget {
  const RadarChartPage({super.key});

  @override
  State<RadarChartPage> createState() => _RadarChartPageState();
}

class _RadarChartPageState extends State<RadarChartPage>
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
          'Radar Charts',
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
            colors: [Colors.purple.shade50, Colors.white],
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
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final titles = ['Skills Assessment', 'Product Comparison'];
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
                              ? Colors.purple.shade600
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.purple.shade300,
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
    final titles = ['Team Skills Assessment', 'Product Feature Comparison'];
    final subtitles = [
      'Technical skills evaluation',
      'Feature comparison across products',
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
    return RadarChart(
      RadarChartData(
        radarTouchData: RadarTouchData(enabled: true),
        dataSets: _getSelectedDataSets(),
        radarBackgroundColor: Colors.transparent,
        borderData: FlBorderData(show: false),
        radarBorderData: BorderSide(color: Colors.grey.shade300, width: 2),
        titlePositionPercentageOffset: 0.2,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.grey.shade700,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        getTitle: (index, angle) {
          final titles = selectedChart == 0
              ? ['Flutter', 'React', 'Node.js', 'Python', 'Design', 'Testing']
              : ['Speed', 'Security', 'UI/UX', 'Features', 'Support', 'Price'];
          return RadarChartTitle(text: titles[index]);
        },
        tickCount: 5,
        ticksTextStyle: GoogleFonts.poppins(
          color: Colors.grey.shade500,
          fontSize: 10,
        ),
        tickBorderData: BorderSide(color: Colors.grey.shade300, width: 1),
        gridBorderData: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
    );
  }

  List<RadarDataSet> _getSelectedDataSets() {
    if (selectedChart == 0) {
      return _getSkillsDataSets();
    } else {
      return _getProductDataSets();
    }
  }

  List<RadarDataSet> _getSkillsDataSets() {
    final data1 = [4.5, 3.8, 4.2, 3.5, 4.0, 3.9];
    final data2 = [3.2, 4.5, 3.8, 4.1, 3.5, 4.2];

    return [
      RadarDataSet(
        fillColor: Colors.blue.shade400.withOpacity(0.3),
        borderColor: Colors.blue.shade600,
        entryRadius: 4,
        dataEntries: data1.map((value) {
          final animatedValue = value * _animation.value;
          return RadarEntry(value: animatedValue);
        }).toList(),
        borderWidth: 3,
      ),
      RadarDataSet(
        fillColor: Colors.orange.shade400.withOpacity(0.3),
        borderColor: Colors.orange.shade600,
        entryRadius: 4,
        dataEntries: data2.map((value) {
          final animatedValue = value * _animation.value;
          return RadarEntry(value: animatedValue);
        }).toList(),
        borderWidth: 3,
      ),
    ];
  }

  List<RadarDataSet> _getProductDataSets() {
    final data1 = [4.2, 4.5, 4.8, 4.3, 4.1, 3.8];
    final data2 = [3.8, 4.2, 4.1, 4.6, 4.3, 4.2];
    final data3 = [4.0, 3.9, 4.3, 3.8, 4.0, 4.5];

    return [
      RadarDataSet(
        fillColor: Colors.green.shade400.withOpacity(0.3),
        borderColor: Colors.green.shade600,
        entryRadius: 4,
        dataEntries: data1.map((value) {
          final animatedValue = value * _animation.value;
          return RadarEntry(value: animatedValue);
        }).toList(),
        borderWidth: 3,
      ),
      RadarDataSet(
        fillColor: Colors.red.shade400.withOpacity(0.3),
        borderColor: Colors.red.shade600,
        entryRadius: 4,
        dataEntries: data2.map((value) {
          final animatedValue = value * _animation.value;
          return RadarEntry(value: animatedValue);
        }).toList(),
        borderWidth: 3,
      ),
      RadarDataSet(
        fillColor: Colors.purple.shade400.withOpacity(0.3),
        borderColor: Colors.purple.shade600,
        entryRadius: 4,
        dataEntries: data3.map((value) {
          final animatedValue = value * _animation.value;
          return RadarEntry(value: animatedValue);
        }).toList(),
        borderWidth: 3,
      ),
    ];
  }

  Widget _buildLegend() {
    final legends = [
      [
        {'label': 'Developer A', 'color': Colors.blue.shade600},
        {'label': 'Developer B', 'color': Colors.orange.shade600},
      ],
      [
        {'label': 'Our Product', 'color': Colors.green.shade600},
        {'label': 'Competitor 1', 'color': Colors.red.shade600},
        {'label': 'Competitor 2', 'color': Colors.purple.shade600},
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
