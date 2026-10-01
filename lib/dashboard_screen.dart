import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // TextField ka controller (user ka likha hua text yahan milta hai)
  final TextEditingController _noteController = TextEditingController();

  // Dummy data - koi API ya backend nahi
  final List<Map<String, String>> _courses = [
    {'code': 'CS-301', 'title': 'Data Structures', 'teacher': 'Dr. Usman Ali', 'credit': '3 CH'},
    {'code': 'CS-305', 'title': 'Database Systems', 'teacher': 'Ms. Ayesha Noor', 'credit': '3 CH'},
    {'code': 'CS-310', 'title': 'Operating Systems', 'teacher': 'Dr. Bilal Ahmed', 'credit': '3 CH'},
    {'code': 'MT-220', 'title': 'Linear Algebra', 'teacher': 'Mr. Hassan Raza', 'credit': '3 CH'},
    {'code': 'CS-315', 'title': 'Mobile App Development', 'teacher': 'Ms. Sana Iqbal', 'credit': '4 CH'},
    {'code': 'HU-201', 'title': 'Technical Writing', 'teacher': 'Mr. Farhan Saeed', 'credit': '2 CH'},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _submitNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) {
      _showMessage('Pehle kuch likhein');
      return;
    }
    _showMessage('Note saved: $text');
    _noteController.clear();
    FocusScope.of(context).unfocus(); // keyboard band
  }

  // ---------------------------------------------------------------- BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. HEADER: AppBar (title + drawer icon + search icon)
      appBar: AppBar(
        // Drawer hone par hamburger (menu) icon khud aa jata hai
        title: const Text('Campus Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showMessage('Search clicked'),
          ),
        ],
      ),
      drawer: _buildDrawer(),

      body: Column(
        children: [
          // Scrollable area: ID card + courses list
          Expanded(
            // 4. ListView.builder
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _courses.length + 1, // +1 = top par header (ID card)
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIdCard(),
                      const SizedBox(height: 24),
                      const Text(
                        'Enrolled Courses - Semester 5',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }
                final course = _courses[index - 1];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('$index')),
                    title: Text(course['title']!),
                    subtitle: Text('${course['code']}  •  ${course['teacher']}'),
                    trailing: Text(
                      course['credit']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),

          // 5. Bottom: Quick Notes input
          _buildNoteInput(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------- DRAWER
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Ahmed Khan'),
            accountEmail: Text('ahmed.khan@campus.edu.pk'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('AK', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          _drawerItem(Icons.person, 'My Profile'),
          _drawerItem(Icons.fact_check, 'Attendance'),
          _drawerItem(Icons.grade, 'Results'),
          _drawerItem(Icons.receipt_long, 'Fee Challan'),
          const Divider(),
          _drawerItem(Icons.logout, 'Logout'),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // drawer band
        _showMessage('$title opened');
      },
    );
  }

  // ------------------------------------------------------------ ID CARD
  Widget _buildIdCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Card ka top: University naam + icon
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CAMPUS UNIVERSITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(Icons.school, color: Colors.white),
              ],
            ),
            const Divider(color: Colors.white54, height: 24),

            // Middle: Avatar (left) + Details (right)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoItem('Name', 'Ahmed Khan'),
                      _infoItem('Roll No', '21-CS-045'),
                      _infoItem('Department', 'Computer Science'),
                      _infoItem('Semester', '5th'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Bottom: Validity + Badge
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Valid till: Dec 2027', style: TextStyle(color: Colors.white70)),
                Chip(
                  label: Text('STUDENT'),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 2. Stack: CircleAvatar + green online dot
  Widget _buildAvatar() {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 39,
            backgroundColor: Color(0xFF7986CB),
            child: Text(
              'AK',
              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
          ),
        ),
      ],
    );
  }

  // 3. Label (chota) + Value (bold) - Column ke andar
  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------- NOTE INPUT
  Widget _buildNoteInput() {
    return Material(
      elevation: 8,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    hintText: 'Quick note likhein...',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _submitNote,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
