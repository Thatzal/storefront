import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../common/style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 2.0,
                offset: const Offset(1, 4),
              ),
            ],
          ),
          width: 75,
          height: 75,
          child: Center(child: Image.asset("assets/SearchLoading.gif",height: 50,)))
      ],
    );
  }
}

class SearchLoading extends StatelessWidget {
  const SearchLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
        Material(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),color: Colors.white,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            width: 68,
            height: 65,
            child: Center(child: Image.asset("assets/SearchLoading.gif",height: 50,)),),
        )
      ],
    );
  }
}

class LoadingWidgetWithoutBox extends StatelessWidget {
  const LoadingWidgetWithoutBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
        const CupertinoActivityIndicator(animating: true, radius: 15, color: primaryColor)
      ],
    );
  }
}

class paginateLoader extends StatelessWidget {
  const paginateLoader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: 20,
        child: OverflowBox(
          minHeight: 70,
          maxHeight: 70,
          maxWidth: 120,
          minWidth: 120,
          child: Lottie.asset('assets/paginate_loader.json', fit: BoxFit.fill),
        ),
      ),
    );
  }
}