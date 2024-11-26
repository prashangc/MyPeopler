import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/core.dart';

class SliderDots extends StatefulWidget {
  const SliderDots({super.key,this.itemCount,this.mainIndex,required this.scrollDirection});
  final int? itemCount;
  final int? mainIndex;
  final Axis scrollDirection;
  @override
  State<SliderDots> createState() => _SliderDotsState();
}

class _SliderDotsState extends State<SliderDots> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: widget.itemCount,
        shrinkWrap: true,
        scrollDirection: widget.scrollDirection,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: index == widget.mainIndex ? Icon(Icons.circle,size: 12,color: Pallete.primaryCol):Icon(Icons.circle_outlined,size: 8,),
          );
        },
        ),
    );
  }
}