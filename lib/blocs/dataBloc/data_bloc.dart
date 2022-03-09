import 'package:flutter_app/blocs/dataBloc/data_event.dart';
import 'package:flutter_app/blocs/dataBloc/data_state.dart';
import 'package:flutter_app/data/model/api_result_model.dart';
import 'package:flutter_app/data/repository/apiRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataBloc extends Bloc<DataEvent, DataState> {

  ApiRepository apiRepository;

  DataBloc() {
    apiRepository = ApiRepository();
  }

  @override
  DataState get initialState => DataInitialState();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchDataEvent) {
      try {
        yield DataLoadingState();
        List<Welcome> dataList = await apiRepository.getData();
        yield DataLoadedState(list: dataList);
      } catch (e) {
        yield DataErrorState(msg: e.toString());
      }
    }
  }
}