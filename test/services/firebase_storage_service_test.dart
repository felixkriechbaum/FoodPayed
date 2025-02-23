import 'package:flutter_test/flutter_test.dart';
import 'package:food_payed/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('FirebaseStorageServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
