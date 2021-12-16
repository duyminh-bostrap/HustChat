import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/models.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String username;
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
    this.username = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // FloatingActionButton.extended(
        //     onPressed: () => print('avatar'),
        //     icon: CircleAvatar(
        //       radius: 20.0,
        //       backgroundColor: Palette.facebookBlue,
        //       child: CircleAvatar(
        //         radius: hasBorder ? 17.0 : 20.0,
        //         backgroundColor: Colors.grey[200],
        //         backgroundImage: CachedNetworkImageProvider(imageUrl),
        //       ),
        //     ),
        // )
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: hasBorder ? 23.0 : 25.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: online,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
