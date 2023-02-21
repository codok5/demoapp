import 'package:flutter/material.dart';

class CoinGetDialog extends StatelessWidget {
  final int reward;
  const CoinGetDialog({
    Key? key,
    required this.reward,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Column(
          children: [
            Text('You Got $reward coin'),
            ElevatedButton(onPressed: () {
              
            }, child: Text('받기')),
          ],
        ),
      ),
    );
  }
}
