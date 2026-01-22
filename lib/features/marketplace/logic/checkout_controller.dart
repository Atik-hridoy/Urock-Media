import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/marketplace/widgets/webview_widget.dart';

class CheckoutController extends ChangeNotifier {
  bool isLoading = false;

  Future<void> onPlaceOrder(BuildContext context) async {
    isLoading = true;
    ScaffoldMessenger.of(context)
      ..clearSnackBars
      ..showSnackBar(SnackBar(content: Text("Placing order. Please wait ...")));
    ChangeNotifier();
    try {
      final resposne = await ApiService().post(ApiEndpoints.checkOut);

      if (resposne.statusCode == 200) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(resposne.data['message']),
              backgroundColor: Colors.green,
            ),
          );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                WebviewCustomWidget(url: resposne.data['data']['url']),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(resposne.data['message']),
              backgroundColor: Colors.red,
            ),
          );
      }
    } catch (e) {
      Logger.error("place order", e);
    } finally {
      isLoading = false;
      ChangeNotifier();
    }
  }
}
