import 'package:flutter/material.dart';
import 'package:trevago_app/utils/utils.dart';

class StepIndicatorWidget extends StatelessWidget {
  const StepIndicatorWidget({super.key, required this.currentStep, required this.stepNumber, required this.label,});
  final int currentStep;
  final int stepNumber;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: currentStep >= stepNumber ? ColourUtils.blue : ColourUtils.lightGray,
              shape: BoxShape.circle,
            ),
            child: currentStep > stepNumber
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                    applyTextScaling: true,
                  )
                : Text(
                    stepNumber.toString(),
                    style: currentStep < stepNumber ? TextStyleUtils.regularBlack(16) : TextStyleUtils.regularWhite(16),
                  ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              label,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyleUtils.regularBlack(16),
            ),
          ),
        ],
      ),
    );
  }
}
