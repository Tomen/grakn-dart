import "dart:convert";
import 'package:grakn/grakn.dart';

main() async {
  Grakn grakn = new Grakn();
  String query = "match \$x isa thing; get;";
  String rawString = await grakn.execute(query);
  List rawList = JSON.decode(rawString);
  print('awesome: $rawList');
}
