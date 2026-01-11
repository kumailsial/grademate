import 'package:flutter/material.dart';

class SGPAScreen extends StatefulWidget {
  const SGPAScreen({super.key});

  @override
  State<SGPAScreen> createState() => _SGPAScreenState();
}

class _SGPAScreenState extends State<SGPAScreen> {
  static const int maxCourses = 10;

  final List<TextEditingController> creditControllers = [];
  final List<TextEditingController> marksControllers = [];

  double? sgpa;

  @override
  void initState() {
    super.initState();
    // Default 5 courses
    for (int i = 0; i < 5; i++) {
      addCourse();
    }
  }

  void addCourse() {
    if (creditControllers.length >= maxCourses) return;
    setState(() {
      creditControllers.add(TextEditingController());
      marksControllers.add(TextEditingController());
    });
  }

  double gradePointFromMarks(double marks) {
    if (marks >= 80) return 4.0;
    if (marks >= 79) return 3.94;
    if (marks >= 78) return 3.87;
    if (marks >= 77) return 3.8;
    if (marks >= 76) return 3.74;
    if (marks >= 75) return 3.67;
    if (marks >= 74) return 3.6;
    if (marks >= 73) return 3.54;
    if (marks >= 72) return 3.47;
    if (marks >= 71) return 3.4;
    if (marks >= 70) return 3.34;
    if (marks >= 69) return 3.27;
    if (marks >= 68) return 3.2;
    if (marks >= 67) return 3.14;
    if (marks >= 66) return 3.07;
    if (marks >= 65) return 3.0;
    if (marks >= 64) return 2.92;
    if (marks >= 63) return 2.85;
    if (marks >= 62) return 2.78;
    if (marks >= 61) return 2.7;
    if (marks >= 60) return 2.64;
    if (marks >= 59) return 2.57;
    if (marks >= 58) return 2.5;
    if (marks >= 57) return 2.43;
    if (marks >= 56) return 2.36;
    if (marks >= 55) return 2.3;
    if (marks >= 54) return 2.24;
    if (marks >= 53) return 2.18;
    if (marks >= 52) return 2.12;
    if (marks >= 51) return 2.06;
    if (marks >= 50) return 2.0;
    if (marks >= 49) return 1.9;
    if (marks >= 48) return 1.8;
    if (marks >= 47) return 1.7;
    if (marks >= 46) return 1.6;
    if (marks >= 45) return 1.5;
    if (marks >= 44) return 1.4;
    if (marks >= 43) return 1.3;
    if (marks >= 42) return 1.2;
    if (marks >= 41) return 1.1;
    if (marks >= 40) return 1.0;
    return 0.0;
  }

  void calculateSGPA() {
    double totalPoints = 0;
    double totalCredits = 0;

    for (int i = 0; i < creditControllers.length; i++) {
      final credits = double.tryParse(creditControllers[i].text);
      final marks = double.tryParse(marksControllers[i].text);

      if (credits == null || marks == null) continue;

      final gp = gradePointFromMarks(marks);
      totalPoints += gp * credits;
      totalCredits += credits;
    }

    if (totalCredits == 0) return;

    setState(() {
      sgpa = totalPoints / totalCredits;
    });
  }
  void resetSGPA() {
    setState(() {
      creditControllers.clear();
      marksControllers.clear();
      sgpa = null;

      // Reset to default 5 courses
      for (int i = 0; i < 5; i++) {
        creditControllers.add(TextEditingController());
        marksControllers.add(TextEditingController());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SGPA Calculator'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Enter Course Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ...List.generate(creditControllers.length, (index) {
              return Card(
                elevation: 6,
                shadowColor: Colors.teal.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: creditControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Credits',
                                prefixIcon: const Icon(Icons.timer, size: 20),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: marksControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Marks',
                                prefixIcon: const Icon(Icons.score, size: 20),
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
                        ],
                      ),
                    ],
                  ),
                ),
              );

            }),

            if (creditControllers.length < maxCourses)
              OutlinedButton.icon(
                onPressed: addCourse,
                icon: const Icon(Icons.add),
                label: const Text('Add Course'),
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
                onPressed: calculateSGPA,
                icon: const Icon(
                  Icons.calculate,
                  color: Colors.white,
                ),
                label: const Text(
                  'CALCULATE SGPA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D40), // darker teal
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
                onPressed: resetSGPA,
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




            const SizedBox(height: 20),

            if (sgpa != null)
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.teal.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Your SGPA',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sgpa!.toStringAsFixed(2),
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
