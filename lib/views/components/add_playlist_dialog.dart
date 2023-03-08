import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music_player/data/hive_model/songs.dart';
import 'package:music_player/provider/play_list_controller.dart';
import 'package:music_player/views/components/custom_chip.dart';
import 'package:provider/provider.dart';

class AddPlaylistDialog extends HookWidget {
  final Songs songs;
  const AddPlaylistDialog({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final isAdd = useState(false);
    final playListController = useTextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: Colors.black87.withOpacity(.3),
      child: Container(
          constraints: const BoxConstraints(
            maxHeight: 300,
            minHeight: 200,
            maxWidth: double.infinity,
            minWidth: double.infinity,
          ),
          child: Consumer<PlayListController>(
            builder: (context, playList, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'PlayList',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        CustomChip(
                          isSelected: true,
                          lable: 'Add New',
                          onTap: () {
                            isAdd.value = !isAdd.value;
                          },
                          textStyle: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: isAdd.value ? 45 : 0,
                    child: isAdd.value
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: playListController,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Playlist name',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (playListController
                                            .text.isNotEmpty) {
                                          playList.createPlayList(
                                            listName: playListController.text,
                                            songs: songs,
                                          );
                                          playListController.clear();
                                          isAdd.value = false;
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.check)),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      isAdd.value = !isAdd.value;
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ],
                              )
                            ],
                          )
                        : null,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: playList.playList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            playList.playList[index].listName,
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            playList.playList[index].songList?.length
                                    .toString() ??
                                '0',
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          trailing: SizedBox(
                            height: 20,
                            child: CustomChip(
                              isSelected: false,
                              lable: 'Add New',
                              onTap: () {
                                playList.updatePlayList(
                                  listName: playList.playList[index].listName,
                                  song: songs,
                                );
                                Navigator.pop(context);
                              },
                              textStyle: const TextStyle(
                                fontFamily: 'Gilroy',
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
