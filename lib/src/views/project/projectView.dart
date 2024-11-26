import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {

  @override
  void initState() {
     Get.find<ProjectController>().refreshProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
            ),
          );
        }),
        title: Text("To Do"),
        automaticallyImplyLeading: false,
        actions: [
          GetBuilder<ProjectController>(builder: (projectController) {
            return PopupMenuButton<String>(
              onSelected: (val) {
                projectController.setSelectedProjectId(val);
              },
              itemBuilder: (context) {
                return [
                  ...projectController.projects.map(
                    (e) => PopupMenuItem(
                      value: projectController.projects.indexOf(e).toString(),
                      child: Text(e.name ?? ""),
                    ),
                  ),
                ];
              },
            );
          })
        ],
      ),
      body: GetBuilder<ProjectController>(
        builder: (projectController) {
          if (projectController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (projectController.project == null) {
            return NoDataWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ProjectTile(
                project: projectController.project!,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  const ProjectTile({Key? key, required this.project}) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GetBuilder<ProjectController>(builder: (projectContrller) {
          //   return CustomDFF(
          //     name: "Select Project",
          //     items: [
          //       ...projectContrller.projects.map(
          //         (e) => DropdownMenuItem(
          //           value: projectContrller.projects.indexOf(e).toString(),
          //           child: Text(e.name ?? ""),
          //         ),
          //       ),
          //     ],
          //     hideLabel: true,
          //     onChanged: (val) {
          //       if (val == null || val.isEmpty) {
          //         return;
          //       }
          //       projectContrller.setSelectedProjectId(val);
          //     },
          //     value: projectContrller.selectedProjectId.value,
          //   );
          // }),
          Text(
            project.name ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Visibility(
            visible: project.description != null,
            child: Text(
              project.description ?? "",
            ),
          ),
          Divider(),
          ListView.builder(
            itemCount: project.task_groups?.length ?? [].length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              TaskGroup taskGroup = project.task_groups![index];
              return Container(
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 5),
                //       child: Text(
                //         taskGroup.name ?? "",
                //         style: TextStyle(
                //           fontWeight: FontWeight.w500,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ),
                //     ...taskGroup.tasks!.map(
                //       (e) => Text(e.name ?? ""),
                //     ),
                //   ],
                // ),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(taskGroup.name ?? ""),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      ...taskGroup.tasks!.map(
                        (e) => Container(
                          decoration: BoxDecoration(
                              // color: Pallete.white,
                              border: Border(
                                  top: BorderSide(color: Colors.white70))),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: Text(e.name ?? ""),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
