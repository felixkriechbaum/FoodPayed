import 'package:flutter/material.dart';
import 'package:food_payed/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: smallSize),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Wer hat wann zuletzt gezahlt?",
                  style: TextStyle(fontSize: 24),
                ),
                verticalSpaceSmall,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(smallSize)),
                    child: ListView.builder(
                        itemCount: 200,
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          return const ListTile(
                            title: Text("test"),
                          );
                        }),
                  ),
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _segmentButton(
                        'Denise', viewModel.add('d'), viewModel.remove('d')),
                    _segmentButton(
                        'Felix', viewModel.add('f'), viewModel.remove('f')),
                  ],
                ),
                verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  _segmentButton(String s, void add, void remove) {
    return Column(
      children: [
        Text(
          s,
          style: const TextStyle(color: Colors.black),
        ),
        Row(
          children: [
            Material(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(smallSize),
                  bottomLeft: Radius.circular(smallSize)),
              color: Colors.blue,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(smallSize),
                    bottomLeft: Radius.circular(smallSize)),
                onTap: () => remove,
                child: Container(
                    width: 75,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(smallSize),
                          bottomLeft: Radius.circular(smallSize)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: smallSize, horizontal: smallSize),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    )),
              ),
            ),
            Material(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(smallSize),
                  bottomRight: Radius.circular(smallSize)),
              color: Colors.blue,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(smallSize),
                    bottomRight: Radius.circular(smallSize)),
                onTap: () => add,
                child: Container(
                    width: 75,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(smallSize),
                          bottomRight: Radius.circular(smallSize)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: smallSize, horizontal: smallSize),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
