// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimerNotifier)
const timerProvider = TimerNotifierProvider._();

final class TimerNotifierProvider
    extends $NotifierProvider<TimerNotifier, List<TimerData>> {
  const TimerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timerNotifierHash();

  @$internal
  @override
  TimerNotifier create() => TimerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TimerData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TimerData>>(value),
    );
  }
}

String _$timerNotifierHash() => r'7adac51c1afa11477c6c556e59e4d69f85f6d2a5';

abstract class _$TimerNotifier extends $Notifier<List<TimerData>> {
  List<TimerData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<TimerData>, List<TimerData>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TimerData>, List<TimerData>>,
              List<TimerData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
