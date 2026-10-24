// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:simple_tracking/core/di/register_module.dart' as _i702;
import 'package:simple_tracking/features/location/data/location_module.dart'
    as _i1045;
import 'package:simple_tracking/features/location/domain/location_repository.dart'
    as _i270;
import 'package:simple_tracking/features/location/domain/observe_location_use_case.dart'
    as _i595;
import 'package:simple_tracking/features/map/presentation/cubit/map_cubit.dart'
    as _i6;
import 'package:simple_tracking/features/place/data/kakao_place_api.dart'
    as _i1070;
import 'package:simple_tracking/features/place/data/place_repository_impl.dart'
    as _i763;
import 'package:simple_tracking/features/place/data/shared_prefs_recent_place_repository.dart'
    as _i672;
import 'package:simple_tracking/features/place/data/shared_prefs_recent_search_repository.dart'
    as _i1046;
import 'package:simple_tracking/features/place/domain/place_repository.dart'
    as _i928;
import 'package:simple_tracking/features/place/domain/recent_place_repository.dart'
    as _i673;
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart'
    as _i940;
import 'package:simple_tracking/features/place/domain/recent_search_repository.dart'
    as _i982;
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart'
    as _i1047;
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart'
    as _i876;
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart'
    as _i48;
import 'package:simple_tracking/features/place/presentation/cubit/place_search_cubit.dart'
    as _i535;
import 'package:simple_tracking/features/route/data/kakao_route_api.dart'
    as _i1019;
import 'package:simple_tracking/features/route/data/route_repository_impl.dart'
    as _i314;
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart'
    as _i621;
import 'package:simple_tracking/features/route/domain/route_repository.dart'
    as _i1013;
import 'package:simple_tracking/features/route/presentation/cubit/endpoint_search_cubit.dart'
    as _i645;
import 'package:simple_tracking/features/route/presentation/cubit/route_cubit.dart'
    as _i74;
import 'package:simple_tracking/features/route/presentation/cubit/route_planner_cubit.dart'
    as _i175;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final locationModule = _$LocationModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i270.LocationRepository>(() => locationModule.location());
    gh.factory<_i595.ObserveLocationUseCase>(
      () => _i595.ObserveLocationUseCase(gh<_i270.LocationRepository>()),
    );
    gh.lazySingleton<_i1070.KakaoPlaceApi>(
      () => _i1070.KakaoPlaceApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1019.KakaoRouteApi>(
      () => _i1019.KakaoRouteApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i928.PlaceRepository>(
      () => _i763.PlaceRepositoryImpl(gh<_i1070.KakaoPlaceApi>()),
    );
    gh.factory<_i6.MapCubit>(
      () => _i6.MapCubit(
        gh<_i595.ObserveLocationUseCase>(),
        gh<_i270.LocationRepository>(),
      ),
    );
    gh.lazySingleton<_i982.RecentSearchRepository>(
      () => _i1046.SharedPrefsRecentSearchRepository(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i673.RecentPlaceRepository>(
      () =>
          _i672.SharedPrefsRecentPlaceRepository(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1047.RecentSearchesUseCase>(
      () => _i1047.RecentSearchesUseCase(gh<_i982.RecentSearchRepository>()),
    );
    gh.lazySingleton<_i1013.RouteRepository>(
      () => _i314.RouteRepositoryImpl(gh<_i1019.KakaoRouteApi>()),
    );
    gh.factory<_i876.SearchPlacesByCategoryUseCase>(
      () => _i876.SearchPlacesByCategoryUseCase(gh<_i928.PlaceRepository>()),
    );
    gh.factory<_i48.SearchPlacesUseCase>(
      () => _i48.SearchPlacesUseCase(gh<_i928.PlaceRepository>()),
    );
    gh.factory<_i621.FindCarRouteUseCase>(
      () => _i621.FindCarRouteUseCase(gh<_i1013.RouteRepository>()),
    );
    gh.factory<_i621.FindWalkingRouteUseCase>(
      () => _i621.FindWalkingRouteUseCase(gh<_i1013.RouteRepository>()),
    );
    gh.factory<_i621.FindTransitRoutesUseCase>(
      () => _i621.FindTransitRoutesUseCase(gh<_i1013.RouteRepository>()),
    );
    gh.factory<_i940.RecentPlacesUseCase>(
      () => _i940.RecentPlacesUseCase(gh<_i673.RecentPlaceRepository>()),
    );
    gh.factory<_i645.EndpointSearchCubit>(
      () => _i645.EndpointSearchCubit(
        gh<_i48.SearchPlacesUseCase>(),
        gh<_i1047.RecentSearchesUseCase>(),
        gh<_i940.RecentPlacesUseCase>(),
      ),
    );
    gh.factory<_i74.RouteCubit>(
      () => _i74.RouteCubit(
        gh<_i621.FindCarRouteUseCase>(),
        gh<_i621.FindWalkingRouteUseCase>(),
        gh<_i621.FindTransitRoutesUseCase>(),
      ),
    );
    gh.factory<_i535.PlaceSearchCubit>(
      () => _i535.PlaceSearchCubit(
        gh<_i48.SearchPlacesUseCase>(),
        gh<_i876.SearchPlacesByCategoryUseCase>(),
        gh<_i1047.RecentSearchesUseCase>(),
        gh<_i940.RecentPlacesUseCase>(),
      ),
    );
    gh.factory<_i175.RoutePlannerCubit>(
      () => _i175.RoutePlannerCubit(gh<_i940.RecentPlacesUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i702.RegisterModule {}

class _$LocationModule extends _i1045.LocationModule {}
