import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, this.errorMessage, this.onRetry});
  final String? errorMessage;
  final Function()? onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Icon(Icons.error,size: 50,color: Colors.red),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: Text(
             errorMessage ?? 'Something went wrong',
             textAlign: TextAlign.center
          ),
          ),
          ElevatedButton(
            onPressed: onRetry ?? (){},
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
