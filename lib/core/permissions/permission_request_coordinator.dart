class PermissionRequestCoordinator {
  PermissionRequestCoordinator._();

  static int _activeLocationRequests = 0;

  static Future<T> runLocationRequest<T>(Future<T> Function() action) async {
    _activeLocationRequests++;
    try {
      return await action();
    } finally {
      _activeLocationRequests = _activeLocationRequests > 0
          ? _activeLocationRequests - 1
          : 0;
    }
  }

  static Future<void> waitForLocationRequestsToFinish() async {
    while (_activeLocationRequests > 0) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
}
