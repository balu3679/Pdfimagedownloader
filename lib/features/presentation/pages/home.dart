import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/features/data/controllers/homectrller.dart';
import 'package:todo_app/features/presentation/bloc/filebloc/filebloc_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Homectrller homectrller;

  @override
  void initState() {
    homectrller = Get.put(Homectrller());
    context.read<FileblocBloc>().add(LoadSavedFilesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(onPressed: homectrller.logout, icon: Icon(Icons.logout)),
          ),
        ],
      ),
      body: BlocBuilder<FileblocBloc, FileblocState>(
        builder: (context, state) {
          if (state is FileblocEvent) {
            return Center(child: Text("No file picked"));
          } else if (state is FileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FileLoaded) {
            final file = state.files;
            log('message : $file');
            return statebody(file);
          } else if (state is FileError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<FileblocBloc>().add(PickFileEvent()),
        child: Icon(Icons.upload_file),
      ),
    );
  }

  Widget statebody(List<File> files) {
    return ListView.builder(
      itemCount: files.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final file = files[index];
        return Card(
          child: ListTile(
            title: Text(file.path.split('/').last),
            trailing: IconButton(
              icon: Icon(Icons.visibility_outlined),
              onPressed: () => Get.toNamed(Routes.preview, arguments: File(file.path)),
            ),
          ),
        );
      },
    );
  }
}
