# 🚀 FL Chart Showcase - Beautiful Flutter Charts

> **A stunning showcase of FL Chart capabilities with beautiful animations, interactive features, and modern UI design**

[![Flutter](https://img.shields.io/badge/Flutter-3.32+-blue.svg)](https://flutter.dev/)
[![FL Chart](https://img.shields.io/badge/FL_Chart-1.0.0-purple.svg)](https://pub.dev/packages/fl_chart)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-3.32+-blue?style=for-the-badge&logo=flutter" alt="Flutter Version"/>
  <img src="https://img.shields.io/badge/FL_Chart-1.0.0-purple?style=for-the-badge" alt="FL Chart Version"/>
  <img src="https://img.shields.io/badge/Status-Production%20Ready-brightgreen?style=for-the-badge" alt="Status"/>
</div>

---

## ✨ What's This?

This is a **beautiful, interactive showcase** of the [FL Chart](https://pub.dev/packages/fl_chart) package for Flutter. It demonstrates how to create stunning, animated charts that will make your users go "Wow! 🤩"

Perfect for:
- 🎯 **Portfolio projects** to showcase your skills
- 📊 **Learning FL Chart** with real examples
- 🚀 **Production apps** that need beautiful data visualization

---

## 🎨 Features That Will Blow Your Mind

### 🌟 **Stunning Visual Design**
- **Gradient backgrounds** with smooth color transitions
- **Glassmorphism effects** and modern card designs
- **Beautiful typography** using Google Fonts (Poppins)
- **Responsive layouts** that work on all screen sizes

### 🎭 **Smooth Animations**
- **Staggered entrance animations** for chart cards
- **Interactive hover effects** with scale transformations
- **Chart data animations** that bring data to life
- **Page transitions** with custom slide animations

### 📊 **Interactive Chart Types**

#### 📈 **Line Charts**
- **Sales Growth Trends** with smooth curves
- **Temperature Variations** over time
- **Stock Price Movements** with real-time feel
- Interactive tooltips and touch responses

#### 📊 **Bar Charts**
- **Revenue Analysis** by product category
- **App Downloads** across platforms
- **Team Performance** metrics
- Animated bars with hover effects

#### 🥧 **Pie Charts**
- **Market Share Analysis** with interactive segments
- **Expense Breakdown** by category
- **Traffic Sources** visualization
- Touch-responsive sections with badges

#### 🎯 **Radar Charts**
- **Skills Assessment** for team members
- **Product Comparison** across features
- Multi-dimensional data visualization
- Custom axis labels and styling

#### 🔍 **Scatter Charts**
- **Sales vs Marketing** correlation analysis
- **User Behavior** patterns
- **Performance Metrics** comparison
- Interactive data point exploration

---

## 🛠️ Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| **Flutter** | 3.32+ | Cross-platform UI framework |
| **FL Chart** | 1.0.0 | Beautiful chart library |
| **Google Fonts** | 5.0.0 | Typography enhancement |
| **Material 3** | Latest | Modern design system |

---

## 🚀 Getting Started

### Prerequisites
- Flutter 3.32 or higher
- Dart 3.0 or higher
- A device or emulator to run the app

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/amirbayat0/fl_chart_showcase.git
   cd fl_chart_showcase
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### 🎯 **Quick Start for Web**
```bash
flutter run -d chrome --web-port 8080
```

---

## 📱 App Structure

```
lib/
├── main.dart              # App entry point with theme configuration
├── pages/                 # Chart showcase pages
│   ├── home_page.dart     # Beautiful home with chart cards
│   ├── line_chart_page.dart    # Line chart examples
│   ├── bar_chart_page.dart     # Bar chart examples
│   ├── pie_chart_page.dart     # Pie chart examples
│   ├── radar_chart_page.dart   # Radar chart examples
│   └── scatter_chart_page.dart # Scatter chart examples
└── widgets/               # Reusable UI components
    └── chart_card.dart    # Animated chart selection cards
```

---

## 🎨 Design Philosophy

### **Modern & Engaging**
- **Material 3** design principles
- **Smooth animations** that feel natural
- **Interactive elements** that respond to user input
- **Beautiful gradients** and shadows

### **User Experience First**
- **Intuitive navigation** between chart types
- **Touch-friendly** interactions
- **Responsive design** for all screen sizes
- **Accessibility** considerations

### **Performance Optimized**
- **Efficient animations** using Flutter's animation system
- **Lazy loading** of chart data
- **Smooth 60fps** animations
- **Memory efficient** chart rendering

---

## 🔧 Customization

### **Adding New Charts**
1. Create a new page in `lib/pages/`
2. Add it to the home page navigation
3. Follow the existing pattern for consistency

### **Modifying Colors**
- Update the color schemes in `main.dart`
- Modify chart-specific colors in each page
- Use the theme system for consistency

### **Animation Tweaking**
- Adjust animation durations in `initState()`
- Modify animation curves for different feels
- Add new animation types as needed

---

## 📊 Chart Examples

### **Line Chart - Sales Growth**
```dart
LineChart(
  LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: salesData,
        isCurved: true,
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400.withOpacity(0.3),
              Colors.blue.shade400.withOpacity(0.1),
            ],
          ),
        ),
      ),
    ],
  ),
)
```

### **Bar Chart - Revenue Analysis**
```dart
BarChart(
  BarChartData(
    barGroups: revenueData.map((data) {
      return BarChartGroupData(
        x: data.index,
        barRods: [
          BarChartRodData(
            toY: data.value,
            color: data.color,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      );
    }).toList(),
  ),
)
```

---

## 🌟 Key FL Chart Features Demonstrated

### **Interactive Elements**
- **Touch responses** on all chart types
- **Tooltips** with custom styling
- **Hover effects** and animations
- **Selection states** for data points

### **Customization Options**
- **Color schemes** and gradients
- **Typography** and labels
- **Grid lines** and borders
- **Axis configurations**

### **Animation Capabilities**
- **Data animations** on load
- **Interactive animations** on touch
- **Smooth transitions** between states
- **Performance optimized** rendering

---

## 📱 Screenshots & Demo

<img width="350" alt="Image" src="https://github.com/user-attachments/assets/72982c10-eebd-4239-ba11-0637ae698da7" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/196d17d1-2011-4e4f-8b22-99bab4886659" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/d8ddf165-b556-46f1-8c92-0b9fa585805f" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/82060641-7c47-4742-800b-4f41c91f8bb0" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/549c4b7b-0df8-467b-8303-2beb8aec5d8a" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/8a010d72-19f9-48c8-899a-b120f77f332f" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/60ae72e4-1266-4152-907c-3a944405b961" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/d0e2a2e6-d17e-4f77-af89-627ac98eb9c7" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/7dbbcc0b-9dd5-41d8-ba14-db955ac76ef7" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/7768a12f-d6ef-40d5-a0b1-eb45b4b3d9fb" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/a1bda6ed-7d78-459a-a486-c827a568931c" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/fe400eb5-c0ca-4c13-b86b-a972983e20e5" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/753299e1-8599-41ce-b669-cdf3d0315eb6" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/5a784ece-6751-435b-99d3-0e8dce98a97f" />
<img width="350" alt="Image" src="https://github.com/user-attachments/assets/90f29b5b-5c3d-439d-849b-17623aa7672a" />


---

## 🤝 Contributing

We love contributions! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-chart`)
3. **Commit your changes** (`git commit -m 'Add amazing new chart type'`)
4. **Push to the branch** (`git push origin feature/amazing-chart`)
5. **Open a Pull Request**

### **Contribution Ideas**
- 🆕 **New chart types** (Area charts, Candlestick charts)
- 🎨 **Additional themes** (Dark mode, custom color schemes)
- 📱 **Mobile optimizations** (Touch gestures, haptic feedback)
- 🌍 **Internationalization** (Multi-language support)
- 🧪 **Unit tests** and **widget tests**

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **FL Chart Team** for the amazing chart library
- **Flutter Team** for the incredible framework
- **Material Design Team** for the beautiful design system
- **Google Fonts** for the typography

---

## 📞 Support & Community

- **GitHub Issues**: [Report bugs or request features](https://github.com/yourusername/fl_chart_showcase/issues)
 - **FL Chart**: [Official documentation](https://pub.dev/packages/fl_chart)

---

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=amirbayat0/fl_chart_showcase&type=Date)](https://star-history.com/#repos/fl_chart_showcase&Date)

---



<div align="center">

**Made with ❤️ by Amir**

*If this project helps you create beautiful charts, please give it a ⭐ star!*

[![GitHub stars](https://img.shields.io/github/stars/amirbayat0/fl_chart_showcase?style=social)](https://github.com/amirbayat0/fl_chart_showcase)
[![GitHub forks](https://img.shields.io/github/forks/amirbayat0/fl_chart_showcase?style=social)](https://github.com/amirbayat0/fl_chart_showcase)
[![GitHub issues](https://img.shields.io/github/issues/amirbayat0/fl_chart_showcase)](https://github.com/amirbayat0/fl_chart_showcase/issues)

</div>
