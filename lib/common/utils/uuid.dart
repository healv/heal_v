import 'package:uuid/uuid.dart';

const _uuid = Uuid();

String randomUUID() => _uuid.v4();
