import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/font_size.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/button/primary_button.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/input/input_page_view_model.dart';
import 'package:best_beer_ranking/ui/text_field/outline_text_from_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class InputPage extends HookConsumerWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputViewModel = ref.read(inputViewModelProvider);
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    final appColors = ref.watch(appThemeProvider).appColors;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              navigator.pop();
            },
          ),
        ),
        body: SingleChildScrollView(child: Column(children: [
          Text("※ランキングは次の画面で設定できます", style: TextStyle(fontSize: 18),).padding(
              top: LayoutSize.sizePadding16,
              right: LayoutSize.sizePadding8,
              left: LayoutSize.sizePadding8),
          const SizedBox(height: 16, width: 0),
          _inputRecordDetail(context, ref),
          const SizedBox(height: 48, width: 0),
          SizedBox(
              width: 240,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: appColors.accent),
                onPressed: () async {
                  if (inputViewModel.title.isEmpty) {
                    DialogUtil.showAlertDialog(context: context, message: "タイトルは必須です");
                    return;
                  }
                  final record = await inputViewModel.save();
                  FocusManager.instance.primaryFocus?.unfocus();
                  navigator.recordSetting(record!);
                },
                child: Text("記録する"),),

          ),
          const SizedBox(height: 48, width: 0),
        ],)),
    );
  }


  Widget _selectedImage(BuildContext context, WidgetRef ref) {
    final inputViewModel = ref.read(inputViewModelProvider);
    final imageFile = ref.watch(inputViewModelProvider.select((value) => value.imageFile));
    if (imageFile != null) {
      Image image = Image.file(imageFile);
      return InkWell(
        child: Container(
          color: Colors.black12,
          width: 200,
          height: 200,
          child: image,),
        onTap: () {
          inputViewModel.getImage(ImageSource.gallery);
        },
      );
    }
    return InkWell(
      child: Container(
        color: Colors.black12,
        width: 200,
        height: 200,
        child: const Icon(Icons.image_outlined, size: 150),),
      onTap: () {
        inputViewModel.getImage(ImageSource.gallery);
      },
    );
  }

  Widget _inputRecordDetail(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(inputViewModelProvider);
    final appColors = ref.read(appThemeProvider).appColors;

    final evaluation = ref.watch(inputViewModelProvider).evaluation;
    final sharpPoint = ref.watch(inputViewModelProvider).sharpPoint;
    final acidityPoint = ref.watch(inputViewModelProvider).acidityPoint;
    final bitterPoint = ref.watch(inputViewModelProvider).bitterPoint;
    final sweetPoint = ref.watch(inputViewModelProvider).sweetPoint;
    final richPoint = ref.watch(inputViewModelProvider).richPoint;
    final fragrancePoint = ref.watch(inputViewModelProvider).fragrancePoint;

    return Column(children: [
      OutlineTextFieldField(
        label: "[必須] タイトル",
        keyboardType: TextInputType.name,
        initialValue: "",
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
      _selectedImage(context, ref),
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
    final viewModel = ref.read(inputViewModelProvider);
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
}
