part of 'background_bloc.dart';

abstract class BackgroundState extends Equatable {
  const BackgroundState();
  
  @override
  List<Object> get props => [];
}

class BackgroundInitial extends BackgroundState {}
