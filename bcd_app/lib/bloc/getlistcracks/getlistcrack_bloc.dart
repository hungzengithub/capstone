import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/repositories/worker_repository.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'getlistcrack_event.dart';
part 'getlistcrack_state.dart';

class GetListCrackBloc extends Bloc<GetListCrackEvent, GetListCrackState> {
  DateTime selectedVerifyDate;
  @override
  GetListCrackState get initialState => GetListCrackLoading();

  @override
  Stream<GetListCrackState> mapEventToState(GetListCrackEvent event) async* {
    CrackRepository _crackRepository = new CrackRepository();
    try {
      if (event is GetListCrackLoadingEvent) {
        yield GetListCrackLoading();
      }
      if (event is GetListNotVerifyCrack) {
        List<CrackDTO> listDTO =
            await _crackRepository.fetchCrackByStatus(CrackStatus.Unconfirmed);
        yield* _mapAppStartedToState(listDTO);
      } else if (event is GetListVerifyCrack) {
        yield GetListCrackLoading();
        List<CrackDTO> listDTO = await _crackRepository.fetchVerifyCrack();
        yield* _mapAppStartedToState(listDTO);
      } else if (event is GetListHistoryCrack) {
        List<CrackDTO> listDTO =
            await _crackRepository.fetchCrackByStatus(CrackStatus.Fixed);
        yield* _mapAppStartedToState(listDTO);
      } else if (event is GetListScheduledCrack) {
        List<CrackDTO> listDTO = await _crackRepository
            .fetchCrackByStatus(CrackStatus.ScheduledForMaintenace);
        yield* _mapAppStartedToState(listDTO);
      } else if (event is GetListUnScheduledCrack) {
        List<CrackDTO> listDTO = await _crackRepository
            .fetchCrackByStatus(CrackStatus.UnscheduledForMaintenace);
        List<CrackDTO> listFinal = new List<CrackDTO>();
        for (CrackDTO crackDTO in listDTO) {
          if ((crackDTO.severity != CrackSeverity.Low &&
              crackDTO.maintenanceOrderId == -1)) {
            listFinal.add(crackDTO);
          }
        }
        yield* _mapAppStartedToState(listFinal);
      } else if (event is GetListCrackInQueue) {
        yield GetListCrackLoading();
        WorkerRepository _workerRepository = new WorkerRepository();
        List<CrackDTO> listDTO = await _crackRepository.fetchCrackInQueue();
        List<WorkerDTO> listWorker = await _workerRepository.fetchListWorker();
        yield* _mapAppStartedToStateForQueue(listDTO, listWorker);
      } else if (event is GetListWorker) {
        WorkerRepository _workerRepository = new WorkerRepository();
        List<WorkerDTO> listWorker = await _workerRepository.fetchListWorker();
        if (listWorker.length > 0) {
          yield GetQueueSuccess(null, listWorker);
        } else {
          yield GetListCrackError();
        }
      } else if (event is GetCrackByFilter) {
        yield GetListVerifyCrackLoading();
        WorkerRepository _workerRepository = new WorkerRepository();

        List<WorkerDTO> listWorker = await _workerRepository.fetchListWorker();

        List<CrackDTO> listDTO = new List<CrackDTO>();
        if (event.type != "All") {
          for (var crack in event.listCrack) {
            if (crack.status == event.type) {
              listDTO.add(crack);
            }
          }
        } else
          listDTO = event.listCrack;
        yield GetListFilterSuccess(listDTO);
      }
    } catch (e) {
      yield GetListCrackError();
      print(e);
    }
  }

  Stream<GetListCrackState> _mapAppStartedToState(
      List<CrackDTO> listDTO) async* {
    if (listDTO != null) {
      if (listDTO.length > 0) {
        yield GetListCrackSuccess(listDTO);
      } else {
        yield GetListCrackError();
      }
    }
  }

  Stream<GetListCrackState> _mapAppStartedToStateForQueue(
      List<CrackDTO> listDTO, List<WorkerDTO> listWorker) async* {
    if (listDTO != null && listWorker != null) {
      if (listDTO.length > 0 && listWorker.length > 0) {
        yield GetQueueSuccess(listDTO, listWorker);
      } else {
        yield GetListCrackError();
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void remove(GetListVerifyCrack getListVerifyCrack) {}
}
