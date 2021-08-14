import 'package:bazarche/domain/usecases/job/get_comments_usecase.dart';
import 'package:bazarche/domain/usecases/job/send_rate_usecase.dart';
import 'package:bazarche/domain/usecases/user/get_own_comment_usecase.dart';
import 'package:bazarche/presentation/controllers/comments_page_controller.dart';
import 'package:get/get.dart';

class CommentsPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetCommentUseCase>(() => GetCommentUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<SendRateUseCase>(() => SendRateUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetOwnCommentUseCase>(() => GetOwnCommentUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<CommentsPageController>(() => CommentsPageController());

  }

}