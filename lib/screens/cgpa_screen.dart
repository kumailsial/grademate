import 'package:flutter/material.dart';

class CGPAScreen extends StatefulWidget {
  const CGPAScreen({super.key});

  @override
  State<CGPAScreen> createState() => _CGPAScreenState();
}

class _CGPAScreenState extends State<CGPAScreen> {
  static const int maxSemesters = 8;

  final List<TextEditingController> sgpaControllers = [];
  double? cgpa;

  @override
  void initState() {
    super.initState();
    // Default 2 semesters
    addSemester();
    addSemester();
  }

  void addSemester() {
    if (sgpaControllers.length >= maxSemesters) return;
    setState(() {
      sgpaControllers.add(TextEditingController());
    });
  }

  void calculateCGPA() {
    double total = 0;
    int count = 0;

    for (var controller in sgpaControllers) {
      final value = double.tryParse(controller.text);
      if (value != null) {
        total += value;
        count++;
      }
    }

    if (count == 0) return;

    setState(() {
      cgpa = total / count;
    });
  }
  void resetCGPA() {
    setState(() {
      sgpaControllers.clear();
      cgpa = null;

      // Reset to default 2 semesters
      addSemester();
      addSemester();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CGPA Calculator'),
        backgroundColor: const Color(0xFF00695C),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Enter Semester SGPA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ...List.generate(sgpaControllers.length, (index) {
              return Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: TextField(
                    controller: sgpaControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Semester ${index + 1} SGPA',
                      prefixIcon: const Icon(Icons.school),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              );
            }),

            if (sgpaControllers.length < maxSemesters)
              OutlinedButton.icon(
                onPressed: addSemester,
                icon: const Icon(Icons.add),
                label: const Text('Add Semester'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00695C),
                  side: const BorderSide(color: Color(0xFF00695C)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: calculateCGPA,
                icon: const Icon(Icons.calculate, color: Colors.white),
                label: const Text(
                  'CALCULATE CGPA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D40),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 7,
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: resetCGPA,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'RESET',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00695C),
                  side: const BorderSide(color: Color(0xFF00695C)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),


            const SizedBox(height: 24),

            if (cgpa != null)
              Card(
                elevation: 8,
                color: Colors.teal.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Your CGPA',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cgpa!.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00695C),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
