import 'package:behapp/Game/characterlist/bloc/characterlist_bloc.dart';

import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';

class CharacterListView extends StatelessWidget {
  CharacterListView({super.key});

  @override
  Widget build(BuildContext context) {
    final characterList =
        context.watch<CharacterlistBloc>().state.characterlist;
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
              itemCount: characterList.length,
              itemBuilder: (context, index) {
                Character character = characterList[index];
                return GestureDetector(
                    onTap: () {
                      context
                          .read<PlayerBloc>()
                          .add(CharacterSelected(character: character));
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
                            'assets/images/${character.name}_idle.png')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
