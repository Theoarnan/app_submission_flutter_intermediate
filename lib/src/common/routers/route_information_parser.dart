import 'package:app_submission_flutter_intermediate/src/common/routers/page_configuration_model.dart';
import 'package:flutter/material.dart';

class RouteInformationParserCustom
    extends RouteInformationParser<PageConfigurationModel> {
  @override
  Future<PageConfigurationModel> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());
    if (uri.pathSegments.isEmpty) {
      return PageConfigurationModel.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'moments') {
        return PageConfigurationModel.home();
      } else if (first == 'splash') {
        return PageConfigurationModel.splash();
      } else if (first == 'login') {
        return PageConfigurationModel.login();
      } else if (first == 'register') {
        return PageConfigurationModel.register();
      }
      return PageConfigurationModel.unknown();
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1];
      if (first == 'moments' && second == 'setting') {
        return PageConfigurationModel.setting();
      } else if (first == 'moments' && second == 'post') {
        return PageConfigurationModel.postStory();
      }
      return PageConfigurationModel.unknown();
    } else if (uri.pathSegments.length == 3) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final third = uri.pathSegments[2];
      if (first == 'moments' && second == 'detail' && third.isNotEmpty) {
        return PageConfigurationModel.detailStory(third);
      } else if (first == 'moments' && second == 'post' && third == 'camera') {
        return PageConfigurationModel.camera();
      }
      return PageConfigurationModel.unknown();
    }
    return PageConfigurationModel.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(
      PageConfigurationModel configuration) {
    if (configuration.isUnknownPage) {
      return const RouteInformation(location: '/unknown');
    } else if (configuration.isSplashPage) {
      return const RouteInformation(location: '/splash');
    } else if (configuration.isRegisterPage) {
      return const RouteInformation(location: '/register');
    } else if (configuration.isLogginPage) {
      return const RouteInformation(location: '/login');
    } else if (configuration.isHomePage) {
      return const RouteInformation(location: '/moments');
    } else if (configuration.isDetailStoryPage) {
      return RouteInformation(
        location: 'moments/detail/${configuration.storyId}',
      );
    } else if (configuration.isSettingPage) {
      return const RouteInformation(location: '/moments/setting');
    } else if (configuration.isPostStoryPage) {
      return const RouteInformation(location: '/moments/post');
    } else if (configuration.isCamera) {
      return const RouteInformation(location: '/moments/post/camera');
    } else {
      return null;
    }
  }
}
