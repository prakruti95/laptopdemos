import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDashboard>(_onFetchDashboard);
  }

  Future<void> _onFetchDashboard(
      FetchDashboard event,
      Emitter<DashboardState> emit,
      ) async {
    emit(DashboardLoading());

    try {
      final response = await http.get(
        Uri.parse('https://prakrutitech.buzz/AndroidAPI/dashboard_view.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final items = data.map((e) => DashboardItem.fromJson(e)).toList();
        emit(DashboardLoaded(items));
      } else {
        emit(DashboardError("Failed to load dashboard data"));
      }
    } catch (e) {
      emit(DashboardError("Error: $e"));
    }
  }
}
