import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/data/model/comment_model.dart';
import 'package:bazarche/domain/entities/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentItemWidget extends StatelessWidget {
  final Data comment;

  const CommentItemWidget({Key key, this.comment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: comment.user.profileImage!=null && comment.user.profileImage!=''?
                    Image.network(uploadBaseUrl+'profileImages/'+comment.user.profileImage,fit: BoxFit.cover,):

                    Opacity(
                        opacity: 0.3,
                        child: Icon(Icons.person),
                    )
                  ),
                ),
                Column(children: [
                  Row(
                    children: [
                      Text(comment.user.fullname),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        child: RatingBarIndicator(
                          rating: comment.rate == null?0:comment.rate.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ],
                  )
                ],)
              ],
            ),
            
            Row(
              children: [
                Expanded(
                  child:
                  Container(
                    margin: EdgeInsets.only(right: 100,left: 16.0),

                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        // border: Border.all(color: primaryColor,width: 3),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child:
                      Container(
                          child: Text(comment.content)),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
              child: Divider(),
            )
          ],
        )
      ],),
    );
  }
}
