import 'dart:math';

import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../widgets/bouncing_widget.dart';
import '../widgets/sliver_group/src/widget/sliver_group_builder.dart';
import 'custom_scroll.dart';


const double _kFlexibleFromHeight = 0.2;

class SliverBottomSheet2 extends StatefulWidget {
  const SliverBottomSheet2({Key? key}) : super(key: key);

  @override
  State<SliverBottomSheet2> createState() => _SliverBottomSheet2State();
}

class _SliverBottomSheet2State extends State<SliverBottomSheet2> {
  late final ScrollController _controller;
  late final ScrollController _controllerTop;
  // late final CustomScrollController _customScrollController;
  // late final CustomScrollPhysics _customScrollPhysics;
  @override
  void initState() {
    _controllerTop = ScrollController();
    _controller = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    // _customScrollController = CustomScrollController();
    // _customScrollPhysics = const CustomScrollPhysics();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _customScrollController.attach(_controller.position);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.mainBluePurple,
            AppColors.bgLightOrange,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.43],
        ),
        // color: Colors.grey
      ),
      child: Scaffold(
        // backgroundColor: Colors.red,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // ListView(
            //   physics: _customScrollPhysics,
            //   controller: _controllerTop,
            // ),
            // ListView(
            //   controller: _controllerTop,
            // ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 150,
                child: ListView(
                  controller: _controllerTop,
                  // physics: _customScrollPhysics,
                  // padding: EdgeInsets.only(
                  //   top: topPadding,
                  //   bottom: bottomPadding,
                  // ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      child: _BuildTopsideCartWidget(
                        title: 'Додокоины',
                        subtitle: '123',
                        bottom: 'Нажмите, \nчтобы потратить',
                        image: const ClipPath(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Icon(
                            Icons.currency_bitcoin,
                            size: 60,
                          ),
                        ),
                        onPressed: () {
                          // _customScrollPhysics.createBallisticSimulation(FixedScrollMetrics(
                          //   maxScrollExtent: null, minScrollExtent: null, axisDirection: AxisDirection.left,
                          //   viewportDimension: null, pixels: 0,
                          // ), 10000);
                          // print('dada');
                        },
                      ),
                    ),
                    _BuildTopsideCartWidget(
                      title: 'История\nзаказов',
                      bottom: 'Тест',
                      // '${state.ordersHistory.total} ${state.ordersHistory.total.declension('заказ', 'заказа', 'заказов')}',
                      onPressed: () {},
                    ),
                    _BuildTopsideCartWidget(
                      title: 'Адреса\nдоставки',
                      bottom: 'тест 2',
                      onPressed: () {},
                    ),_BuildTopsideCartWidget(
                      title: 'История\nзаказов',
                      bottom: 'Тест',
                      // '${state.ordersHistory.total} ${state.ordersHistory.total.declension('заказ', 'заказа', 'заказов')}',
                      onPressed: () {},
                    ),
                    _BuildTopsideCartWidget(
                      title: 'Адреса\nдоставки',
                      bottom: 'тест 2',
                      onPressed: () {},
                    ),_BuildTopsideCartWidget(
                      title: 'История\nзаказов',
                      bottom: 'Тест',
                      // '${state.ordersHistory.total} ${state.ordersHistory.total.declension('заказ', 'заказа', 'заказов')}',
                      onPressed: () {},
                    ),
                    _BuildTopsideCartWidget(
                      title: 'Адреса\nдоставки',
                      bottom: 'тест 2',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            CustomScrollView(
              controller: _controller,
              slivers: [
                SliverPersistentHeader(
                  delegate: _HeaderDelegate(
                      topController: _controllerTop,
                      // scrollPhysics: _customScrollPhysics,
                      controller: _controller,
                      height: MediaQuery.of(context).size.height *
                          _kFlexibleFromHeight),
                ),
                // const SliverAppBar(
                //   backgroundColor: Colors.transparent,
                //   floating: true,
                //   title: Text('Hello'),
                // ),
                // Sliver(
                //   child: Container(width: 300, height: 300, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),),
                // ),
                SliverGroupBuilder(
                  // borderRadius: BorderRadius.circular(20),
                  decoration: const BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
                  child:
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (ctx, index) => ListTile(
                            title: Text('tile $index'),
                          ),
                          childCount: 40)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const _kMainVerticalPadding = 20.0;
const _kMainHorizontalPadding = 15.0;

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController controller;
  final ScrollController topController;
  // final CustomScrollPhysics scrollPhysics;
  final double height;

  const _HeaderDelegate({
    required this.controller,
    required this.height,
    required this.topController,
    // required this.scrollPhysics,
  });

  double get topPadding => min(
    _kMainVerticalPadding * 2,
    max(
      0,
      _kMainVerticalPadding -
          (controller.hasClients ? controller.offset / 10 : 0),
    ),
  );

  double get bottomPadding => min(
    _kMainVerticalPadding * 2,
    max(
      0,
      _kMainVerticalPadding +
          (controller.hasClients ? controller.offset / 10 : 0),
    ),
  );

  double _getOpacity(BuildContext context) {
    double result = 1;
    if (!controller.hasClients) return result;
    result = 1 -
        (controller.offset /
            ((MediaQuery.of(context).size.height * 0.2) / 100) /
            100);
    if (result < 0) {
      result = 0;
    } else if (result > 1) {
      result = 1;
    }
    return result;
  }

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      fit: StackFit.expand,
      children: [
        const SizedBox.expand(),
        Positioned(
          top: shrinkOffset,
          bottom: controller.offset > 0 ? 0 - shrinkOffset : null,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: _getOpacity(context),
            child: SizedBox(
              height: height,
              child: _BuildListView(topPadding: topPadding, bottomPadding: bottomPadding,
                topController: topController,
                // scrollPhysics: scrollPhysics,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _BuildListView extends StatefulWidget {
  const _BuildListView({
    Key? key,
    required this.topPadding,
    required this.bottomPadding,
    required this.topController,
    // required this.scrollPhysics,
  }) : super(key: key);

  final double topPadding;
  final double bottomPadding;
  final ScrollController topController;
  // final CustomScrollPhysics scrollPhysics;

  @override
  State<_BuildListView> createState() => _BuildListViewState();
}

class _BuildListViewState extends State<_BuildListView> {
  late final ScrollController scrollController;
  late CustomScrollPhysics customScrollPhysics;
  @override
  void initState() {
    scrollController = ScrollController();
    // scrollController = ScrollController()..addListener(() {
    //   widget.topController.jumpTo(scrollController.position.pixels);
    // });
    customScrollPhysics = const CustomScrollPhysics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        // widget.scrollPhysics.createBallisticSimulation(FixedScrollMetrics(
        //   maxScrollExtent: null, minScrollExtent: null, axisDirection: AxisDirection.left,
        //   viewportDimension: null, pixels: 0,
        // ), 10000);
        setState(() {
          customScrollPhysics = customScrollPhysics.copyWith(1000, -500);
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          print(customScrollPhysics.velocity.toString() + '!!!!' + customScrollPhysics.acceleration.toString());
          print('dada');
          scrollController.jumpTo(scrollController.position.pixels);
        });
        // _controllerTop.jumpTo(60);
      },
      child: ListView(
        controller: scrollController,
        physics: customScrollPhysics,
        padding: EdgeInsets.only(
          top: widget.topPadding,
          bottom: widget.bottomPadding,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.red,
            width: 180,
            height: 105,),
          // _BuildTopsideCartWidget(
          //   title: 'Додокоины',
          //   subtitle: '123',
          //   bottom: 'Нажмите, \nчтобы потратить',
          //   image: const ClipPath(
          //     clipBehavior: Clip.antiAliasWithSaveLayer,
          //     // child: Icon(
          //     //   Icons.currency_bitcoin,
          //     //   size: 60,
          //     // ),
          //   ),
          //   onPressed: () {},
          // ),
          // _BuildTopsideCartWidget(
          //   title: 'История\nзаказов',
          //   bottom: 'Тест',
          //   // '${state.ordersHistory.total} ${state.ordersHistory.total.declension('заказ', 'заказа', 'заказов')}',
          //   onPressed: () {},
          // ),
          // _BuildTopsideCartWidget(
          //   title: 'Адреса\nдоставки',
          //   bottom: 'тест 2',
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}

const kMainHorizontalPadding = 15.0;
const kMainBorderRadius = 14.0;

class _BuildTopsideCartWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String bottom;
  final Widget? image;
  final VoidCallback onPressed;
  const _BuildTopsideCartWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.bottom,
    this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 105,
      child: BouncingWidget(
        onPressed: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: image == null ? 50.0 : 0.0,
            bottom: image == null ? kMainHorizontalPadding : 0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (subtitle != null)
                const SizedBox(
                  height: 5,
                ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              const Spacer(),
              // if (subtitle == null) const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bottom,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.mainIconGrey,
                    ),
                  ),
                  if (image != null) image!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends SliverPersistentHeaderDelegate {
  const Header({
    this.maxExtent = 300,
    this.minExtent = 300,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final progress = shrinkOffset / maxExtent;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: maxExtent * 0.6),
      child: _BuildFlexibleList(
        bottomPadding: (40 - shrinkOffset) > 0 ? (40 - shrinkOffset) : 0,
      ),
    );
  }

  @override
  final double maxExtent;

  @override
  final double minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _BuildFlexibleList extends StatelessWidget {
  final double bottomPadding;
  const _BuildFlexibleList({Key? key, required this.bottomPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListView(children: [Text('21')]);
    // return Text('21');
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
          5,
              (index) => Container(
            width: 150,
            height: 0,
            margin:
            EdgeInsets.only(left: 8, right: 8, bottom: bottomPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const FittedBox(
              child: FlutterLogo(),
            ),
          )),
    );
  }
}
