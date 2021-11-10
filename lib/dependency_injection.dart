import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
FutureOr<void> configureDependencies() => $initGetIt(getIt);