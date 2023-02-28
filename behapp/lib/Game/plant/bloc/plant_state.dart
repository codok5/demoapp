part of 'plant_bloc.dart';

class PlantState extends Equatable {
  final List<Plant> plantlist;
  PlantState({
    required this.plantlist,
  });

  final List<GoalObject> goallist = Repository.GetGoalList();

  PlantState.initial()
      : this(plantlist: [
          Plant(plantStatus: PlantStatus.q3, plantKind: PlantKind.third)
        ]);

  @override
  List<Object> get props => [plantlist];

  PlantState copyWith({
    List<Plant>? plantlist,
  }) {
    return PlantState(
      plantlist: plantlist ?? this.plantlist,
    );
  }

  @override
  String toString() => 'PlantState(plantlist: $plantlist)';
}
