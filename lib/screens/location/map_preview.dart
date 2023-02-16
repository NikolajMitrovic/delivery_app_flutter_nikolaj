// // ignore_for_file: avoid_print

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPreview extends StatefulWidget {
//   final double? initialLatitude;
//   final double? initialLongitude;
//   final bool showFullScreenIcon;
//   final void Function()? onTapFullScreen;
//   final bool showCloseIcon;
//   final void Function()? onTapClose;
//   final bool zoomControlsEnabled;
//   final void Function(LatLng latLng)? onTap;
//   // final bool showApplyButton;
//   final void Function()? onTapChangeMapType;
//   final bool changeMapType;
//   final bool useInitialCameraPosition;
//   final double zoom;
//   final bool myLocationEnabled;
//   final Widget? cornerWidget;
//   final double? height;
//   final bool? showObjectPreviews;

//   const MapPreview({
//     Key? key,
//     // this.showApplyButton = false,
//     this.initialLatitude,
//     this.initialLongitude,
//     this.showFullScreenIcon = true,
//     this.onTapFullScreen,
//     this.showCloseIcon = false,
//     this.onTapClose,
//     this.zoomControlsEnabled = true,
//     this.onTap,
//     this.onTapChangeMapType,
//     this.changeMapType = false,
//     this.useInitialCameraPosition = false,
//     this.zoom = 14.0,
//     this.myLocationEnabled = true,
//     this.cornerWidget,
//     this.height,
//     this.showObjectPreviews = true,
//   }) : super(key: key);

//   @override
//   _MapPreviewState createState() => _MapPreviewState();
// }

// class _MapPreviewState extends State<MapPreview> with WidgetsBindingObserver {
//   late BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
//   // late String _mapStyle;
//   final Completer<GoogleMapController> _controllerCompleter = Completer();

//   LatLng get initialCameraPosition {
//     if (widget.initialLatitude != null && widget.initialLongitude != null) {
//       return LatLng(widget.initialLatitude!, widget.initialLongitude!);
//     }

//     return const LatLng(0, 0);
//   }

//   @override
//   void initState() {
//     super.initState();
//     // setCustomPin();
//     WidgetsBinding.instance.addObserver(this);
//     // rootBundle.loadString(AppAssets.googleMapsMapStyle).then((string) => _mapStyle = string);
//   }

//   MapType _currentMapType = MapType.normal;
//   void _toggleMapType() {
//     setState(() {
//       _currentMapType = (_currentMapType == MapType.normal) ? MapType.satellite : MapType.normal;
//     });
//   }

//   // Future<void> setCustomPin() async {
//   // final icon = await BitmapDescriptor.fromAssetImage(
//   //   const ImageConfiguration(size: Size(50, 50)),
//   //   AppAssets.pin,
//   // );

//   // setState(() {
//   //   customMarker = icon;
//   // });
//   // }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.resumed) {
//   //     if (_controllerCompleter.isCompleted) {
//   //       _controllerCompleter.future.then((controller) {
//   //         controller.setMapStyle(_mapStyle);
//   //       });
//   //     }
//   //   }
//   // }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           GoogleMap(
//             key: widget.key,
//             onTap: widget.onTap,
//             compassEnabled: false,
//             mapToolbarEnabled: false,
//             myLocationEnabled: true,
//             zoomControlsEnabled: widget.zoomControlsEnabled,
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(
//               target: initialCameraPosition,
//               zoom: widget.zoom,
//             ),
//             onMapCreated: _onMapCreated,
//           ),
//           widget.cornerWidget ??
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 child: IconButton(
//                   icon: Icon(Icons.close),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ),
//           () {
//             // if (widget.showFullScreenIcon) {
//             //   return Positioned(
//             //     top: 0,
//             //     right: 0,
//             //     child: Container(
//             //       margin: const EdgeInsets.all(13),
//             //       child: PhysicalModel(
//             //         elevation: 1,
//             //         color: Colors.white,
//             //         child: Splashable(
//             //           onTap: widget.onTapFullScreen ??
//             //               () {
//             //                 context.navigator().pushPage(
//             //                       MapPreview(
//             //                         initialLatitude: widget.initialLatitude,
//             //                         initialLongitude: widget.initialLongitude,
//             //                         showFullScreenIcon: false,
//             //                         showCloseIcon: true,
//             //                         onTapClose: widget.onTapClose,
//             //                         onTap: widget.onTap,
//             //                         zoomControlsEnabled: widget.zoomControlsEnabled,
//             //                       ),
//             //                     );
//             //               },
//             //           child: const Padding(
//             //             padding: EdgeInsets.all(6.5),
//             //             child: Icon(Icons.fullscreen),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   );
//             // }
//             // if (widget.showApplyButton) {
//             //   return Positioned(
//             //     bottom: 30,
//             //     child: Container(
//             //       height: 50,
//             //       width: context.screenWidth,
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.center,
//             //         children: [
//             //           Padding(
//             //             padding: const EdgeInsets.only(right: 30),
//             //             child: Button(
//             //               onTap: () => context.navigator.pop(),
//             //               rounded: true,
//             //               color: Colors.white,
//             //               child: Row(
//             //                 mainAxisAlignment: MainAxisAlignment.center,
//             //                 children: const [
//             //                   Icon(
//             //                     Icons.pin_drop,
//             //                     color: Colors.black,
//             //                   ),
//             //                   SizedBox(width: 5),
//             //                   Text(
//             //                     'Apply location',
//             //                     style: TextStyle(color: Colors.black),
//             //                   ),
//             //                 ],
//             //               ),
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //   );
//             // return Positioned(
//             //   bottom: 48,
//             //   left: 100,
//             //   right: 100,
//             //   child: PhysicalModel(
//             //     elevation: 1,
//             //     color: Colors.white,
//             //     child: Splashable(
//             //       onTap: () => context.pop(),
//             //       child: const Padding(
//             //         padding: EdgeInsets.all(6.5),
//             //         child: Button(
//             //           text: 'Apply location',
//             //           color: Colors.white,
//             //           textColor: Colors.black,
//             //           shrinkWrap: false,
//             //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             //           rounded: true,
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // );
//             // }

//             if (widget.changeMapType) {
//               return Positioned(
//                 left: 0,
//                 top: 0,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: PhysicalModel(
//                     elevation: 1,
//                     borderRadius: BorderRadius.circular(50),
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: InkWell(
//                         onTap: _toggleMapType,
//                         child: const Icon(
//                           Icons.map,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }

//             if (widget.showCloseIcon) {
//               return Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Container(
//                   margin: const EdgeInsets.all(13),
//                   child: PhysicalModel(
//                     elevation: 1,
//                     color: Colors.white,
//                     child: TextButton(
//                       onPressed: widget.onTapClose ?? () => Navigator.of(context).pop(),
//                       child: const Padding(
//                         padding: EdgeInsets.all(6.5),
//                         child: Icon(Icons.close),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }

//             return Container();
//           }()
//         ],
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     // controller.setMapStyle(_mapStyle);

//     if (!_controllerCompleter.isCompleted) {
//       _controllerCompleter.complete(controller);
//     }
//   }
// }
