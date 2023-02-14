import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:behapp/hivecustomobject/item.dart';

class InventoryView extends StatelessWidget {
  InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<InventoryBloc>().state.items;
    return SizedBox(
      height: 150.h,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => VerticalDivider(
                width: 20.w,
                color: Colors.transparent,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                Item item = items[index];
                return GestureDetector(
                    onTap: () {
                      print('select');
                      context.read<PlayerBloc>().add(ItemSelected(item: item));
                    },
                    child: Container(
                        height: 150.h,
                        width: 200.w,
                        child: Image.asset('assets/images/${item.name}.png')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
