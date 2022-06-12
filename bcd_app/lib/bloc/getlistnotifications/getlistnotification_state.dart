part of 'getlistnotification_bloc.dart';

abstract class GetListNotificationState extends Equatable {
  const GetListNotificationState();
  @override
  List<Object> get props => [];
}

class GetListNotificationLoading extends GetListNotificationState {}

class GetListNotificationSuccess extends GetListNotificationState {
  final List<NotificationDTO> listDTO;
  const GetListNotificationSuccess(this.listDTO);
  @override
  List<Object> get props => [listDTO];
}

class GetListNotificationError extends GetListNotificationState {}
