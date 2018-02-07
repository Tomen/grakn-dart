import "dart:convert";
import 'package:grakn/grakn.dart';

main() async {
  Grakn grakn = new Grakn();
  String rawString = await grakn.execute("match \$x isa thing; get;");
  List rawList = JSON.decode(rawString);
  print('awesome: $rawList');
}
