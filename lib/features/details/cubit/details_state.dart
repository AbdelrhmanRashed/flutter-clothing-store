part of 'details_cubit.dart';

sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {
  final ProductsModel productDetails;
  DetailsSuccess(this.productDetails);
}

final class DetailsFailure extends DetailsState {
  final String errMsg;
  DetailsFailure(this.errMsg);
}
