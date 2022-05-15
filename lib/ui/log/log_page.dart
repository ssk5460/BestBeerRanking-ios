import 'package:best_beer_ranking/data/foundation/extension/date_time.dart';
import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/log/log_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';

class LogPage extends HookConsumerWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logViewModel = ref.read(logViewModelProvider);
    final appColors = ref.watch(appThemeProvider).appColors;

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    //for navigate
    final navigator = ref.watch(appNavigationStackProvider.notifier);

    // Get trip information at first open log page
    final snapshot = useFuture(
      useMemoized(() {
        logViewModel.loadHomeData();
      }),
    );
    final records = ref.watch(logViewModelProvider).records;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black12,
          appBar: AppBar(
            centerTitle: true,
            title: _segmentedControl(ref),
          ),
          body: SafeArea(
              child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Card(
                    elevation: 4.0,
                    key: Key("${record.id}"),
                    child: ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(LayoutSize.borderRadius),
                              shape: BoxShape.rectangle, color: appColors.background),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${record.recordedAt?.formatYYYY()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text("${record.recordedAt?.formatMMdd()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text("${record.recordedAt?.formatHHmm()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          )),
                      title: Text(record.title),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Assets.svgs.crown.svg(
                              width: LayoutSize.sizeBox10,
                              height: LayoutSize.sizeBox10,
                              color: Colors.black45),
                          SizedBox(
                            width: 4,
                          ),
                          Text("${record.ranking ?? "-"}位"),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      onTap: () {
                        navigator.recordDetail(record);
                      },
                    ),
                  ));
            },
          ))),
    );
  }

  Widget _segmentedControl(WidgetRef ref) {
    final logViewModel = ref.read(logViewModelProvider);
    final selectedSegmentedControlIndex =
        ref.watch(logViewModelProvider).selectedSegmentedControlIndex;

    return CupertinoSlidingSegmentedControl(
        groupValue: selectedSegmentedControlIndex,
        backgroundColor: Colors.black12,
        children: logViewModel.logSegmentedControl,
        onValueChanged: (value) {
          logViewModel.setSegmentedControlIndex(value as int);
        });
  }
}
