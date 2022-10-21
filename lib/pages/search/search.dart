import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jack_weather_app/widgets/loading.dart';
import 'package:stacked/stacked.dart';
import 'package:jack_weather_app/pages/search/search_vm.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => SearchViewModel(),
        onModelReady: (viewModel) => viewModel.init(),
        onDispose: (viewModel) => viewModel.dispose(),
        builder: (_, viewModel, child) => (Scaffold(
              appBar: AppBar(
                //appbar has input field and search button
                title: TextField(
                  autofocus: true,
                  controller: viewModel.searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search City',
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        //close keyboard
                        FocusScope.of(context).unfocus();

                        //search for city
                        viewModel.search();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: Container(
                  child: viewModel.isBusy
                      ? const Loading()
                      : viewModel.busy(viewModel.citySearch)
                          ? const Loading()
                          : ListView.builder(
                              itemCount: viewModel.citySearch.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(viewModel.getCityString(
                                      viewModel.citySearch[index])),
                                  onTap: () {
                                    //go to home page
                                    Get.toNamed('/',
                                        arguments: viewModel.citySearch[index]);
                                  },
                                );
                              })),
            )));
  }
}
