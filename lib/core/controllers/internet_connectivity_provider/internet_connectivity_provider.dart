import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connectivity_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<ConnectivityResult>> internetConnectivity(
    InternetConnectivityRef ref) {
  return Connectivity().onConnectivityChanged;
}
