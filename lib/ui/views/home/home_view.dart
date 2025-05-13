// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_payed/models/entry.dart';
import 'package:food_payed/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:toastification/toastification.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Payed"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout)),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => viewModel.showPayed(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: smallSize),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(smallSize)),
                    child: FutureBuilder(
                        future: viewModel.fetchEntries(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.done) {
                            List<Entry> entries = snap.data as List<Entry>;
                            if (entries.isEmpty) {
                              return const Center(
                                child: Text(
                                  "Keine Einträge vorhande",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.grey),
                                ),
                              );
                            }
                            return ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                itemCount: entries.length,
                                shrinkWrap: true,
                                itemBuilder: (ctx, i) {
                                  return ListTile(
                                    title: Text(entries[i].title),
                                    subtitle: FutureBuilder(
                                        future: viewModel
                                            .getUsername(entries[i].firebaseId),
                                        builder: (ctx, snap) {
                                          if (snap.hasData &&
                                              snap.connectionState ==
                                                  ConnectionState.done) {
                                            String username = snap.data ?? "";
                                            return Text(
                                                "$username am ${entries[i].date}");
                                          }

                                          return const Row(
                                            children: [
                                              SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator()),
                                            ],
                                          );
                                        }),
                                    trailing: IconButton(
                                        iconSize: 32,
                                        icon: const Icon(Icons.delete_outlined),
                                        color: Colors.red,
                                        onPressed: () async {
                                          bool result = await viewModel
                                              .remove(entries[i].id!);
                                          if (result) {
                                            _showSnackbar(
                                                context,
                                                'Erfolgreich gelöscht',
                                                Icons.check_rounded,
                                                Colors.green);
                                          } else {
                                            _showSnackbar(
                                                context,
                                                'Fehler beim Löschen',
                                                Icons.remove_circle_outline,
                                                Colors.red);
                                          }
                                        }),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: viewModel.textController,
                          focusNode: viewModel.focusNode,
                          onSubmitted: (value) => viewModel.add(),
                          decoration: const InputDecoration(
                            hintText: "Titel",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(smallSize),
                                bottomLeft: Radius.circular(smallSize),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(smallSize),
                                bottomLeft: Radius.circular(smallSize),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Material(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(smallSize),
                            bottomRight: Radius.circular(smallSize)),
                        color: Colors.blue,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(smallSize),
                              bottomRight: Radius.circular(smallSize)),
                          onTap: () async {
                            bool result = await viewModel.add();
                            if (result) {
                              _showSnackbar(
                                context,
                                'Erfolgreich hinzugefügt',
                                Icons.check_rounded,
                                Colors.green,
                              );
                            } else {
                              _showSnackbar(
                                context,
                                'Fehler beim hinzufügen',
                                Icons.close_rounded,
                                Colors.red,
                              );
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
                                Icons.add_rounded,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
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

  _showSnackbar(
      BuildContext context, String title, IconData icon, Color color) {
    toastification.show(
        context: context,
        icon: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        autoCloseDuration: const Duration(seconds: 2),
        backgroundColor: color,
        closeButtonShowType: CloseButtonShowType.none);
  }
}
