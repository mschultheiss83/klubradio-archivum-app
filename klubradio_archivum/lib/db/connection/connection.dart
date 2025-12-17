export 'connection_stub.dart'
    if (dart.library.html) 'connection_web.dart'
    if (dart.library.io) 'connection_native.dart';
