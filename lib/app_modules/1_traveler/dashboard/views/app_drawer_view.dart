//ignore: must_be_immutable
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_paddings.dart';

class AppDrawerView extends StatelessWidget {
  final bool isFromPendingScreen;

  // -----------------------------------
  // PROPERTIES
  // -----------------------------------
  const AppDrawerView({super.key, this.isFromPendingScreen = false});

  // var loggedInData = storageBox.read(StorageConstants.loggedInData);

  // -----------------------------------
  // build
  // -----------------------------------
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Padding(
        padding: AppPaddings.horizontal,
        child: Column(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [appTextView(text: 'App Drawer')],
                ),
              ),
            ),
            // verticalSizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
