import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/model/Item.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';

class InventoryView extends StatelessWidget {
  InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<InventoryBloc>().state.items;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => VerticalDivider(
                width: 10.w,
                color: Colors.transparent,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                Item item = items[index];
                return GestureDetector(
                    onTap: () {
                      context.read<PlayerBloc>().add(ItemSelected(item: item));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            border: Border.all(
                              width: 1,
                              color: Colors.red,
                            )),
                        width: 30.w,
                        child: Image.asset(
                            'assets/images/${item.name}_${item.slots.name}.png')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
