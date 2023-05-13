import 'dart:async';

import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailPage extends StatefulWidget {
  final String idStory;
  final Function() toHomePage;
  final Function(StoriesModel dataStories) toMapPage;
  const DetailPage({
    super.key,
    required this.idStory,
    required this.toHomePage,
    required this.toMapPage,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Set<Marker> markers = {};
  GeoData? placemark;
  Completer<GoogleMapController> mapController = Completer();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoriesBloc>(context).add(
      GetDetailStories(id: widget.idStory),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.h),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
      ),
      body: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (context, state) {
          if (state is StoriesLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  SizedBox(height: 12.h),
                  Text(
                    translate.loading,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            );
          } else if (state is NoInternetState) {
            return WidgetCustom.stateError(
              context,
              isError: false,
              onPressed: () => bloc.add(
                GetDetailStories(id: widget.idStory),
              ),
            );
          } else if (state is StoriesErrorState) {
            if (UtilHelper.checkUnauthorized(state.error)) {
              BlocProvider.of<AuthBloc>(context).add(
                const LogoutAccountEvent(),
              );
            } else {
              return WidgetCustom.stateError(
                context,
                isError: true,
                message: translate.failed(translate.story.toLowerCase()),
                onPressed: () => bloc.add(
                  GetDetailStories(id: widget.idStory),
                ),
              );
            }
          } else if (state is GetDetailStoriesSuccessState) {
            final data = state.dataStories;
            final isAvalaibleLocation = data.lat != null && data.lon != null;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 0.4.sh,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: WidgetCustom.fadeInImageCustom(
                            isUrl: true,
                            image: data.photoUrl,
                          ),
                        ),
                        Positioned(
                          top: 16.h,
                          left: 16.w,
                          child: GestureDetector(
                            onTap: () => widget.toHomePage(),
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ).copyWith(top: 8.h),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 24.sp,
                            backgroundColor: ThemeCustom.secondaryColor,
                            child: Text(
                              UtilHelper.generateInitialText(data.name),
                              style: textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                UtilHelper.convertToAgo(
                                  context,
                                  data.createdAt,
                                ),
                                style: textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeCustom.secondaryColor,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        child: Text(
                          data.description,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                            color: ThemeCustom.darkColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    if (isAvalaibleLocation)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          translate.location,
                          style: textTheme.bodyLarge?.copyWith(
                            color: ThemeCustom.darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(height: 8.h),
                    if (placemark == null)
                      const SizedBox.shrink()
                    else
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 30.sp,
                              color: ThemeCustom.primaryColor,
                            ),
                            SizedBox(width: 8.w),
                            SizedBox(
                              width: 1.sw - 80.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    placemark?.address ?? '',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ThemeCustom.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10.h),
                    if (isAvalaibleLocation)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          height: 160.h,
                          width: 1.sw,
                          child: Stack(
                            children: [
                              GoogleMap(
                                markers: markers,
                                mapType: MapType.normal,
                                buildingsEnabled: true,
                                initialCameraPosition: CameraPosition(
                                  zoom: 18,
                                  target: LatLng(data.lat!, data.lon!),
                                ),
                                onMapCreated: (controller) async {
                                  await handleOnMapCreated(
                                    controller: controller,
                                    data: data,
                                  );
                                },
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                              ),
                              if (placemark == null)
                                const SizedBox.shrink()
                              else
                                Positioned(
                                  bottom: 18.h,
                                  right: 18.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          blurRadius: 14,
                                          offset: Offset.zero,
                                          color: Colors.grey.withOpacity(0.3),
                                        )
                                      ],
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () => widget.toMapPage(data),
                                      child: Text(
                                        translate.openMap,
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: ThemeCustom.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    if (!mounted) return;
    setState(() {
      markers.add(marker);
    });
  }

  handleOnMapCreated({
    required GoogleMapController controller,
    required StoriesModel data,
  }) async {
    final marker = Marker(
      draggable: false,
      markerId: MarkerId(data.id),
      position: LatLng(data.lat!, data.lon!),
      onTap: () {
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(data.lat!, data.lon!),
            18,
          ),
        );
      },
    );
    final place = await UtilHelper.getLocation(
      lat: data.lat!,
      lon: data.lon!,
    );
    final address =
        '${place.city}, ${place.state}, ${place.postalCode}, ${place.country}';
    if (!kIsWeb) {
      defineMarker(
        LatLng(data.lat!, data.lon!),
        place.streetNumber,
        address,
      );
    }
    if (!mounted) return;
    setState(() {
      mapController.complete(controller);
      placemark = place;
      markers.add(marker);
    });
  }
}
