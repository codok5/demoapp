import 'package:behapp/Game/model/plant.dart';
import 'package:behapp/Game/repository/repository.dart';
import 'package:behapp/hiveCustomModel/goal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc() : super(PlantState.initial()) {
    on<PlantEvent>((event, emit) {});
  }
}
