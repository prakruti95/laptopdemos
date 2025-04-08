import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await http.post(
          Uri.parse('https://prakrutitech.buzz/Fluttertestapi/signin.php'),
          body: {
            'email': event.email,
            'password': event.password,
          },
        );

        if (response.statusCode == 200) {
          final body = response.body.trim(); // Clean trailing newlines or spaces

          if (body == '0') {
            emit(LoginFailure(error: "Invalid email or password."));
          } else {
            final data = json.decode(body);

            if (data is Map<String, dynamic> && data['code'] == 200) {
              emit(LoginSuccess(message: "Login successful!"));
            } else {
              emit(LoginFailure(error: "Unexpected response format."));
            }
          }
        } else {
          emit(LoginFailure(error: "Server error: ${response.statusCode}"));
        }
      } catch (e) {
        emit(LoginFailure(error: "An error occurred: $e"));
      }
    });
  }
}
