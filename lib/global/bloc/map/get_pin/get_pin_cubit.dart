import 'package:base_project/env.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/common/data_response.dart';
import '../../../model/pin/model_response_pin.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';

part 'get_pin_state.dart';

class GetPinCubit extends Cubit<GetPinState> {
  GetPinCubit() : super(GetPinInitial());

  Future<void> getPin(String pinId) async {
    try {
      emit(GetPinLoading());

      final dio = Dio(); // Provide a dio instance
      // dio.options.headers["Demo-Header"] = "demo header";
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));

      DataResponse<ModelResponsePin> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).getPin(pinId);

      if (response.success == false) {
        emit(
          GetPinError(errorMessage: response.error ?? 'get pin error'),
        );
      } else {
        emit(GetPinLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        GetPinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
  // Future<void> getPin(String pinId) async {
  //   try {
  //     emit(GetPinLoading());

  //     ApiResponse<ModelResponseGetPin> response = await PinRepository.instance.getPin(pinId);

  //     if (response.status == ResponseStatus.error) {
  //       emit(
  //         GetPinError(errorMessage: response.message ?? 'get pin error'),
  //       );
  //     } else {
  //       emit(GetPinLoaded(result: response.data!));
  //     }
  //   } catch (e) {
  //     emit(
  //       GetPinError(
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // Future<void> setPinLike(ModelRequestSetPinLike modelRequestSetPinLike, bool isLiked) async {
  //   try {
  //     // emit(SetPinLikeLoading());

  //     ApiResponse<bool> response = await LikeRepository.instance.setPinLike(modelRequestSetPinLike);
  //     if (response.status == ResponseStatus.error) {
  //       emit(
  //         GetPinError(errorMessage: response.message ?? 'create pin like error'),
  //       );
  //     } else {
  //       if (state is GetPinLoaded) {
  //         ModelResponseGetPin prevResult = (state as GetPinLoaded).result;
  //         late ResponsePin newPin;
  //         if (isLiked) {
  //           newPin = prevResult.data!.first.copyWith(
  //             isLiked: true,
  //             likeCount: (prevResult.data!.first.likeCount ?? 0) + 1,
  //           );
  //         } else {
  //           newPin = prevResult.data!.first.copyWith(
  //             isLiked: false,
  //             likeCount: (prevResult.data!.first.likeCount ?? 0) - 1,
  //           );
  //         }

  //         ModelResponseGetPin newResult = ModelResponseGetPin(success: true, data: [newPin]);

  //         emit(GetPinLoaded(result: newResult));
  //       }
  //     }
  //   } catch (e) {
  //     emit(
  //       GetPinError(
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // Future<void> setPinHate(ModelRequestSetPinHate modelRequestSetPinHate, bool isHated) async {
  //   try {
  //     // emit(SetPinLikeLoading());

  //     ApiResponse<bool> response = await HateRepository.instance.setPinHate(modelRequestSetPinHate);
  //     if (response.status == ResponseStatus.error) {
  //       emit(
  //         GetPinError(errorMessage: response.message ?? 'create pin hate error'),
  //       );
  //     } else {
  //       if (state is GetPinLoaded) {
  //         ModelResponseGetPin prevResult = (state as GetPinLoaded).result;
  //         late ResponsePin newPin;
  //         if (isHated) {
  //           newPin = prevResult.data!.first.copyWith(
  //             isHated: true,
  //             hateCount: (prevResult.data!.first.hateCount ?? 0) + 1,
  //           );
  //         } else {
  //           newPin = prevResult.data!.first.copyWith(
  //             isHated: false,
  //             hateCount: (prevResult.data!.first.hateCount ?? 0) - 1,
  //           );
  //         }

  //         ModelResponseGetPin newResult = ModelResponseGetPin(success: true, data: [newPin]);

  //         emit(GetPinLoaded(result: newResult));
  //       }
  //     }
  //   } catch (e) {
  //     emit(
  //       GetPinError(
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }
}
