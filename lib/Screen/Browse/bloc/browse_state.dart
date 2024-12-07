abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseLoadedState extends BrowseState {}

class GetBrowseNointernetState extends BrowseState {}

class GetBrowseInfoFailState extends BrowseState {}

class GetBrowseInfoSucessState extends BrowseState {}
