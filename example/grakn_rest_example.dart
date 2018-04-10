import "dart:convert";
import 'package:grakn/grakn_rest.dart';

main() async {
  GraknREST grakn = new GraknREST();
  String query = "match \$x isa thing; get;";
  String rawString = await grakn.execute(query);
  List rawList = JSON.decode(rawString);
  print('awesome: $rawList');
}
