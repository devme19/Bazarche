import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/data/model/own_comment_model.dart';
import 'package:bazarche/domain/entities/own_comment_entity.dart';
import 'package:bazarche/domain/usecases/job/get_comments_usecase.dart';
import 'package:bazarche/domain/usecases/job/send_rate_usecase.dart';
import 'package:bazarche/domain/usecases/user/get_own_comment_usecase.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:get/get.dart';

class CommentsPageController extends GetxController{
  var getCommentState = StateStatus.INITIAL.obs;
  var getOwnCommentState = StateStatus.INITIAL.obs;
  var sendRateState = StateStatus.INITIAL.obs;
  RxList comments = [].obs;
  Rx<Data> ownComment = Data().obs;
  int pageIndex = 1;
  RxBool isRated = false.obs;
  double rate = 0;
  String jobId;
  getOwnComment(String id){
    getOwnCommentState.value = StateStatus.INITIAL;
    GetOwnCommentUseCase getOwnCommentUseCase = Get.find();
    getOwnCommentUseCase.call(Params(id: id)).then((response) {
      if(response.isRight){
        getOwnCommentState.value = StateStatus.SUCCESS;
        ownComment.value = response.right.data;
      }else if(response.isLeft){
        getOwnCommentState.value = StateStatus.ERROR;
      }
    });
  }
  getComments(String id){
    jobId = id;
    if(getCommentState.value != StateStatus.LOADING) {
      Map<String, dynamic> jsonMap = {
        'count': 10,
        'page': pageIndex.toString(),
      };
      GetCommentUseCase getCommentUseCase = Get.find();
      getCommentState.value = StateStatus.LOADING;
      getCommentUseCase.call(Params(id: id, body: jsonMap)).then((response) {
        if (response.isRight) {
          pageIndex++;
          getCommentState.value = StateStatus.SUCCESS;
          comments.addAll(response.right.data);
        } else if (response.isLeft) {
          getCommentState.value = StateStatus.ERROR;
        }
      });
    }
  }
  sendRate(double rateJob){
    Map<String, dynamic> jsonMap = {
      'jobId': jobId,
      'mark': rateJob,
    };
    sendRateState.value = StateStatus.LOADING;
    SendRateUseCase sendRateUseCase = Get.find();
    sendRateUseCase.call(Params(body: jsonMap)).then((response) {
      if(response.isRight){
        sendRateState.value = StateStatus.SUCCESS;
        isRated.value = true;
        Get.snackbar('', 'امتیاز با موفقیت ثبت شد');
      }else if(response.isLeft){
        sendRateState.value = StateStatus.ERROR;
      }
    });
  }
}