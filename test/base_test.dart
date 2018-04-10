import "dart:convert";
import 'package:grakn/grakn_rest.dart';
import 'package:test/test.dart';
import "package:logging/logging.dart" as logging;

var LOG_LEVEL = logging.Level.FINEST;

configureLogging(){
  logging.hierarchicalLoggingEnabled = true;
  logging.Logger.root.level = LOG_LEVEL;
  logging.Logger.root.onRecord.listen((logging.LogRecord rec) {
    print('${rec.time}, ${rec.loggerName}: ${rec.level.name}:  ${rec.message}'); // ${rec.time}:
  });
}

void main() {
  group('A group of tests', () {
    GraknREST grakn;

    setUp(() {
      configureLogging();
      grakn = new GraknREST(keyspace: 'test');
    });

    test('Match anything', () async {
      var rawString = await grakn.execute("match \$x isa thing; get;", throwExceptions: true);
      expect(rawString is String, isTrue);
      var rawList = JSON.decode(rawString);
      expect(rawList is List, isTrue);
    });

    test('Encodings', () async {
      var schema = "define Foo sub entity has bar; bar sub attribute datatype string;";
      var rawString = await grakn.execute(schema, throwExceptions: true);
      expect(rawString is String, isTrue);
      expect(rawString, equals("{}"));

      rawString = await grakn.execute("match \$x isa thing; delete \$x;", throwExceptions: true);

      String testString = "⏰📅👩‍💻";

      var insert = 'insert isa Foo, has bar "$testString";';
      rawString = await grakn.execute(insert, throwExceptions: true);
      expect(rawString is String, isTrue);
      expect(rawString, equals("[{}]"));

      var match = 'match \$Foo isa Foo has bar \$bar; get;';
      rawString = await grakn.execute(match, throwExceptions: true);
      expect(rawString is String, isTrue);
      var rawList = JSON.decode(rawString);
      expect(rawList is List, isTrue);
      Map entry = rawList.first;
      Map bar = entry["bar"];
      String returnedTestString = bar["value"];
      expect(returnedTestString, equals(testString));

    });
  });
}
