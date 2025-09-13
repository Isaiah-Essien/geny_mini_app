import 'package:flutter/material.dart';
import '../core/models/business.dart';
import 'item_card.dart';


/// A reusable card specifically for rendering [Business] models.
class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key, required this.business, this.onTap});
  final Business business;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ItemCard<Business>(
      item: business,
      title: (b) => b.name,
      subtitle: (b) => '${b.location} • ${b.phone.isEmpty ? 'N/A' : b.phone}',
      leading: (_) => const Icon(Icons.storefront, color: Colors.white),
      trailing: (_) => const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap,
    );
  }
}

/// Example of reusing the same shell for a different model
class Service {
  final String title;
  final String city;
  Service(this.title, this.city);
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    return ItemCard<Service>(
      item: service,
      title: (s) => s.title,
      subtitle: (s) => s.city,
      leading: (_) => const Icon(Icons.design_services, color: Colors.white),
    );
  }
}
