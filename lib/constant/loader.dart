import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading{
  onLoading()async{
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }
  onDone() async {
    await EasyLoading.dismiss();
  }

  onSuccess({msg})async{
    await EasyLoading.showSuccess('${msg}');
  }

  onError({msg})async{
    await EasyLoading.showInfo('${msg}');
  }
}

class ButtonLoaderWhite extends StatelessWidget {
  const ButtonLoaderWhite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CupertinoActivityIndicator(
          color: CupertinoColors.white,
          animating: true,
          radius: 10,
        ),
      ),
    );
  }
}

class ButtonLoaderGreen extends StatelessWidget {
  const ButtonLoaderGreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CupertinoActivityIndicator(
          color: CupertinoColors.activeGreen,
          animating: true,
          radius: 10,
        ),
      ),
    );
  }
}
