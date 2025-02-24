// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_payed/models/entry.dart';
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
                    child: FutureBuilder(
                        future: viewModel.fetchEntries(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.done) {
                            List<Entry> entries = snap.data as List<Entry>;
                            return ListView.builder(
                                itemCount: entries.length,
                                shrinkWrap: true,
                                itemBuilder: (ctx, i) {
                                  return ListTile(
                                    title: Text(entries[i].title),
                                    subtitle: Text(entries[i].date.toString()),
                                  );
                                });
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ),
                verticalSpaceSmall,
                TextField(
                  controller: viewModel.textController,
                  decoration: const InputDecoration(
                    hintText: "Titel",
                  ),
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _segmentButton(context, 'Denise', 'd', viewModel.add,
                        viewModel.remove),
                    _segmentButton(
                        context, 'Felix', 'f', viewModel.add, viewModel.remove),
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

  _segmentButton(BuildContext context, String name, String key,
      Future<bool> Function(String) add, Future<bool> Function(String) remove) {
    return Column(
      children: [
        Text(
          name,
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
                onTap: () async {
                  bool result = await remove(key);
                  if (result) {
                    _showSnackbar(
                        context, 'Erfolgreich gelöscht', Colors.green);
                  } else {
                    _showSnackbar(context, 'Fehler beim Löschen', Colors.red);
                  }
                },
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
                onTap: () async {
                  bool result = await add(key);
                  if (result) {
                    _showSnackbar(
                        context, 'Erfolgreich hinzugefügt', Colors.green);
                  } else {
                    _showSnackbar(
                        context, 'Fehler beim hinzufügen', Colors.red);
                  }
                },
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

  _showSnackbar(BuildContext context, String title, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        elevation: 1,
        backgroundColor: color,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
