import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/font_size.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/button/primary_button.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/recordDetail/record_detail_page_view_model.dart';
import 'package:best_beer_ranking/ui/text_field/outline_text_from_field.dart';
import 'package:best_beer_ranking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RecordDetailPage extends HookConsumerWidget {
  final Record record;

  const RecordDetailPage({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(recordDetailViewModelProvider);
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    final appColors = ref.read(appThemeProvider).appColors;
    useFuture(
      useMemoized(() {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          viewModel.setRecord(this.record);
        });
      }),
    );
    final record = ref.watch(recordDetailViewModelProvider).record;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            _rankingHeader(ref, record),
            SizedBox(
              height: 24,
            ),
            _rankingChengeButtons(ref, record),
            SizedBox(
              height: 8,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Divider(
                  height: 10,
                  color: Colors.black54,
                )),
            OutlineTextFieldField(
              label: "[必須] タイトル",
              keyboardType: TextInputType.name,
              initialValue: viewModel.title,
              onChanged: (value) {
                viewModel.setTitle(value);
              },
            ).padding(
                top: LayoutSize.sizePadding30,
                right: LayoutSize.sizePadding20,
                left: LayoutSize.sizePadding20),
            OutlineTextFieldField(
              label: "メモ",
              keyboardType: TextInputType.multiline,
              initialValue: viewModel.memo,
              onChanged: (value) {
                viewModel.setMemo(value);
              },
            ).padding(
                top: LayoutSize.sizePadding30,
                right: LayoutSize.sizePadding20,
                left: LayoutSize.sizePadding20),
            const SizedBox(height: LayoutSize.sizePadding30, width: 0),
            _rankingImageView(ref, record),
            const SizedBox(height: 56, width: 0),
            SizedBox(
                width: 240,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: appColors.accent),
                  onPressed: () async {
                    if (viewModel.title?.isEmpty == true) {
                      DialogUtil.showAlertDialog(context: context, message: "タイトルは必須です");
                      return;
                    }
                    await viewModel.update();
                    FocusManager.instance.primaryFocus?.unfocus();
                    DialogUtil.showAlertDialog(context: context, message: "変更しました");
                  },
                  child: Text("変更する"),)
            ),
            const SizedBox(height: 24, width: 0),
            TextButton(
                onPressed: () async {
                  DialogUtil.showAlertDialog(
                      context: context,
                      message: "削除しますか？",
                      positiveText: "OK",
                      onPositivePress: () async {
                        await viewModel.delete(record);
                        navigator.pop();
                      },
                      negativeText: "キャンセル",
                      onNegativePress: () {
                        navigator.pop();
                      });
                },
                child: Text(
                  "削除する",
                  style: TextStyle(color: Colors.black54,
                    decoration: TextDecoration.underline,
                  ),
                )),
            const SizedBox(height: 80, width: 0),
          ],
        )));
  }

  Widget _rankingHeader(WidgetRef ref, Record record) {
    final appColors = ref.read(appThemeProvider).appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (() {
          final ranking = record.ranking ?? 100;
          if (ranking < 4) {
            return Row(
              children: [
                Assets.svgs.crown.svg(
                    width: LayoutSize.sizeBox50,
                    height: LayoutSize.sizeBox50,
                    color: appColors.rankingColor(ranking)),
                SizedBox(
                  width: 8,
                )
              ],
            );
          } else {
            return Container();
          }
        })(),
        Text(
          "${record.ranking ?? "-"}位",
          style: TextStyle(fontSize: 32),
        )
      ],
    );
  }

  Widget _rankingChengeButtons(WidgetRef ref, Record record) {
    final viewModel = ref.read(recordDetailViewModelProvider);
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    final appColors = ref.read(appThemeProvider).appColors;
    if (record.ranking == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: ElevatedButton(
            onPressed: () {
              navigator.recordSetting(record);
            },
            child: Text(
              "ランキングに追加",
            ),
            style: ElevatedButton.styleFrom(primary: appColors.accent),
          )),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            navigator.recordSetting(record);
          },
          child: Text(
            "ランキング変更",
          ),
          style: ElevatedButton.styleFrom(primary: appColors.accent),
        ),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.removeRanking(record);
          },
          child: Text(
            "ランキングから外す",
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Widget _sliderView(WidgetRef ref, Record record) {
  //   final viewModel = ref.read(recordDetailViewModelProvider);
  //   final point = ref.watch(recordDetailViewModelProvider).point;
  //   final appColors = ref.watch(appThemeProvider).appColors;
  //
  //   return Column(
  //     children: [
  //       Container(
  //         width: double.infinity,
  //         child: Text(
  //           "点数",
  //           style: TextStyle(
  //               color: appColors.secondaryText, fontSize: FontSize.pt10),
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           Container(
  //               width: 56,
  //               child: Text(
  //                 "${point ?? "-"}",
  //                 style: TextStyle(fontSize: 32),
  //                 textAlign: TextAlign.center,
  //               )),
  //           Container(
  //               width: 280,
  //               child: Slider(
  //                 value: (point ?? 0).toDouble(),
  //                 thumbColor: appColors.accent,
  //                 activeColor: appColors.accent,
  //                 inactiveColor: Colors.black12,
  //                 max: 100,
  //                 min: 0,
  //                 divisions: 100,
  //                 label: "${point ?? "-"}",
  //                 onChanged: (double value) {
  //                   viewModel.setPoint(value.toInt());
  //                 },
  //               ))
  //         ],
  //       )
  //     ],
  //   ).padding(left: 20, right: 20);
  // }

  Widget _rankingImageView(WidgetRef ref, Record record) {
    final viewModel = ref.read(recordDetailViewModelProvider);
    final imageFile = ref.watch(recordDetailViewModelProvider).imageFile;
    if (imageFile != null) {
      return InkWell(
        child: Container(
          color: Colors.black12,
          width: 200,
          height: 200,
          child: Image.file(imageFile),
        ),
        onTap: () {
          viewModel.getImage(ImageSource.gallery);
        },
      );
    }

    final image = Utils.imageFromBase64String(record.imageBase64String);
    if (image != null) {
      return InkWell(
        child: Container(
          color: Colors.black12,
          width: 200,
          height: 200,
          child: image,
        ),
        onTap: () {
          viewModel.getImage(ImageSource.gallery);
        },
      );
    }

    return InkWell(
      child: Container(
        color: Colors.black12,
        width: 200,
        height: 200,
        child: const Icon(Icons.image_outlined, size: 150),
      ),
      onTap: () {
        viewModel.getImage(ImageSource.gallery);
      },
    );
  }
}
