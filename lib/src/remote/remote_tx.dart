part of grakn_remote;

class RemoteTx {

  GrpcClient _client;

  RemoteTx(TxRequest openRequest, ClientChannel channel){
    _client = new GrpcClient(channel);
    _client.open(openRequest);
  }
}