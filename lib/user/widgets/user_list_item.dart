import 'package:flutter/material.dart';

import '../model/user.dart';

class UserListItem extends StatefulWidget {
  final User data;

  const UserListItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  late User data;

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: Text(
              data.name.substring(0, 1).toUpperCase(),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data.name.substring(0, 1).toUpperCase()}${data.name.substring(1, data.name.length)}",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                data.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
