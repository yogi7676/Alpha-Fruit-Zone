import 'package:alphauser/app/constants/assets_path.dart';
import 'package:alphauser/app/constants/app_colors.dart';
import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerification extends StatelessWidget {
  final NetworkManager manager = Get.find();
  PhoneVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
        builder: (builder) => manager.connectionType == 0
            ? const NoInternet()
            : Scaffold(
                appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    title: Obx(() => CustomText(
                          text: !userController.isCodeSent.value
                              ? 'Enter your phone number'
                              : 'Verify One Time Password',
                          size: 18,
                          weight: FontWeight.bold,
                        ))),
                body: Obx(
                  () => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          AssetsPath.holdingPhone,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            !userController.isCodeSent.value
                                ? 'We will send you an sms message to verify your phone number.'
                                : 'Code Sent to ${userController.phoneController.text}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.lightGray)),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: !userController.isCodeSent.value
                                ? 'Enter phone number'
                                : ' Enter OTP',
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 10,
                          controller: !userController.isCodeSent.value
                              ? userController.phoneController
                              : userController.otpController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return !userController.isCodeSent.value
                                  ? 'enter a phone number'
                                  : 'enter one time password';
                            } else if (!userController.isCodeSent.value
                                ? (text.length < 10)
                                : (text.length < 6)) {
                              return !userController.isCodeSent.value
                                  ? 'enter a valid phone number'
                                  : 'enter a valid one time password';
                            }
                            return null;
                          },
                          cursorColor: AppColors.secondary,
                          decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              hintText: !userController.isCodeSent.value
                                  ? 'phone number'
                                  : '6 - digit otp',
                              counterText: '',
                              prefixIcon: Icon(
                                !userController.isCodeSent.value
                                    ? Icons.phone
                                    : Icons.sms,
                                color: AppColors.secondary,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: !userController.isCodeSent.value,
                          child: const CustomText(
                            text: 'SMS Carrier charges may apply.',
                            size: 14,
                            color: AppColors.lightGray,
                          ),
                        ),
                        Visibility(
                            visible: userController.isCodeSent.value,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text('Resend OTP'))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    !userController.isCodeSent.value
                                        ? await userController
                                            .verifyPhoneNumber()
                                        : await userController.verifyOTP();
                                  } catch (e) {
                                    Get.snackbar(
                                        'Phone Verification', e.toString());
                                  }
                                },
                                child: Text(!userController.isCodeSent.value
                                    ? 'Continue'
                                    : 'Verfiy')))
                      ],
                    ),
                  ),
                ),
              ));
  }
}
