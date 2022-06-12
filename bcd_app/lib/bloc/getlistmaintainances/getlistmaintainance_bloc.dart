import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'getlistmaintainance_event.dart';
part 'getlistmaintainance_state.dart';

class GetListMaintainanceBloc
    extends Bloc<GetListMaintainanceEvent, GetListMaintainanceState> {
  final DateTime selectedDate;
  GetListMaintainanceBloc(this.selectedDate);

  @override
  GetListMaintainanceState get initialState => GetlistMaintainanceLoading();

  @override
  Stream<GetListMaintainanceState> mapEventToState(
      GetListMaintainanceEvent event) async* {
    try {
      MaintainanceRepository _crackRepository = new MaintainanceRepository();
      if (event is GetListWaitingMaintainance) {
        List<MaintainanceDTO> listDTO =
            await _crackRepository.getWaitingMaintainance();
        yield* _mapAppStartedToState(listDTO);
      } else if (event is GetListCompletedMaintainance) {
        List<MaintainanceDTO> listDTO =
            await _crackRepository.getCompletedMaintainance();
        yield* _mapAppStartedToState(listDTO);
      }
    } catch (e) {
      yield GetlistMaintainanceError();
    }
  }

  Stream<GetListMaintainanceState> _mapAppStartedToState(
      List<MaintainanceDTO> listDTO) async* {
    if (listDTO.length > 0) {
      yield GetlistMaintainanceSuccess(listDTO);
    } else {
      yield GetlistMaintainanceError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
