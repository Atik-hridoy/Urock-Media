import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/constants/app_colors.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCustomWidget extends StatefulWidget {
  const WebviewCustomWidget({super.key, required this.url});
  final String url;
  @override
  State<WebviewCustomWidget> createState() => _WebviewCustomWidgetState();
}

class _WebviewCustomWidgetState extends State<WebviewCustomWidget> {
  late WebViewController controller;
  double progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
          onNavigationRequest: (request) async {
            Logger.debug("the request: ${request.url}");
            if (request.url.contains("success")) {
              showPaymentSuccessfulDialog(context);
              // AppSnackBar.success("Payment successful. Thank you!");
              // Get.back(times: 3);
            }
            if (request.url.contains("failed")) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(content: Text("Payment failed. Please try again.")),
                );
            }
            if (request.url.contains("ticket-purchases/cancel")) {
              Navigator.pop(context);
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text("Payment"),
      ),
      body: Column(
        children: [
          if (progress != 1.0)
            LinearProgressIndicator(color: AppColors.info, value: progress),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}

void showPaymentSuccessfulDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.blue,
                size: 100,
              ),
              const SizedBox(height: 30),
              const Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Payment is successful",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Your order was successful, and we're preparing your product with care.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ == 3);
                  },
                  child: const Text(
                    "Go To Home",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
