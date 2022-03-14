import 'package:blue_app/style/colors.dart';
import 'package:blue_app/style/texts.dart';
import 'package:flutter/material.dart';

class AdjustField extends StatefulWidget {
  const AdjustField({
    Key? key,
    required this.controller,
    this.optionalDescriptionText,
    this.watchValue,
  }) : super(key: key);

  final TextEditingController controller;
  final String? optionalDescriptionText;
  final String? watchValue;

  @override
  State<AdjustField> createState() => _AdjustFieldState();
}

class _AdjustFieldState extends State<AdjustField> {
  @override
  void initState() {
    super.initState();
    // Preenche o field vazio com o valor atual do watchValue
    // Caso o valor seja nulo, preenche com um texto padrão indicativo
    widget.controller.text = widget.watchValue ?? "---";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.optionalDescriptionText != null,
          child: ConfigButtonText(widget.optionalDescriptionText ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: widget.controller,
            maxLength: 5,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            cursorColor: AppColors.standardRed,
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: widget.controller.text == widget.watchValue
                    ? const BorderSide(
                        color: AppColors.standardGreen,
                        width: 1.5,
                      )
                    : const BorderSide(
                        color: AppColors.standardAmbar,
                        width: 1.5,
                      ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: widget.controller.text == widget.watchValue
                    ? const BorderSide(
                        color: AppColors.standardGreen,
                        width: 3,
                      )
                    : const BorderSide(
                        color: AppColors.standardAmbar,
                        width: 3,
                      ),
              ),
            ),
            onChanged: (_) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
