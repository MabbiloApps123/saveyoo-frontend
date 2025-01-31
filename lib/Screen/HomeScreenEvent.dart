abstract class HomeScreenEvent {}

class FetchDashboardInfo extends HomeScreenEvent {
  final String latitude;
  final String longitude;
  final String radius;

  FetchDashboardInfo(this.latitude, this.longitude, this.radius);
}
