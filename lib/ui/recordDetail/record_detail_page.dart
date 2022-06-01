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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
              height: 16,
            ),
            _rankingHeader(ref, record),
            SizedBox(
              height: 8,
            ),
            _rankingChangeButtons(ref, record),
            SizedBox(
              height: 8,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Divider(
                  height: 10,
                  color: Colors.black54,
                )),
            _inputRecordDetail(context, ref),
            SizedBox(
              height: 32,
            ),
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

  Widget _rankingChangeButtons(WidgetRef ref, Record record) {
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

  Widget _inputRecordDetail(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(recordDetailViewModelProvider);
    final appColors = ref.read(appThemeProvider).appColors;

    final evaluation = ref.watch(recordDetailViewModelProvider).evaluation;
    final sharpPoint = ref.watch(recordDetailViewModelProvider).sharpPoint;
    final acidityPoint = ref.watch(recordDetailViewModelProvider).acidityPoint;
    final bitterPoint = ref.watch(recordDetailViewModelProvider).bitterPoint;
    final sweetPoint = ref.watch(recordDetailViewModelProvider).sweetPoint;
    final richPoint = ref.watch(recordDetailViewModelProvider).richPoint;
    final fragrancePoint = ref.watch(recordDetailViewModelProvider).fragrancePoint;

    return Column(children: [
      OutlineTextFieldField(
        label: "[必須] タイトル",
        keyboardType: TextInputType.name,
        initialValue: viewModel.title,
        onChanged: (value) {
          viewModel.setTitle(value);
        },
      ).padding(
          top: LayoutSize.sizePadding16,
          right: LayoutSize.sizePadding20,
          left: LayoutSize.sizePadding20),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Container(
          width: double.infinity,
          child: Text(
            "サムネイル画像",
            style: TextStyle(
                color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20, bottom: 16)
      ),
      _rankingImageView(context, ref, record),
      const SizedBox(height: LayoutSize.sizePadding30, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "総合評価",
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt14),)
                .padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${evaluation ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: evaluation ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setEvaluation(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Divider(
            height: 10,
            color: Colors.black54,
          )),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "キレ",
              style: TextStyle(
                  color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${sharpPoint ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: sharpPoint ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setSharpPoint(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "酸味",
              style: TextStyle(
                  color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${acidityPoint ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: acidityPoint ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setAcidityPoint(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "苦味",
              style: TextStyle(
                  color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${bitterPoint ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: bitterPoint ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setBitterPoint(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "甘味",
              style: TextStyle(
                  color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${sweetPoint ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: sweetPoint ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setSweetPoint(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "コク",
              style: TextStyle(
                  color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${richPoint ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: richPoint ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setRichPoint(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding16, width: 0),
      Column(children: [
        Container(
            width: double.infinity,
            child: Text(
              "香り",
              style: TextStyle(
                  color: appColors.secondaryText, fontSize: FontSize.pt14),).padding(left: 20)
        ),
        Row(children: [
          Container(
            width: 80,
            child: Text(
              "${fragrancePoint ?? "-"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColors.secondaryText,
                  fontSize: FontSize.pt28),),),
          RatingBar.builder(
            initialRating: fragrancePoint ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 48,
            ),
            onRatingUpdate: (rating) {
              viewModel.setFragrancePoint(rating);
            },
          ),

        ],)
      ],),
      const SizedBox(height: LayoutSize.sizePadding8, width: 0),
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
    ],);
  }

  showImageModalPopup(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(recordDetailViewModelProvider);
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('カメラで撮影する'),
              onPressed: () => {
                viewModel.getImage(ImageSource.camera)
              },
            ),
            CupertinoActionSheetAction(
              child: Text('端末にある画像を使う'),
              onPressed: () => {
                viewModel.getImage(ImageSource.gallery)
              },
            ),
          ],
          cancelButton: CupertinoButton(
            child: Text('cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );

  }

  Widget _rankingImageView(BuildContext context, WidgetRef ref, Record record) {
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
          showImageModalPopup(context, ref);
        },
      );
    }

    final image = ref.watch(recordDetailViewModelProvider).image;
    if (image != null) {
      return InkWell(
        child: Container(
          color: Colors.black12,
          width: 200,
          height: 200,
          child: image,
        ),
        onTap: () {
          showImageModalPopup(context, ref);
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
        showImageModalPopup(context, ref);
      },
    );
  }
}
