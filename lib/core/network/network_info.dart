import 'package:data_connection_checker/data_connection_checker.dart';


// Is wrapping connectionChecker in this custom interface
// and implementation worth the work?
//
// Should that be done with ALL third-party libraries?
// Meaning, don't use them directly in repositories, but
// always wrap in custom interface/implementation that just
// forwards the calls?
//
// According to Reso Coder, yes, it is worth it, recommended,
// and you should do it.
//
// see: https://www.youtube.com/watch?v=xWl7GzMDiwg

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}