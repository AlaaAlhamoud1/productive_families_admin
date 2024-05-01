import 'package:flutter/material.dart';
import 'package:productive_families_admin/core/colors.dart';

class OtherItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final String image;
  const OtherItemCard({
    Key? key,
    required this.title,
    this.onClick,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 6,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.1),
              blurStyle: BlurStyle.normal,
              offset: const Offset(0, 0)),
        ]),
        child: InkWell(
          onTap: onClick,
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(image),
                  )),
                  Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: TextStyle(color: AppColors.appColor),
                    ),
                  ),
                  IconButton(
                      onPressed: onClick,
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
