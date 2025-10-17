// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class NativeAdFactoryExample extends NativeAdFactory {
//   @override
//   Widget buildNativeAd(
//     NativeAd nativeAd, {
//     required BuildContext context,
//     required NativeAdBuildConfiguration buildConfiguration,
//   }) {
//     return Container(
//       height: 300,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         children: [
//           // Ad badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: const Text(
//               'Ad',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
          
//           // Ad content
//           Expanded(
//             child: Row(
//               children: [
//                 // Icon/Image
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: nativeAd.icon == null 
//                       ? const Icon(Icons.ads_click, color: Colors.grey)
//                       : Image.network(nativeAd.icon!.uri.toString()),
//                 ),
//                 const SizedBox(width: 12),
                
//                 // Text content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       if (nativeAd.headline != null)
//                         Text(
//                           nativeAd.headline!,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       if (nativeAd.body != null)
//                         Text(
//                           nativeAd.body!,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       if (nativeAd.advertiser != null)
//                         Text(
//                           nativeAd.advertiser!,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
                
//                 // Call to action button
//                 if (nativeAd.callToAction != null)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       nativeAd.callToAction!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }