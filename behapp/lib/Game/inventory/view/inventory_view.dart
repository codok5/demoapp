import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatelessWidget {
  InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<InventoryBloc>().state.items;

    return SizedBox(
      height: 200,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                print('select');
                context
                    .read<PlayerBloc>()
                    .add(ItemSelected(item: items[index]));
              },
              child: Container(
                  height: 200,
                  width: 50,
                  child:
                      Image.asset('assets/images/${items[index].name}.png')));
        },
      ),
    );
  }
}
