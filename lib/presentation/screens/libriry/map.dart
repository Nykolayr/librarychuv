import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MainBloc bloc = Get.find<MainBloc>();
  late final YandexMapController mapController;
  List<MapObject> mapObjects = [];
  int previusIndex = -1;

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
      onMapCreated: (controller) async {
        mapController = controller;
        await mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: Point(
                latitude: bloc.state.searchLibriryItems.first.latitude,
                longitude: bloc.state.searchLibriryItems.first.longitude,
              ),
              zoom: 8,
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
                              const Gap(10),
                              Text(
                                  '${state.searchLibriryItems.where((element) => element.id == state.curLibriryId.toString()).first.address}\n${state.searchLibriryItems.where((element) => element.id == state.curLibriryId.toString()).first.phone}',
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

    mapObjects.addAll(temp);
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
      onTap: (_, __) => Get.find<MainBloc>()
          .add(ShooseLibriryEvent(index: int.parse(libriry.id))),
    );
  }
}
