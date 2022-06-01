import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/mypage/my_page_view_model.dart';
import 'package:best_beer_ranking/ui/text_field/outline_text_from_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(myPageViewModelProvider);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final appColors = ref.read(appThemeProvider).appColors;

    useFuture(
      useMemoized(() {
        if (viewModel.myPageDisplayType == MyPageType.None) {
          viewModel.checkAccount();
        } else if (viewModel.user?.name.isEmpty == true) {
          showUserNameDialog(context, ref);
        }
      }),
    );

    //for navigate
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    final user = ref.watch(myPageViewModelProvider).user;

    if (viewModel.myPageDisplayType == MyPageType.None) {
      return Container();
    }

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (viewModel.user?.name.isEmpty == true) {
        showUserNameDialog(context, ref);
      }
    });

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "マイページ",
            style: TextStyle(color: Colors.black),
          ),
          actions: [IconButton(
              onPressed: () {
                navigator.setting();
              },
              icon: Icon(Icons.settings, color: Colors.black54,))],
        ),
        body: SingleChildScrollView(
          child: (() {
            if (viewModel.myPageDisplayType == MyPageType.ShowLogin) {
              return Column(
                children: [
                  SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: SignInButton(Buttons.Google, onPressed: () async {
                      await viewModel.loginWithGoogle(context);
                    }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: SignInButton(Buttons.Apple, onPressed: () {
                      viewModel.loginWithApple(context);
                    }),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 48,
                  ),
                  InkWell(
                    child: (() {
                      final photoUrl = viewModel.user?.photoUrl ?? "";
                      if (photoUrl.isNotEmpty) {
                        return CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(photoUrl),
                          backgroundColor: Colors.transparent,
                        );
                      } else {
                        return Icon(
                          Icons.account_circle,
                          size: 80,
                          color: Colors.black45,
                        );
                      }
                    })(),
                    onTap: () {
                      viewModel.getImage(ImageSource.gallery);
                    },),
                  OutlineTextFieldField(
                    label: "ユーザー名",
                    keyboardType: TextInputType.name,
                    initialValue: user?.name,
                    onChanged: (value) {
                      viewModel.setName(value);
                    },
                  ).padding(top: 30, right: 20, left: 20),
                  const SizedBox(height: 56, width: 0),
                  SizedBox(
                      width: 240,
                      height: 44,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: appColors.accent),
                        onPressed: () async {
                          if (viewModel.name.isEmpty) {
                            DialogUtil.showAlertDialog(
                                context: context, message: "ユーザー名を入力してください");
                            return;
                          }
                          viewModel.updateUserName(viewModel.name);
                          FocusManager.instance.primaryFocus?.unfocus();
                          DialogUtil.showAlertDialog(
                              context: context, message: "変更しました");
                        },
                        child: Text("変更する"),
                      )),
                  const SizedBox(height: 24, width: 0),
                  SizedBox(
                      width: 240,
                      height: 44,
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(primary: appColors.accent),
                        onPressed: () async {
                          viewModel.syncData();
                        },
                        child: Text("同期する"),
                      )),
                ],
              );
            }
          })(),
        ));
  }

  showUserNameDialog(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(myPageViewModelProvider);
    var inputText = "";
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('ユーザー名を入力してください'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "ユーザー名"),
                  onChanged: (text) {
                    inputText = text;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  '登録する',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
                onPressed: () async {
                  viewModel.updateUserName(inputText);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
