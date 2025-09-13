import 'package:flutter/material.dart';
import '../core/models/business.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.business});
  final Business business;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1220),
        title: const Text('Details', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              business.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _chip(label: business.location, icon: Icons.place),
            const SizedBox(height: 8),
            _chip(
              label: business.phone.isEmpty ? 'N/A' : business.phone,
              icon: Icons.phone,
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message),
              label: const Text('Contact'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: const Color(0xFF7A3AFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip({required String label, required IconData icon}) {
    return Chip(
      avatar: Icon(icon, color: Colors.white70, size: 18),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF1A1F36),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }
}
