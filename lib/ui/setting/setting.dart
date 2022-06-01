import 'package:best_beer_ranking/ui/setting/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(settingViewModelProvider);
    final _scaffoldKey = GlobalKey<ScaffoldState>();



    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "設定",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.black54,))
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            TextButton(
                onPressed: (){},
                child: Container(
                    child: Text("お問い合わせ", style: TextStyle(color: Colors.black87),).paddingEdge(EdgeInsets.all(8)),
                    width: double.infinity)
            ),
            TextButton(
                onPressed: (){},
                child: Container(
                    child: Text("利用規約", style: TextStyle(color: Colors.black87)).paddingEdge(EdgeInsets.all(8)),
                    width: double.infinity)
            ),
            TextButton(
                onPressed: () async {
                  const url = "https://forms.gle/uTRdXyftNtNwuKG98";
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Container(
                    child: Text("プライバシー", style: TextStyle(color: Colors.black87)).paddingEdge(EdgeInsets.all(8)),
                    width: double.infinity)
            ),
          ],),
        ));
  }
}
