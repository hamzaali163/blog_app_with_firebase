import 'package:blog_app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const RoundButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 48,
        width: 342,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.mainColor,
        ),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
      ),
    );
  }
}

class RoundButtonTwo extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const RoundButtonTwo(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 48,
        width: 342,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.mainColor,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const AuthButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 48,
        width: 342,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.mainColor, // Specify the color of the border
            width: 2.0, // Specify the width of the border
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.whitecolor,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            const Icon(Icons.phone_android),
            const SizedBox(
              width: 11,
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const GoogleButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 48,
        width: 342,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.mainColor, // Specify the color of the border
            width: 2.0, // Specify the width of the border
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.whitecolor,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            const FaIcon(FontAwesomeIcons.google),
            const SizedBox(
              width: 11,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
