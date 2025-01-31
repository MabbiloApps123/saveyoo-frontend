abstract class DeliveryState {}

class DeliveryInitialState extends DeliveryState {}

class DeliveryLoadingState extends DeliveryState {}

class DeliveryLoadedState extends DeliveryState {}

class GetDeliveryNointernetState extends DeliveryState {}

class GetDeliveryInfoFailState extends DeliveryState {}

class GetDeliveryInfoSucessState extends DeliveryState {}
