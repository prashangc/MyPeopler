import 'package:flutter/material.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ProfileImgBox extends StatelessWidget {
  const ProfileImgBox({super.key, this.user, this.isDrawer});
  final User? user;
  final bool? isDrawer;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        ProfileCard(imgUrl: user?.avatar ?? StorageHelper.userAvatar),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            user?.name ?? StorageHelper.userName?[0] ?? "P",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            user?.email ?? StorageHelper.userEmail,
          ),
        ),
        isDrawer != null
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          user?.department_name ?? 'No department assigned.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 32,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('—'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user?.designation_name ?? 'No designation assigned.',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      user?.contact_no_one ?? 'No contact number added.',
                    ),
                  ),
                ],
              )
            : SizedBox.shrink()
      ],
    );
  }
}
