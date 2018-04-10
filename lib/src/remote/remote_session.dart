part of grakn_remote;

const String DEFAULT_HOST = 'localhost';
const int DEFAULT_PORT = 48555;
const String DEFAULT_KEYSPACE = 'grakn';

class GraknRemoteSession {

  String keyspace;

  ClientChannel _channel;

  GraknRemoteSession(
      {String host = DEFAULT_HOST,
        int port = DEFAULT_PORT,
        this.keyspace = DEFAULT_KEYSPACE
      }){
    _channel = new ClientChannel(host,
        port: port,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
  }

  RemoteTx open(GraknTxType type){
    var keyspace = Keyspace.create();
    keyspace.value = this.keyspace;
    var open = Open.create();
    open.keyspace = keyspace;
    var txRequest = TxRequest.create();
    txRequest.open = open;
    var remoteTx = new RemoteTx(txRequest, _channel);
    return remoteTx;
  }

  close(){
    _channel.shutdown();
  }

}