import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/data/model/all_category_model.dart';
import 'package:bazarche/data/model/job_model.dart' as jobModel;
import 'package:bazarche/domain/entities/job_entity.dart';
import 'package:bazarche/domain/usecases/job/get_best_jobs_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_jobs_by_search_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_near_locations_usecase.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:bazarche/presentation/utils/my_marker.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import "package:latlong/latlong.dart" as latLng;
class HomePageController extends GetxController{
  var getJobsStatus = StateStatus.INITIAL.obs;
  var getSubListStatus = StateStatus.INITIAL.obs;
  var nearLocationsStatus = StateStatus.INITIAL.obs;
  RxList subCategory=[].obs;
  RxList jobs = [].obs;
  RxDouble mapHeight = (Get.height/2).obs;
  Map<String, dynamic> jsonMap = new Map();
  RxBool fullScreen = false.obs;
  RxInt selectedCategory = 0.obs;
  RxInt selectedSubCategory = 0.obs;
  RxDouble categoryMenuHeight = (120.0).obs;
  RxDouble categoryMenuHeightMapView = (60.0).obs;
  int pageIndex = 1;
  int searchPageIndex = 1;
  String selectedId = '';
  RxString title = ''.obs;
  RxString searchTitle = ''.obs;
  RxString searchTitleColor = ''.obs;
  List<jobModel.Data> nearLocations=[];
  RxBool arrowUpVisible = false.obs;
  MapWidgetController mapWidgetController;


  @override
  void onInit() {
    super.onInit();
    mapWidgetController = Get.put(MapWidgetController());
    getBestJobs();
    mapWidgetController.getNearLocations(onMakerTap);
  }
  getNearLocations(bool value){
    mapWidgetController.getNearLocations(onMakerTap);
  }

  fullScreenMap(){
    fullScreen.value = !fullScreen.value;
    if(fullScreen.value) {
      mapHeight.value = Get.height - 50;
    } else {
      mapHeight.value = Get.height / 2;
    }
  }
  getJobsBySearch(String searchTxt){
    if(searchTxt != ''){
      searchTitleColor.value = '318fb5';
      title.value = 'جستجو برای';
      searchTitle.value = searchTxt;
      jsonMap = {
        'search': searchTxt,
        'page': searchPageIndex.toString(),
      };
      getJobsStatus.value = StateStatus.LOADING;
      GetJobsBySearchUseCase getJobsBySearchUseCase = Get.find();
      getJobsBySearchUseCase.call(Params(body: jsonMap)).then((response) {
        if (response.isRight) {
          getJobsStatus.value = StateStatus.SUCCESS;
          jobs.addAll(response.right.data);
          mapWidgetController.setMarker(response.right.data,onMakerTap,true);
          searchPageIndex++;

        } else if (response.isLeft) {}
      });
    }else {
      pageIndex = 1;
      getBestJobs();
      searchTitle.value='';
    }
  }
  onMakerTap(bool value){
    if(!fullScreen.value)
      fullScreenMap();
  }
  getBestJobs(){
    title.value = 'کسب و کارهای برتر';
    if(getJobsStatus.value != StateStatus.LOADING) {
      jsonMap = {
        'page': pageIndex.toString(),
      };
      getJobsStatus.value = StateStatus.LOADING;
      String path = '';
      if (selectedCategory.value != 0) path = '/category/$selectedId';
      GetBestJobsUseCase getBestJobsUseCase = Get.find();
      getBestJobsUseCase
          .call(Params(body: jsonMap, value: path))
          .then((response) {
        if (response.isRight) {
          if (response.right.data.length > 0) pageIndex++;
          getJobsStatus.value = StateStatus.SUCCESS;
          // Get.snackbar('title', pageIndex.toString());
          jobs.addAll(response.right.data);
          // jobs.addAll(response.right.data);
          // jobs.addAll(response.right.data);
          // jobs.addAll(response.right.data);
          // jobs.addAll(response.right.data);
          // jobs.addAll(response.right.data);
          // jobs.addAll(response.right.data);
          // bestJobs.addAll(response.right.data);
          // bestJobs.addAll(response.right.data);
          // bestJobs.addAll(response.right.data);
        } else if (response.isLeft) {}
      });
    }
  }


  getSubList(int index)async{
      List list=[];
      subCategory.clear();
      selectedSubCategory.value=-1;
      getSubListStatus.value = StateStatus.LOADING;
      if(selectedCategory.value != 0){
        list.addAll(Bazarche().allCategoryEntity.data[index-1].subCategories);
        if(list.length>0) {
          subCategory.add(Data(name: 'همه', color: list[0].color));
          subCategory.addAll(list);
          selectedSubCategory.value = 0;
          onSubCategoryItemTap(0);
        }
      }
      if(subCategory.length>1) {
        categoryMenuHeight.value = 200;
        categoryMenuHeightMapView.value = 150;
        await Future.delayed(Duration(milliseconds: 200));
        getSubListStatus.value = StateStatus.SUCCESS;
      } else {
        onCategoryItemTap();
        categoryMenuHeight.value = 120;
        categoryMenuHeightMapView.value = 60;
        getSubListStatus.value = StateStatus.ERROR;

      }
  }
  onSubCategoryItemTap(int index){
    selectedSubCategory.value = index;
    jsonMap = new Map();
    jobs.clear();
    pageIndex = 1;
    searchTitleColor.value = Bazarche().category[selectedCategory.value].color;
    if(index == 0)
      selectedId = Bazarche().category[selectedCategory.value].sId;
    else
      selectedId = subCategory[index].sId;
    jsonMap = new Map();
    searchTitle.value = Bazarche().category[selectedCategory.value].name +' / ' +subCategory[index].name;
    getBestJobs();
  }
  onCategoryItemTap(){
    jsonMap = new Map();
    jobs.clear();
    pageIndex = 1;
    selectedId = Bazarche().category[selectedCategory.value].sId;
    searchTitleColor.value = Bazarche().category[selectedCategory.value].color;
    if(selectedCategory.value != 0)
    searchTitle.value = Bazarche().category[selectedCategory.value].name;
    else
      searchTitle.value = '';
    getBestJobs();
  }



}
