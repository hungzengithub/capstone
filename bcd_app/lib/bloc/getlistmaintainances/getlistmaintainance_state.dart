part of 'getlistmaintainance_bloc.dart';

abstract class GetListMaintainanceState extends Equatable {
  const GetListMaintainanceState();
  @override
  List<Object> get props => [];
}

class GetlistMaintainanceLoading extends GetListMaintainanceState {}

class GetlistMaintainanceSuccess extends GetListMaintainanceState {
  final List<MaintainanceDTO> listDTO;
  const GetlistMaintainanceSuccess(this.listDTO);
  @override
  List<Object> get props => [listDTO];
}

class GetlistMaintainanceError extends GetListMaintainanceState {}
