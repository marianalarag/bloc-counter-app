import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'counter_event.dart';

// Estado que contiene contador y color
class CounterState {
  final int counter;
  final Color color;

  CounterState({required this.counter, required this.color});

  // Copiar estado con cambios
  CounterState copyWith({int? counter, Color? color}) {
    return CounterState(
      counter: counter ?? this.counter,
      color: color ?? this.color,
    );
  }
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(CounterState(counter: 0, color: Colors.white)) {
    // Incrementa
    on<CounterIncremented>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
    });

    // Decrementa
    on<CounterDecremented>((event, emit) {
      emit(state.copyWith(counter: state.counter - 1));
    });

    // Reset
    on<CounterReset>((event, emit) {
      emit(state.copyWith(counter: 0));
    });

    // Cambia color aleatorio
    on<CounterColorChanged>((event, emit) {
      emit(state.copyWith(
        color: Colors.primaries[state.counter.abs() % Colors.primaries.length],
      ));
    });
  }
}
