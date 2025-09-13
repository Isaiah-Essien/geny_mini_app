import 'package:flutter/foundation.dart';
import '../core/models/business.dart';
import '../core/repository/business_repository.dart';


// Simple state management for the business list screen. I think seprating this Viewstate into a list of enums is a good idea. Might chnage later, by calling them constants.
enum ViewState { idle, loading, empty, error }

class BusinessProvider extends ChangeNotifier {
  BusinessProvider(this._repo);
  final BusinessRepository _repo;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String? _error;
  String? get error => _error;

  List<Business> _items = [];
  List<Business> get items => _query.isEmpty
      ? _items
      : _items
            .where(
              (b) =>
                  b.name.toLowerCase().contains(_query) ||
                  b.location.toLowerCase().contains(_query),
            )
            .toList();

  String _query = '';
  set query(String v) {
    _query = v.toLowerCase().trim();
    notifyListeners();
  }

  Future<void> load() async {
    _error = null;
    _state = ViewState.loading;
    notifyListeners();
    try {
      final data = await _repo.fetchBusinesses();
      _items = data;
      _state = _items.isEmpty ? ViewState.empty : ViewState.idle;
    } catch (e) {
      _error = e.toString();
      _state = ViewState.error;
    }
    notifyListeners();
  }
}
