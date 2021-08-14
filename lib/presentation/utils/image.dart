import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image/image.dart' as Im;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class MyImage{

  static final MyImage _myImage = MyImage._internal();

  factory MyImage() {
    return _myImage;
  }
  MyImage._internal();
  static Future<void> _getCompressedImage(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();

    sendPort.send(receivePort.sendPort);
    List msg = (await receivePort.first) as List;

    String srcPath = msg[0];
    String name = msg[1];
    String destDirPath = msg[2];
    SendPort replyPort = msg[3];

    // int quality = 100;
    // File destFile = new File(destDirPath + '/' + name);
    // File result = await FlutterImageCompress.compressAndGetFile(
    //   srcPath, destFile.path,
    //   quality: 88,
    // );

    // print('before:${file.lengthSync()}');
    // print('after:${result.lengthSync()}');
    // File compressedFile = await FlutterNativeImage.compressImage(srcPath,
    //     quality: quality, percentage: 100);
    // do {
    //   if(compressedFile.lengthSync()>100000) {
    //     quality-=10;
    //     compressedFile =
    //     await FlutterNativeImage.compressImage(
    //         srcPath,
    //         quality: quality,
    //         percentage: 100);
    //     print("after:"+compressedFile.lengthSync().toString());
    //   } else
    //     break;
    // } while (true);
    // replyPort.send(compressedFile.path);
    Im.Image image =
    Im.decodeImage(await new File(srcPath).readAsBytes());

    if (image.width > 800 || image.height > 800) {
      image = Im.copyResize(image, width: 800,height: 800,);
    }

    File destFile = new File(destDirPath + '/' + name);
    await destFile.writeAsBytes(Im.encodeJpg(image, quality: 80));
    print('ImageLength:'+destFile.lengthSync().toString());
    replyPort.send(destFile.path);
  }

  Future<File> compress(XFile f) async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_getCompressedImage, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;

    ReceivePort receivePort2 = ReceivePort();

    sendPort.send([
      f.path,
      // f.uri.pathSegments.last,
      'image_${getRandomString(10)}.jpg',
      (await getTemporaryDirectory()).path,
      receivePort2.sendPort,
    ]);

    var msg = await receivePort2.first;

    return new File(msg);
  }
  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}