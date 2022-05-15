import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/font_size.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/button/primary_button.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/input/input_page_view_model.dart';
import 'package:best_beer_ranking/ui/text_field/outline_text_from_field.dart';
import 'package:flutter/material.dart';
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
          OutlineTextFieldField(
            label: "[必須] タイトル",
            keyboardType: TextInputType.name,
            initialValue: inputViewModel.title,
            onChanged: (value) {
              inputViewModel.setTitle(value);
            },
          ).padding(
              top: LayoutSize.sizePadding30,
              right: LayoutSize.sizePadding20,
              left: LayoutSize.sizePadding20),
          OutlineTextFieldField(
            label: "メモ",
            keyboardType: TextInputType.text,
            initialValue: inputViewModel.memo,
            onChanged: (value) {
              inputViewModel.setMemo(value);
            },
          ).padding(
              top: LayoutSize.sizePadding16,
              right: LayoutSize.sizePadding20,
              left: LayoutSize.sizePadding20),
          const SizedBox(height: LayoutSize.sizeBox30, width: 0),
          _selectedImage(context, ref),
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
          const SizedBox(height: 16, width: 0),
          Text("※ランキングは次の画面で設定できます", style: TextStyle(fontSize: 18),).padding(
              top: LayoutSize.sizePadding16,
              right: LayoutSize.sizePadding8,
              left: LayoutSize.sizePadding8),
        ],)),
    );
  }

  // Widget _sliderView(WidgetRef ref) {
  //   final viewModel = ref.read(inputViewModelProvider);
  //   final point = ref.watch(inputViewModelProvider).point;
  //   final appColors = ref.watch(appThemeProvider).appColors;
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
  //               child: Text("${point ?? "-"}", style: TextStyle(fontSize: 32), textAlign: TextAlign.center,)
  //           ),
  //           Container(
  //               width: 280,
  //               child: Slider(
  //                 value: viewModel.point?.toDouble() ?? 0,
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
  //               )
  //           )
  //         ],)
  //     ],
  //   ).padding(left: 20, right: 20);
  // }

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

}
