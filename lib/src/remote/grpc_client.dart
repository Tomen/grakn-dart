part of grakn_remote;


class GrpcClient {

  GraknClient _stub;
  StreamController<TxRequest> _requestStreamController = new StreamController<TxRequest>();
  ResponseStream<TxResponse> _responseStream;

  GrpcClient(ClientChannel channel){
    _stub = new GraknClient(channel);
    _stub.tx(_requestStreamController.stream);
    _responseStream.listen(_onResponse);
  }

  _send(TxRequest request){
    _requestStreamController.add(request);
  }

  _onResponse(TxResponse response){

  }

  open(){
  }

}