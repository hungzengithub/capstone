import 'package:bcd_app/objects/notificationDTO.dart';
import 'package:bcd_app/repositories/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'getlistnotification_event.dart';
part 'getlistnotification_state.dart';

class GetListNotificationBloc
    extends Bloc<GetListNotificationEvent, GetListNotificationState> {
  @override
  GetListNotificationState get initialState => GetListNotificationLoading();

  @override
  Stream<GetListNotificationState> mapEventToState(
      GetListNotificationEvent event) async* {
    try {
      NotificationRepository _notificationRepository =
          new NotificationRepository();
      if (event is GetListNotification) {
        List<NotificationDTO> listDTO =
            await _notificationRepository.fetchNotification();
        yield* _mapAppStartedToState(listDTO);
      }
    } catch (e) {
      yield GetListNotificationError();
    }
  }

  Stream<GetListNotificationState> _mapAppStartedToState(
      List<NotificationDTO> listDTO) async* {
    if (listDTO.length > 0) {
      yield GetListNotificationSuccess(listDTO);
    } else {
      yield GetListNotificationError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
