part of 'package:aveomap/aveomap.dart';

///AutocompleteService.getPlacePredictions() uses session tokens to group together autocomplete requests for billing purposes.
///
///Session tokens group the query and selection phases of a user autocomplete search into a discrete session for billing purposes.
///
///The session begins when the user starts typing a query, and concludes when they select a place.
///
///Each session can have multiple queries, followed by one place selection.
///
///Once a session has concluded, the token is no longer valid. Your app must generate a fresh token for each session.
///
///We recommend using session tokens for all autocomplete sessions.
///
///If the sessionToken parameter is omitted, or if you reuse a session token, the session is charged as if no session token was provided (each request is billed separately).
///
///

///You can use the same session token to make a single Place Details request on the place that results from a call to AutocompleteService.getPlacePredictions().
///
///In this case, the autocomplete request is combined with the Place Details request, and the call is charged as a regular Place Details request.
///
///There is no charge for the autocomplete request.
///
///

///Be sure to pass a unique session token for each new session.
///
///Using the same token for more than one Autocomplete session will invalidate those Autocomplete sessions, and all Autocomplete request in the invalid sessions will be charged individually using Autocomplete Per Request SKU.
class SessionUUID {
  SessionUUID._instance();
  static SessionUUID get instance => SessionUUID._instance();
  factory SessionUUID() {
    makeNew();
    return instance;
  }

  static String _sessionId = '';
  String get sessionId {
    return _sessionId;
  }

  static const Uuid _uuid = Uuid();

  static String makeNew() {
    return _sessionId = _uuid.v4();
  }
}
