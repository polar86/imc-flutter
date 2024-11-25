import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BMICalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;
  String _bmiResult = "";

  void calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);
    if (weight != null && height != null && height > 0) {
      final heightInMeters = height / 100;
      final bmi = weight / (heightInMeters * heightInMeters);
      setState(() {
        _bmi = bmi;
        _bmiResult = _getBMICategory(bmi);
      });
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi <= 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Body'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "BMI Calculator",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.male, size: 50),
                const SizedBox(width: 40),
                Icon(Icons.female, size: 50, color: Colors.grey[300]),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Your height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Your weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                )
              ),
              child: const Text('Calculate your BMI'),
            ),
            if (_bmi != null) ...[
              const SizedBox(height: 20),
              const Text(
                "Your BMI",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                _bmi!.toStringAsFixed(1),
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                _bmiResult,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              TextButton(
                  onPressed: () => setState(() {
                        _bmi = null;
                        _bmiResult = "";
                        _weightController.clear();
                        _heightController.clear();
                      }),
                  child: const Text("Calculate BMI again"))
            ],
            Expanded(child: Container()),
            const Divider(),
            const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "BMI categories\n\n"
                  "Less than 18.5: you're uderweight.\n"
                  "18.5 - 24.9: you're normal.\n"
                  "25.0 - 29.9: you're overweight.\n"
                  "30.0 and more: obesity.\n",
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
