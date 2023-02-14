import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    implements Exception {
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return Platform.isIOS;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: buildAppBar(),
          drawer: buildDrawer(),
          bottomNavigationBar: buildBottomNavigationBar(),
          floatingActionButton: buildFloatingActionButton(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: buildBody(context),
            ),
          ),
        ),
      ),
    );
  }

  SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light;

  PreferredSizeWidget? buildAppBar() => AppBar(
        elevation: 0.0,
        title: Text(appBarTitle),
      );

  String appBarTitle = '';

  Color? backgroundColor;

  Widget? buildDrawer() => null;

  Widget? buildBottomNavigationBar() => null;

  Widget? buildFloatingActionButton() => null;

  Widget buildBody(BuildContext context);
}
