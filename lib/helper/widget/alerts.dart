import 'package:english_learning/helper/extension/context_extension.dart';
import 'package:flutter/material.dart';

import 'custom_preloader.dart';
import 'empty_spacer_helper.dart';

class Alerts {
  confirmationAlert({
    required BuildContext context,
    required String title,
    String? description,
    String? buttonText,
    required Future Function() onConfirm,
    Color? buttonColor,
  }) async {
    ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: context.width - 80,
              decoration: BoxDecoration(
                  color: context.dProvider.whiteColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Center(
                        child: Text(
                          title,
                          style: context.titleLarge?.bold6,
                        ),
                      ),
                      EmptySpace.emptyHeight(4),
                      Center(
                        child: Text(
                          description ?? '',
                          style: context.titleMedium,
                        ),
                      ),
                      EmptySpace.emptyHeight(4),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: OutlinedButton(
                              onPressed: () {
                                context.popFalse;
                              },
                              child: Text(
                                'Cancel',
                                style: context.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          ValueListenableBuilder(
                              valueListenable: loadingNotifier,
                              builder: (context, value, child) {
                                return Expanded(
                                  flex: 8,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      loadingNotifier.value = true;
                                      onConfirm().then((value) =>
                                          loadingNotifier.value = false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor ??
                                          context.dProvider.redColor,
                                    ),
                                    child: value
                                        ? const SizedBox(
                                            height: 40,
                                            child: CustomPreloader(
                                              whiteColor: true,
                                            ),
                                          )
                                        : Text(
                                            buttonText ?? "Confirm",
                                            style: context.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: context
                                                    .dProvider.whiteColor),
                                          ),
                                  ),
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
