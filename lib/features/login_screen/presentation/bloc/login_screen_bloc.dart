import 'package:bloc/bloc.dart';
import 'package:beep/features/login_screen/domain/entity/entry_request_entity.dart';
import 'package:beep/features/login_screen/domain/entity/otp_response_entity.dart';
import 'package:beep/features/login_screen/domain/entity/response_entry_entity.dart';
import 'package:beep/features/login_screen/domain/usecase/entry_usecase.dart';
import 'package:beep/utils/errors/exceptions.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:equatable/equatable.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final EntryUseCase entryUseCase;
  final OtpVerifyUse otpVerifyUse;
  LoginScreenBloc({required this.entryUseCase, required this.otpVerifyUse})
      : super(MoblieNumberScreenState()) {
    on<EntryEvent>((event, emit) async {
      // Call UseCase
      try {
        EntryResponseEntity data = await entryUseCase.call(
            params: EntryRequestEntity(phonenumber: event.number));
        print("response $data");
        emit(OtpScreenState(number: data.message!));
      } catch (err) {
        emit(ErrorState(errmessage: err.toString()));
      }
    });
    on<OtpEvent>(
      (event, emit) async {
        try {
          OtpResponseEntity data = await otpVerifyUse.call(
              params: OTPRequestEntity(
                  phonenumber: event.number,
                  otp: event.otp,
                  token: event.token));
          print("response $data");
          sharedPrefs.setstatusKey("Online");
          sharedPrefs.setid(data.data?.id ?? "");
          sharedPrefs.setname(data.data?.name ?? "");

          emit(SuccessState(
              isexpired: data.message != null ? true : false,
              newaccount: data.newAccount ?? false,
              token: data.data!.token ?? ""));
        } catch (err) {
          if (err is NotProperBody) {
            emit(ErrorState(errmessage: err.message));
          }
        }
      },
    );
    on<ResetEvent>(
      (event, emit) {
        emit(MoblieNumberScreenState());
      },
    );
  }
}
