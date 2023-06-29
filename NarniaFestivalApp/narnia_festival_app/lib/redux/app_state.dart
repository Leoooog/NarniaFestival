import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_state.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_state.dart';
import 'package:narnia_festival_app/redux/evento/evento_state.dart';
import 'package:narnia_festival_app/redux/pages/tab_state.dart';
import 'package:narnia_festival_app/redux/prenotazione/prenotazione_state.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_state.dart';
import 'package:narnia_festival_app/redux/utente/utente_state.dart';
import 'package:narnia_festival_app/redux/verify_email/verify_email_state.dart';

class AppState extends Equatable {
  final AuthenticationState authenticationState;
  final BuonoPastoState buonoPastoState;
  final EventoState eventoState;
  final RistoranteState ristoranteState;
  final PrenotazioneState prenotazioneState;
  final UtenteState utenteState;
  final VerifyEmailState verifyEmailState;
  final TabState tabState;

  @override
  List<Object?> get props => [
        authenticationState,
        buonoPastoState,
        eventoState,
        prenotazioneState,
        utenteState,
        verifyEmailState,
        tabState
      ];

  const AppState(
      {required this.authenticationState,
      required this.buonoPastoState,
      required this.eventoState,
      required this.ristoranteState,
      required this.prenotazioneState,
      required this.utenteState,
      required this.verifyEmailState,
      required this.tabState});

  factory AppState.initial() {
    return AppState(
        authenticationState: AuthenticationState.initial(),
        buonoPastoState: BuonoPastoState.initial(),
        eventoState: EventoState.initial(),
        ristoranteState: RistoranteState.initial(),
        prenotazioneState: PrenotazioneState.initial(),
        utenteState: UtenteState.initial(),
        verifyEmailState: VerifyEmailState.initial(),
        tabState: TabState.initial());
  }

  AppState copyWith(
      {AuthenticationState? authenticationState,
      BuonoPastoState? buonoPastoState,
      EventoState? eventoState,
      RistoranteState? ristoranteState,
      PrenotazioneState? prenotazioneState,
      UtenteState? utenteState,
      VerifyEmailState? verifyEmailState,
      TabState? pageIndex}) {
    return AppState(
        authenticationState: authenticationState ?? this.authenticationState,
        buonoPastoState: buonoPastoState ?? this.buonoPastoState,
        eventoState: eventoState ?? this.eventoState,
        ristoranteState: ristoranteState ?? this.ristoranteState,
        prenotazioneState: prenotazioneState ?? this.prenotazioneState,
        utenteState: utenteState ?? this.utenteState,
        verifyEmailState: verifyEmailState ?? this.verifyEmailState,
        tabState: pageIndex ?? this.tabState);
  }

  @override
  String toString() {
    return 'AppState{authenticationState: $authenticationState, buonoPastoState: $buonoPastoState, eventoState: $eventoState, ristoranteState: $ristoranteState, prenotazioneState: $prenotazioneState, utenteState: $utenteState, verifyEmailState: $verifyEmailState, tabState: $tabState}';
  }
}
