part of 'getmaintainancebyid_bloc.dart';

abstract class GetMaintainanceByIdState extends Equatable {
  const GetMaintainanceByIdState();
  @override
  List<Object> get props => [];
}

class GetMaintainanceByIdLoading extends GetMaintainanceByIdState {}

class GetMaintainanceByIdSuccess extends GetMaintainanceByIdState {
  final MaintainanceDTO dto;
  final List<WorkerDTO> listWorker;
  const GetMaintainanceByIdSuccess(this.dto, this.listWorker);
}

class GetMaintainanceByIdError extends GetMaintainanceByIdState {}
