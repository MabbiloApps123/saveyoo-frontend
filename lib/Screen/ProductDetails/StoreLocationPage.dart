import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saveyoo/Model/ProductsResponse.dart';
import 'package:saveyoo/Screen/OnboardingScreen/size_config.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_bloc.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_event.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_state.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/localization/language/languages.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/MyColor.dart';
import '../../Widgets/no_internet.dart';
import '../../utils/pref_manager.dart';

class StoreLocationPage extends StatefulWidget {
  const StoreLocationPage({super.key});

  @override
  State<StoreLocationPage> createState() => _StoreLocationPageState();
}

class _StoreLocationPageState extends State<StoreLocationPage> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  late PageController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  var items = <Product>[];

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
    BlocProvider.of<ProductdetailsBloc>(context).add(SetProductdetails());
    setState(() {
      loadPrefs();
    });
    // loadUsers();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> loadPrefs() async {
    print("Second PAge");
    //mIsLogin = await storageService.getBool(Constant.MLOGINSTATUS) ?? false;
  }

  void OnLoadNext() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: mBackgroundColor,
      body: BlocConsumer<ProductdetailsBloc, ProductdetailsState>(
        listener: (context, state) {
          // if (state is GetOnboardingInfoSucessState) {}
        },
        builder: (context, state) {
          print(state);
          if (state is ProductdetailsLoadingState) {
            Loading(mLoaderGif).start(context);
          } else if (state is GetProductdetailsInfoSucessState) {
            Loading.stop();
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  size: 20,
                                  color: Colors.black,
                                  Icons.arrow_back,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, productdetailsRoute);
                                },
                              ),
                              Text(
                                Languages.of(context)!.recommendedmsg,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "PlusJakartaSansSemiBold",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: CircleAvatar(
                                  radius: 20,
                                  child: ClipOval(
                                    child: Image.network(
                                      "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansSemiBold',
                                          fontSize: 13.sp,
                                          color: mGrey),
                                    ),
                                    Text(
                                      "Chennai",
                                      style: TextStyle(
                                          fontFamily: 'PlusJakartaSansMedium',
                                          fontSize: 11.sp,
                                          color: mGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Divider(),
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading:
                                Icon(Icons.location_on, color: mPrimaryColor),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '10 Place de l\'Université Centre commercial...',
                                  style: TextStyle(
                                    color: mPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'PlusJakartaSansMedium',
                                  ),
                                ),
                                SizedBox(height: 6), // Adjust the gap here
                                Text(
                                  'Click for directions',
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSansRegular',
                                      fontSize: 12,
                                      color: mGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildSurpriseBagsSection(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildAboutSection(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildMapSection(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: Colors.white,
                      child: _buildMoreInfoSection(context),
                    )
                  ],
                ),
              ),
            );
          } else if (state is GetProductdetailsNointernetState) {
            Loading.stop();
            return SafeArea(child: NoInternet());
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSurpriseBagsSection(BuildContext context) {
    List<Map<String, String>> surpriseBags = [
      {
        'title': 'Panier Surprise',
        'time': 'Today 8:45 PM - 9:45 PM',
        'price': '\u20ac 5.99',
        'imagePath': 'assets/app_icon.png',
      },
      {
        'title': 'Panier Sandwich',
        'time': 'Today 8:00 PM - 9:45 PM',
        'price': '\u20ac 4.99',
        'imagePath': 'assets/app_icon.png',
      },
    ];

    if (surpriseBags.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('No surprise bags available'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Surprise Bags from this store',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: surpriseBags.length,
              itemBuilder: (context, index) {
                final bag = surpriseBags[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: _buildSurpriseBagItem(
                    bag['title']!,
                    bag['time']!,
                    bag['price']!,
                    bag['imagePath']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurpriseBagItem(
      String title, String time, String price, String imagePath) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: Image.network(
                "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(time, style: TextStyle(color: Colors.grey)),
            Text(price,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Delitraiteur se positionne comme le spécialiste de la solution repas. Nous vous proposons un large éventail de plats préparés, de sandwiches, de salades et de produits prêts à cuisiner (fruits, légumes, viandes).',
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBadge('3+ years', 'Fighting food waste'),
              _buildBadge('7,500+', 'Meals saved'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String title, String subtitle) {
    return Column(
      children: [
        Icon(Icons.verified, size: 40, color: Colors.green),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(50.717488, 4.607621),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('storeLocation'),
            position: LatLng(50.717488, 4.607621),
          ),
        },
      ),
    );
  }

  Widget _buildMoreInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Info',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.public, size: 20, color: Colors.grey),
              SizedBox(width: 8),
              TextButton(
                onPressed: () {},
                child: Text('http://www.delitraiteur.com/'),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.info, size: 20, color: Colors.grey),
              SizedBox(width: 8),
              Text('VAT no.: BE0758401032'),
            ],
          )
        ],
      ),
    );
  }
}

class SortText extends StatelessWidget {
  const SortText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Text(menuname,
        style: const TextStyle(
            fontFamily: 'PlusJakartaSansMedium', fontSize: 16, color: mGrey));
  }
}
