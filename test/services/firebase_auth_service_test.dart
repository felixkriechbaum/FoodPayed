import 'package:flutter_test/flutter_test.dart';
import 'package:food_payed/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('FirebaseAuthServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
