import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 205, 205, 205), 
      highlightColor: const Color.fromARGB(255, 136, 136, 136),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          child: Text(
            'RR',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
          ),
        ),
        title: Container(
          color: Colors.red,
          width: 1,
          height: 15,
        ),
        subtitle: Container(
          color: Colors.red,
          width: 1,
          height: 12,
        ),
        trailing: Column(
          children: [
            Text(
              '22:12',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600]
              ),
            )
          ],
        ),
      ),
    );
  }
}