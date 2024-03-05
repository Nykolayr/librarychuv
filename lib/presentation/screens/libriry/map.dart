import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/presentation/screens/libriry/clusterized_icon_painter.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as ymaps;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MainBloc bloc = Get.find<MainBloc>();
  late final YandexMapController mapController;
  List<MapObject> mapObjects = [];
  late final ymaps.ClusterizedPlacemarkCollection collection;
  int previusIndex = -1;
  var mapZoom = 15.0;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    YandexMap map = YandexMap(
      onCameraPositionChanged: (cameraPosition, _, __) {
        setState(() {
          mapZoom = cameraPosition.zoom;
        });
      },
      onMapCreated: (controller) async {
        mapController = controller;
        await mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: Point(
                latitude: bloc.state.searchLibriryItems.first.latitude,
                longitude: bloc.state.searchLibriryItems.first.longitude,
              ),
              zoom: mapZoom,
            ),
          ),
        );
        if (context.mounted) await setlibriryItems(context, mapController);
      },
      mapObjects: mapObjects,
    );
    deleteOldPoint(int index) {
      if (index != -1) {
        Libriry libriry = bloc.state.searchLibriryItems
            .where((element) => element.id == index.toString())
            .first;

        mapObjects.removeWhere(
            (element) => element.mapId.value == libriry.id.toString());
      }
    }

    addPoint(int index, bool isChoose) {
      if (index != -1) {
        Libriry libriry = bloc.state.searchLibriryItems
            .where((element) => element.id == index.toString())
            .first;

        mapObjects.add(getPoint(libriry, isChoose: isChoose));
      }
    }

    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        buildWhen: (previous, current) {
          if (previous.searchLibriryItems.length !=
                  current.searchLibriryItems.length ||
              previous.isSearch != current.isSearch ||
              previous.curLibriryId != current.curLibriryId) {
            mapObjects.clear();
            if (context.mounted) setlibriryItems(context, mapController);
          }
          if (previous.curLibriryId != current.curLibriryId) {
            deleteOldPoint(previusIndex);
            deleteOldPoint(current.curLibriryId);
            addPoint(previusIndex, false);
            addPoint(current.curLibriryId, true);
            setState(() {});
            previusIndex = current.curLibriryId;
          }
          return true;
        },
        builder: (context, state) {
          if (state.curLibriryId != -1) {}
          return Container(
            width: context.mediaQuerySize.width,
            decoration: AppDif.getBoxDecoration(),
            child: ClipRRect(
              borderRadius: AppDif.borderRadius10,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  map,
                  if (state.curLibriryId != -1)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        width: context.mediaQuerySize.width - 20,
                        decoration: AppDif.getBoxDecoration(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  state.searchLibriryItems
                                      .where((element) =>
                                          element.id ==
                                          state.curLibriryId.toString())
                                      .first
                                      .name,
                                  style: AppText.text14b
                                      .copyWith(fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center),
                              Text(
                                  '${state.searchLibriryItems.where((element) => element.id == state.curLibriryId.toString()).first.address} ${state.searchLibriryItems.where((element) => element.id == state.curLibriryId.toString()).first.phone}',
                                  style: AppText.text14b,
                                  textAlign: TextAlign.center),
                            ]),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }

  /// обновляем данные при изменение количества найднных библиотек
  Future setlibriryItems(context, YandexMapController controller) async {
    List<PlacemarkMapObject> temp = [];
    if (context.mounted) temp = getPlacemarkObjects(context);
    double minLat = temp
        .map((point) => point.point.latitude)
        .reduce((a, b) => a < b ? a : b);
    double maxLat = temp
        .map((point) => point.point.latitude)
        .reduce((a, b) => a > b ? a : b);
    double minLon = temp
        .map((point) => point.point.longitude)
        .reduce((a, b) => a < b ? a : b);
    double maxLon = temp
        .map((point) => point.point.longitude)
        .reduce((a, b) => a > b ? a : b);
    if (temp.length > 1) {
      mapObjects = [
        getClusterizedCollection(
          placemarks: temp,
        ),
      ];
    }
    // mapObjects.addAll(temp);
    await controller.moveCamera(
      CameraUpdate.newGeometry(
        Geometry.fromBoundingBox(
          BoundingBox(
            southWest: Point(latitude: minLat - 0.2, longitude: minLon - 0.2),
            northEast: Point(latitude: maxLat + 0.2, longitude: maxLon + 0.2),
          ),
        ),
      ),
    );
    setState(() {});
  }

  /// Метод для генерации объектов маркеров для отображения на карте
  List<PlacemarkMapObject> getPlacemarkObjects(BuildContext context,
      {bool isChoose = false}) {
    return bloc.state.searchLibriryItems
        .map((libriry) => getPoint(libriry))
        .toList();
  }

  /// Метод для генерации одного объекта маркера для отображения на карте
  PlacemarkMapObject getPoint(Libriry libriry, {bool isChoose = false}) {
    return PlacemarkMapObject(
        mapId: MapObjectId(libriry.id.toString()),
        point: Point(latitude: libriry.latitude, longitude: libriry.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              isChoose
                  ? 'assets/icons/map_point_choose.png'
                  : 'assets/icons/map_point.png',
            ),
            scale: 3,
          ),
        ),
        onTap: (_, __) {
          incrementZoom(
            Point(latitude: libriry.latitude, longitude: libriry.longitude),
          );

          Get.find<MainBloc>()
              .add(ShooseLibriryEvent(index: int.parse(libriry.id)));
        });
  }

  /// Метод для получения коллекции кластеризованных маркеров
  ClusterizedPlacemarkCollection getClusterizedCollection(
      {required List<PlacemarkMapObject> placemarks}) {
    return ClusterizedPlacemarkCollection(
        mapId: const MapObjectId('clusterized-1'),
        placemarks: placemarks,
        radius: 50,
        minZoom: 15,
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1.0,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(
                    await ClusterIconPainter(cluster.size)
                        .getClusterIconBytes(),
                  ),
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) async {
          return incrementZoom(
            cluster.placemarks.first.point,
          );
        });
  }

  incrementZoom(Point target) async {
    mapZoom++;
    return await mapController.moveCamera(
      animation:
          const MapAnimation(type: MapAnimationType.linear, duration: 0.3),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: mapZoom,
        ),
      ),
    );
  }
}
