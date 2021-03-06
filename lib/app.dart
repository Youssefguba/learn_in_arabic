import 'package:authentication_repository/authentication.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/masaqat/blocs/masaqat/masaqat_bloc.dart';
import 'package:learn_in_arabic/shared/network/youtube.dart';
import 'package:learn_in_arabic/wishlist/blocs/wishlist_bloc/wish_list_bloc.dart';

import 'authentication/authentication.dart';
import 'home/home.dart';
import 'navigator/navigator.dart';


class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(authenticationRepository: authenticationRepository),
      ),
    );
  }
}


class AppView extends StatefulWidget {
  final authenticationRepository;
  const AppView({Key key, this.authenticationRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    YoutubeRepository _youtubeRepository = YoutubeRepository();
    UserRepository _userRepository = UserRepository();

    return MultiBlocProvider(
      providers: [
        /// Home Bloc
        BlocProvider(create: (_) => HomeContentBloc(_youtubeRepository)),

        /// Wish List
        BlocProvider(create: (_) => WishListBloc()),

        /// Masaqat Blocs
        BlocProvider(create: (_) => MasaqatBloc(_youtubeRepository)),

        /// Auth Blocs
        BlocProvider(create: (_) => AuthenticationBloc(authenticationRepository: widget.authenticationRepository)),
        BlocProvider(create: (_) => LoginCubit(widget.authenticationRepository, _userRepository)),


      ],
      child: MaterialApp(
        title: '???????????? ????????????????',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: NamedNavigatorImpl.onCreateRoute,
        navigatorKey: NamedNavigatorImpl.navigatorState,
        navigatorObservers: [NamedNavigatorImpl.routeObserver],
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  // NamedNavigatorImpl().push(Routes.SPLASH_SCREEN , clean: true);
                  NamedNavigatorImpl().push(Routes.HOME, clean: true);
                  break;
                case AuthenticationStatus.unauthenticated:
                  NamedNavigatorImpl().push(Routes.SPLASH_SCREEN , clean: true);
                  break;
                default:
                  break;
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
