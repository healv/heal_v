import 'package:flutter/foundation.dart';

const String buildVariant = kDebugMode
    ? 'debug'
    : kProfileMode
        ? 'profile'
        : 'release';
