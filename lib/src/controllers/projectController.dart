import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/src/models/models.dart';

import '../repository/repository.dart';

class ProjectController extends GetxController {
  ProjectController(this._projectRepository);

  final ProjectRepository _projectRepository;

  final Rx<ProjectResponse?> _projectResponse = Rx<ProjectResponse?>(null);
  Project? get project {
    if (_projectResponse.value == null) {
      return null;
    }
    if (projects.isEmpty) {
      return null;
    }
    var index = int.tryParse(selectedProjectId.value);
    if (index == null) {
      return null;
    }
    return projects[index];
  }

  List<Project> get projects => _projectResponse.value?.data ?? [];

  var isLoading = false.obs;

  var selectedProjectId = "0".obs;

  setSelectedProjectId(String id) {
    if (id == selectedProjectId.value) {
      return;
    }
    selectedProjectId(id);
    update();
  }

  getProjects() async {
    var res = await _projectRepository.getProject();
    if (!res.hasError) {
      _projectResponse.value = res.data as ProjectResponse;
      log(_projectResponse.value.toString(), name: "ProjectController");
      update();
    }
  }

  Future<void> refreshProjects() async {
    isLoading(true);
    update();
    await getProjects();
    isLoading(false);
    update();
  }

 
}
