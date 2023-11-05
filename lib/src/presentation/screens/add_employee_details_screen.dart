import 'package:flutter/material.dart';
import 'package:ninjacoder/src/presentation/base/base_state_wrapper.dart';
import 'package:ninjacoder/src/presentation/widgets/calender_dialog.dart';
import 'package:ninjacoder/src/presentation/widgets/mx_appbar.dart';

class AddEmpoyeeDetailsScreen extends StatefulWidget {
  const AddEmpoyeeDetailsScreen({super.key});

  @override
  State<AddEmpoyeeDetailsScreen> createState() =>
      _AddEmpoyeeDetailsScreenState();
}

class _AddEmpoyeeDetailsScreenState
    extends BaseStateWrapper<AddEmpoyeeDetailsScreen> {
  late TextEditingController _controller;
  @override
  void onInit() {
    _controller = TextEditingController();
  }

  @override
  Widget onBuild(
      BuildContext context, BoxConstraints constraints, PlatformType platform) {
    return Scaffold(
      appBar: const MxAppBar(
        title: Text('Add Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                prefixIcon: const Icon(
                  Icons.person_outlined,
                  color: Colors.blue,
                ),
                hintText: 'Employee name',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )),
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Product Designer',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(.5),
                          thickness: 1,
                          height: 0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Flutter Developer',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(.5),
                          thickness: 1,
                          height: 0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'QA Tester',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(.5),
                          thickness: 1,
                          height: 0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Product Owner',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10)
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey)),
                child: const Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Select role'),
                    Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 23),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const CalenderDialog();
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 50,
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '5 Sep 2022',
                          style: TextStyle(
                            color: Color(0xFF323238),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.blue,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const CalenderDialog();
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 50,
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '5 Sep 2022',
                          style: TextStyle(
                            color: Color(0xFF323238),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFEDF8FF),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFF1DA1F2),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onDispose() {}

  @override
  void onPause() {}

  @override
  void onResume() {}
}
