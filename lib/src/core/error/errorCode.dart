enum ErrorCode {
  DEFAULT("Something went wrong"),
  SOCKET_ERROR(
      "Cannot connect to server. Make sure you have proper internet connection"),
  CONNECT_TIME_OUT_ERROR("Connnection timeout"),
  SEND_TIME_OUT_ERROR("Send timeout"),
  RECEIVE_TIME_OUT_ERROR("Receive timeout"),
  REQUEST_CANCEL_ERROR("Cancelled request"),
  RESPONSE_MESSAGE(""),
  CAST_ERROR("Cast error while mapping"),
  API_EXCEPTION("API EXCEPTION"),
  EXCEPTION("Exception: ");

  const ErrorCode(this.value);
  final String value;
}
