import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jack_weather_app/model/weather_model.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import '../../model/city_search_model.dart';
import '../../widgets/loading.dart';
import 'home_vm.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (viewModel) => {
              //get the city from the search page
              Get.arguments != null
                  ? viewModel.init(citySearchObj: Get.arguments as CitySearch)
                  : viewModel.init()

              // print("Home Get.arguments: ${jsonEncode(Get.arguments)}"),
            },
        builder: (_, viewModel, child) => (Scaffold(
              appBar: AppBar(
                leading: Container(),
                centerTitle: true,
                title: Text(
                  '${viewModel.city!.name} Weather',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        //go to search page
                        Get.toNamed('/search');
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: Container(
                  child: viewModel.isBusy
                      ? const Loading()
                      : viewModel.busy(viewModel.weatherObj)
                          ? const Loading()
                          : ListView(
                              children: [
                                Offstage(
                                  offstage: viewModel.busy(viewModel.city),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${viewModel.weather!.main.temp} °C',
                                          style: const TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          viewModel.weather!.weather[0].main,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(DateTime.now()),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataTable(
                                  columns: [
                                    DataColumn(
                                      label: const Text('Date Time'),
                                      onSort: (columnIndex, sortAscending) {
                                        //sort the list
                                        viewModel.sortDate();
                                      },
                                    ),
                                    const DataColumn(
                                      label: Text('Weather'),
                                    ),
                                    const DataColumn(
                                      label: Text('Temperature'),
                                    )
                                  ],
                                  rows: viewModel.weatherObj.map((e) {
                                    return DataRow(cells: [
                                      DataCell(Text(DateFormat.yMd()
                                          .add_jm()
                                          .format(e.dtTxt))),
                                      DataCell(Text(e.weather[0].main)),
                                      DataCell(Center(
                                          child: Text('${e.main.temp} °C'))),
                                    ]);
                                  }).toList(),
                                  sortColumnIndex: 1,
                                  sortAscending: viewModel.sortAsc,
                                ),
                              ],
                            )),
            )));
  }
}
