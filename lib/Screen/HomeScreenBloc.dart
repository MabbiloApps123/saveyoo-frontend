import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/HomeScreenEvent.dart';
import 'package:saveyoo/Screen/HomeScreenState.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  // final BuildContext mContext; {required this.mContext}
  HomeScreenBloc() : super(HomeInitial()) {
    on<FetchDashboardInfo>((event, emit) async {
      emit(HomeLoading());

      try {
        // Simulate API call or fetch logic
        await Future.delayed(Duration(seconds: 2)); // Simulating a delay
        final fetchedData =
            "Sample dashboard data"; // Replace with real API call
        emit(HomeLoaded(fetchedData));
      } catch (e) {
        emit(HomeError("Failed to fetch data"));
      }
    });
  }
}
