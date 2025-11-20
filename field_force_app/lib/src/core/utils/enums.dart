enum SyncStatus { pending, synced, failed }

enum VisitStatus { planned, inProgress, completed, cancelled }

enum ActivityType { note, discussion, product }

extension SyncStatusX on SyncStatus {
  String get label {
    switch (this) {
      case SyncStatus.pending:
        return 'Pending';
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.failed:
        return 'Failed';
    }
  }
}

extension VisitStatusX on VisitStatus {
  String get label {
    switch (this) {
      case VisitStatus.planned:
        return 'Planned';
      case VisitStatus.inProgress:
        return 'In Progress';
      case VisitStatus.completed:
        return 'Completed';
      case VisitStatus.cancelled:
        return 'Cancelled';
    }
  }
}
