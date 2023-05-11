import 'dart:async';
import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/page_manager.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/widgets/placemark_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  final bool isFromDetail;
  final double? latitude;
  final double? longitude;
  final String? idStory;
  final Function(String storyId)? toBackDetailPage;
  final Function()? toBackPostStory;

  const MapsPage({
    super.key,
    required this.isFromDetail,
    this.toBackDetailPage,
    this.toBackPostStory,
    this.latitude,
    this.longitude,
    this.idStory,
  });

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with SingleTickerProviderStateMixin {
  final Set<Marker> markers = {};
  final Location location = Location();
  Completer<GoogleMapController> mapController = Completer();
  GeoData? placemark;
  LatLng locationLatLon = ConstantsName.baseLocationLatLon;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> fromTop;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
    animation = UtilHelper.initializeCurvedAnimation(controller);
    fromTop = UtilHelper.initializePositioned(controller, isFromTop: true);
    if (widget.isFromDetail) {
      locationLatLon = LatLng(
        widget.latitude!,
        widget.longitude!,
      );
    } else {
      onMyLocationButtonPress();
    }
    super.initState();
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: MarkerId("defineMakerLocation${markers.length + 1}"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    if (!mounted) return;
    setState(() {
      if (!widget.isFromDetail) markers.clear();
      markers.add(marker);
    });
  }

  void onTapMap(LatLng latLng) async {
    final GoogleMapController controller = await mapController.future;
    final place = await Geocoder2.getDataFromCoordinates(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      googleMapApiKey: 'AIzaSyAJJfTE-42dwSTG68U-XEfRTDYQKEKYYyg',
    );
    final address =
        '${place.city}, ${place.state}, ${place.postalCode}, ${place.country}';
    final marker = Marker(
      draggable: false,
      markerId: MarkerId("DataTap-${latLng.latitude}"),
      position: latLng,
      onTap: () {
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(
            latLng,
            18,
          ),
        );
      },
    );
    if (!mounted) return;
    setState(() {
      placemark = place;
      locationLatLon = latLng;
      markers.add(marker);
    });
    if (!kIsWeb) defineMarker(latLng, place.address, address);
    controller.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress() async {
    late LocationData locationData;
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    final GoogleMapController controller = await mapController.future;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        log("Location services is not available");
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );
    final place = await Geocoder2.getDataFromCoordinates(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      googleMapApiKey: 'AIzaSyAJJfTE-42dwSTG68U-XEfRTDYQKEKYYyg',
    );
    final address =
        '${place.city}, ${place.state}, ${place.postalCode}, ${place.country}';
    final marker = Marker(
      draggable: false,
      markerId: MarkerId("DataTap-${latLng.latitude}"),
      position: latLng,
      onTap: () {
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(
            latLng,
            18,
          ),
        );
      },
    );
    if (!mounted) return;
    setState(() {
      locationLatLon = latLng;
      placemark = place;
      markers.add(marker);
    });
    if (!kIsWeb) defineMarker(latLng, place.address, address);
    controller.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            onPressed: () {
              if (widget.isFromDetail) {
                widget.toBackDetailPage!(widget.idStory!);
              } else {
                widget.toBackPostStory!();
              }
            },
            iconSize: 24.sp,
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCustom.darkColor,
            ),
          ),
        ),
        title: Text(
          widget.isFromDetail ? translate.location : translate.chooseLocation,
          style: textTheme.labelLarge?.copyWith(
            fontSize: 24.sp,
          ),
        ),
        toolbarHeight: 58.h,
        centerTitle: true,
        actions: [
          if (!widget.isFromDetail)
            TextButton(
              onPressed: () {
                context.read<PageManager>().returnDataLocation(locationLatLon);
                widget.toBackPostStory!();
              },
              child: Text(
                translate.choose,
                textAlign: TextAlign.left,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeCustom.primaryColor,
                ),
              ),
            )
        ],
      ),
      body: FadeTransition(
        opacity: animation,
        child: SafeArea(
          child: Center(
            child: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  markers: markers,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    zoom: 18,
                    target: locationLatLon,
                  ),
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  onTap: (LatLng latLng) {
                    if (!widget.isFromDetail) onTapMap(latLng);
                  },
                  onMapCreated: (controller) async {
                    if (!mounted) return;
                    setState(() {
                      mapController.complete(controller);
                    });
                    if (widget.isFromDetail) onTapMap(locationLatLon);
                  },
                ),
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: SlideTransition(
                    position: fromTop,
                    child: FloatingActionButton(
                      backgroundColor: ThemeCustom.primaryColor,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        onMyLocationButtonPress();
                      },
                    ),
                  ),
                ),
                if (placemark == null)
                  const SizedBox()
                else
                  Positioned(
                    bottom: 36.h,
                    right: 16.w,
                    left: 16.w,
                    child: PlacemarkWidget(
                      placemark: placemark!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
