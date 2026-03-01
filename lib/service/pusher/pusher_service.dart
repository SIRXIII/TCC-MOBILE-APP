import 'dart:developer';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'constants/pusher_config.dart';

class PusherService {
  /// Constants
  static final PusherService _instance = PusherService._internal();
  factory PusherService() => _instance;
  PusherService._internal();

  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  /// init
  Future<void> init({
    required Function(String event, dynamic data) onEvent,
  }) async {
    await _pusher.init(
      apiKey: PusherConfig.apiKey,
      cluster: PusherConfig.cluster,
      onConnectionStateChange: (currentState, previousState) {
        log('Pusher state: $currentState');
      },
      onError: (message, code, error) {
        log('Pusher error: $message');
      },
      onEvent: (event) {
        log('Event: ${event.eventName}');
        onEvent(event.eventName, event.data);
      },
    );
  }

  /// connect
  Future<void> connect() async {
    await _pusher.connect();
  }

  /// disconnect
  Future<void> disconnect() async {
    await _pusher.disconnect();
  }

  /// subscribe
  Future<void> subscribe(String channelName) async {
    await _pusher.subscribe(channelName: channelName);
  }

  /// unsubscribe
  Future<void> unsubscribe(String channelName) async {
    await _pusher.unsubscribe(channelName: channelName);
  }
}
