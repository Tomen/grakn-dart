# grakn-dart

A Grakn REST API connector for the Grakn hyper-relational graph database.

Tested with Grakn 1.0 and 1.1

## Usage

A simple usage example:

    import "dart:convert";
    import 'package:grakn/grakn.dart';

    main() async {
        Grakn grakn = new Grakn();
        String rawString = await grakn.execute("match \$x isa thing; get;");
        List rawList = JSON.decode(rawString);
        print('awesome: $rawList');
    }


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Tomen/grakn-node/issues
