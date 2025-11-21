import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/visit.dart';
import '../../../domain/usecases/usecase_providers.dart';

final visitsStreamProvider = StreamProvider<List<VisitEntity>>((ref) {
  final useCase = ref.watch(watchVisitsUseCaseProvider);
  return useCase();
});

final selectedVisitProvider = Provider.family<AsyncValue<VisitEntity?>, String>(
  (ref, id) {
    final visits = ref.watch(visitsStreamProvider);
    return visits.whenData(
      (list) => list.firstWhereOrNull((visit) => visit.localId == id),
    );
  },
);
