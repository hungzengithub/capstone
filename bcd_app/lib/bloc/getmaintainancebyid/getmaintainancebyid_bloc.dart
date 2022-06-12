import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/repositories/worker_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'getmaintainancebyid_state.dart';
part 'getmaintainancebyid_event.dart';

class GetMaintainanceByIdBloc
    extends Bloc<GetMaintainanceByIdEvent, GetMaintainanceByIdState> {
  final int maintainanceId;

  GetMaintainanceByIdBloc(this.maintainanceId);

  @override
  GetMaintainanceByIdState get initialState => GetMaintainanceByIdLoading();

  @override
  Stream<GetMaintainanceByIdState> mapEventToState(
      GetMaintainanceByIdEvent event) async* {
    try {
      MaintainanceRepository _maintainanceRepository =
          new MaintainanceRepository();
      WorkerRepository _workerRepository = new WorkerRepository();
      if (event is GetMaintainanceById) {
        MaintainanceDTO dto = await _maintainanceRepository
            .getMaintainanceById(maintainanceId.toString());
        List<WorkerDTO> listWorker = await _workerRepository.fetchListWorker();
        yield* _mapAppStartedToState(dto, listWorker);
      }
    } catch (e) {
      yield GetMaintainanceByIdError();
    }
  }

  Stream<GetMaintainanceByIdState> _mapAppStartedToState(
      MaintainanceDTO dto, List<WorkerDTO> listWorker) async* {
    if (dto != null && listWorker.length > 0) {
      yield GetMaintainanceByIdSuccess(dto, listWorker);
    } else {
      yield GetMaintainanceByIdError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
