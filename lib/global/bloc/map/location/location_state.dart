part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState._(
      {this.modelResponseSetPost, this.status = CubitStatus.initial});

  final ModelResponseSetPost? modelResponseSetPost;
  final CubitStatus status;

  LocationState.initial()
      : this._(
            status: CubitStatus.initial,
            modelResponseSetPost: ModelResponseSetPost());
  const LocationState.loading() : this._(status: CubitStatus.loading);
  const LocationState.loaded({required ModelResponseSetPost? result})
      : this._(status: CubitStatus.loaded, modelResponseSetPost: result);
  const LocationState.error() : this._(status: CubitStatus.failure);

  @override
  List<Object?> get props => [];
}
