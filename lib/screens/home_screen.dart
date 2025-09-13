import 'package:flutter/material.dart';
import 'package:geny/reuseable_widgets/business_card.dart';
import 'package:geny/screens/details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/business_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BusinessProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BusinessProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1220),
        elevation: 0,
        title: const Text('Businesses', style: TextStyle(color: Colors.white)),
      ),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SearchBar(onChanged: (v) => provider.query = v),
            const SizedBox(height: 16),
            switch (provider.state) {
              ViewState.loading => const _StateMessage(label: 'Loading…'),
              ViewState.error => _ErrorState(
                message: provider.error ?? 'Something went wrong',
                onRetry: provider.load,
              ),
              ViewState.empty => const _StateMessage(
                label: 'No businesses yet',
              ),
              _ => _ResultsList(),
            },
          ],
        ),
      ),
    );
  }
}

///Search bar: in a porfessional App, this[and some other classes bellow] would be reueable componantes in a separate file.
class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onChanged});
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search by name or location',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1A1F36),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = context.watch<BusinessProvider>().items;
    if (items.isEmpty) {
      return const _StateMessage(label: 'No results for your search');
    }
    return Column(
      children: [
        for (final b in items) ...[
          BusinessCard(
            business: b,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailScreen(business: b)),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _StateMessage extends StatelessWidget {
  const _StateMessage({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StateMessage(label: message),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7A3AFF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
