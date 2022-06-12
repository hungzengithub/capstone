part of 'getlistcrack_bloc.dart';

abstract class GetListCrackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListNotVerifyCrack extends GetListCrackEvent {}

class GetListVerifyCrack extends GetListCrackEvent {}

class GetListUnScheduledCrack extends GetListCrackEvent {}

class GetListScheduledCrack extends GetListCrackEvent {}

class GetListHistoryCrack extends GetListCrackEvent {}

class GetListCrackInQueue extends GetListCrackEvent {}

class GetListCrackLoadingEvent extends GetListCrackEvent {}

class GetListWorker extends GetListCrackEvent {}

class GetCrackByFilter extends GetListCrackEvent {
  final List<CrackDTO> listCrack;
  final String type;

  GetCrackByFilter(this.listCrack, this.type);
}
