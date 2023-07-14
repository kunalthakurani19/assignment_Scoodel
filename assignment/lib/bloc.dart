// item_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final String item;

  AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends ItemEvent {
  final int index;

  RemoveItem(this.index);

  @override
  List<Object> get props => [index];
}

abstract class ItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoaded extends ItemState {
  final List<String> items;

  ItemLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    itemList = [];
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
  }
  List<String> itemList = [];

  void _onAddItem(AddItem event, Emitter<ItemState> emit) {
    itemList.add(event.item);
    emit(ItemLoaded(List<String>.from(itemList)));
  }

  void _onRemoveItem(RemoveItem event, Emitter<ItemState> emit) {
    if (event.index >= 0 && event.index < itemList.length) {
      itemList.removeAt(event.index);
      emit(ItemLoaded(List<String>.from(itemList)));
    }
  }
}
