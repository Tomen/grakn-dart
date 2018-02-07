import "dart:convert";
import 'package:grakn/grakn.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Grakn grakn;

    setUp(() {
      grakn = new Grakn();
    });

    test('Match anything', () async {
      var rawString = await grakn.execute("match \$x isa thing; get;");
      expect(rawString is String, isTrue);
      var rawList = JSON.decode(rawString);
      expect(rawList is List, isTrue);
    });
  });
}
