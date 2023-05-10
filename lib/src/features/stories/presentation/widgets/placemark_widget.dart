import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoder2/geocoder2.dart';

class PlacemarkWidget extends StatelessWidget {
  final GeoData? placemark;
  const PlacemarkWidget({
    super.key,
    required this.placemark,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 14,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.7),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            size: 30.sp,
            color: ThemeCustom.primaryColor,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              placemark!.address,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
