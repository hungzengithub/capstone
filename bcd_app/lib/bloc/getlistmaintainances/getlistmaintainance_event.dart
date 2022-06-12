part of 'getlistmaintainance_bloc.dart';

abstract class GetListMaintainanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListWaitingMaintainance extends GetListMaintainanceEvent {}

class GetListCompletedMaintainance extends GetListMaintainanceEvent {}
