import 'package:app/features/home/presentation/widgets/pages/home.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
  ],
)
// extend the generated private router
class $AppRouter {}
