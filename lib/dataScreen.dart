import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/dataBloc/data_bloc.dart';
import 'package:flutter_app/blocs/dataBloc/data_event.dart';
import 'package:flutter_app/blocs/dataBloc/data_state.dart';
import 'package:flutter_app/data/model/api_result_model.dart';
import 'package:flutter_app/newScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataParent extends StatelessWidget {
  const DataParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc()..add(FetchDataEvent()),
      child: const DataScreen(),
    );
  }
}


class DataScreen extends StatefulWidget {
  const DataScreen({Key key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  DataBloc dataBloc;

  @override
  void initState(){
    super.initState();
    dataBloc = BlocProvider.of<DataBloc>(context);
  }

  Widget buildDataList(List<Welcome> data){
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (ctx, pos) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: ListTile(
                  tileColor: Colors.limeAccent,
                  leading: ClipOval(
                    child: Hero(
                      tag: pos,
                      child: const Icon(Icons.account_balance_rounded),
                    ),
                  ),
                  title: Text(data[pos].name),
                  subtitle: Text(data[pos].country),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen(listInfo: data[pos])));
                },
              ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Data Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            tooltip: 'Refresh',
            onPressed: () {
              dataBloc.add(FetchDataEvent());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocListener<DataBloc, DataState>(
            listener: (context, state) {
              if(state is DataErrorState){
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(state.msg))
                );
              }
            },
            child: BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  if(state is DataInitialState){
                    return const Center(child: Text("Wait..." ,style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),));
                  }else if(state is DataLoadingState){
                    return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()
                    );
                  }else if(state is DataLoadedState){
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: buildDataList(state.list)
                    );
                  }else if(state is DataErrorState){
                    return Center(child: Text(state.msg ,style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),));
                  }
                  else{
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
