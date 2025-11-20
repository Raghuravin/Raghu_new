import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../customers/application/customer_providers.dart';
import '../../visits/application/visit_providers.dart';
import '../../../core/utils/enums.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  static const routePath = '/map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visits = ref.watch(visitsStreamProvider);
    final customers = ref.watch(customersStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Map Tracking')),
      body: visits.when(
        data: (visitItems) {
          return customers.when(
            data: (customerItems) {
              if (visitItems.isEmpty && customerItems.isEmpty) {
                return const Center(child: Text('No visits planned today.'));
              }
              final markers = <Marker>{};

              for (final customer in customerItems) {
                markers.add(
                  Marker(
                    markerId: MarkerId('customer-${customer.localId}'),
                    position: LatLng(customer.latitude, customer.longitude),
                    infoWindow: InfoWindow(
                      title: customer.name,
                      snippet:
                          'Pending activities: ${customer.pendingActivities}',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  ),
                );
              }

              for (final visit in visitItems.where(
                (visit) =>
                    visit.status == VisitStatus.completed &&
                    visit.checkInLatitude != null,
              )) {
                markers.add(
                  Marker(
                    markerId: MarkerId('visit-${visit.localId}'),
                    position: LatLng(
                      visit.checkInLatitude!,
                      visit.checkInLongitude!,
                    ),
                    infoWindow: InfoWindow(
                      title: visit.customerLocalId,
                      snippet: visit.status.label,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen,
                    ),
                  ),
                );
              }

              final target = markers.isNotEmpty
                  ? markers.first.position
                  : const LatLng(37.7749, -122.4194);

              return GoogleMap(
                initialCameraPosition: CameraPosition(target: target, zoom: 11),
                markers: markers,
                myLocationEnabled: true,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
