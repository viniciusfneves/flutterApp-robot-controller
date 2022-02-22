import 'package:blue_app/routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPage = StateProvider<AppRoutes>((_) => AppRoutes.configuration);
