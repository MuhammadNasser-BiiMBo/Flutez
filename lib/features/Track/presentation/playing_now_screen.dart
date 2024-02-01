import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutez/features/home/models/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class PlayingNowScreen extends StatelessWidget {
  final Track track;
  const PlayingNowScreen({super.key, required this.track});

  // Future<void> _updatePaletteGenerator() async {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconWidget(
                  onPressed: () {
                    context.pop();
                  },
                  iconAsset: Assets.arrowBackIcon,
                ),
                Text18(
                  text: "Playing Now",
                  textColor: const Color(0xFFDBE6FF),
                ),
                SizedBox(
                  width: 30.w,
                )
              ],
            ),
          ),
          body: StreamBuilder<PositionData>(
            stream: trackCubit.positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: Hero(
                      tag: "${track.image}",
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: 300.r,
                        height: 300.r,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(int.parse(track.shadowColor!))
                                  .withOpacity(0.2),
                              blurRadius: 45.r,
                              spreadRadius: -0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: track.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40.w,
                      ),
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 260.w),
                            child: Text22(
                              text: "${trackCubit.currentTrack?.trackName}",
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              textColor: Colors.white,
                            ),
                          ),
                          Text16(
                            text: "${trackCubit.currentTrack?.artist}",
                            weight: FontWeight.w300,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconWidget(
                          onPressed: () {},
                          iconAsset: Assets.heartIcon,
                          size: 22.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        IconWidget(
                          onPressed: () {
                            if(trackCubit.audioPlayer!.volume!=100){
                              trackCubit.audioPlayer!.setVolume(100);
                            }else{
                              trackCubit.audioPlayer!.setVolume(0);

                            }
                          },
                          iconAsset: Assets.volumeIcon,
                          size: 22.r,
                        ),
                        Expanded(
                          child: ProgressBar(
                            barHeight: 4,
                            baseBarColor: const Color(0xFF555b6a),
                            bufferedBarColor: Colors.grey,
                            progressBarColor: Colors.white,
                            thumbColor: Colors.white,
                            thumbGlowRadius: 20,
                            thumbRadius: 9,
                            progress: Duration(seconds: int.parse(trackCubit.audioPlayer!.volume.round().toString())),
                            total: const Duration(seconds: 100),
                            onSeek: (Duration d){
                              trackCubit.audioPlayer!.setVolume(double.parse(d.inSeconds.toString()));
                            },
                          ),
                        ),
                        // const Spacer(),
                        IconWidget(
                          onPressed: () {},
                          iconAsset: Assets.repeatIcon,
                          size: 22.r,
                        ),
                        IconWidget(
                          onPressed: () {},
                          iconAsset: Assets.shuffleIcon,
                          size: 22.r,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    child: ProgressBar(
                      barHeight: 4,
                      baseBarColor: const Color(0xFF555b6a),
                      bufferedBarColor: Colors.grey,
                      progressBarColor: Colors.white,
                      timeLabelPadding: 15.h,
                      thumbColor: Colors.white,
                      thumbGlowRadius: 20,
                      thumbRadius: 9,
                      timeLabelLocation: TimeLabelLocation.above,
                      timeLabelTextStyle: TextStyle(
                        color: AppColors.smallTextColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.sp,
                      ),
                      progress: positionData?.position ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      onSeek: trackCubit.audioPlayer!.seek,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconWidget(
                        onPressed: () {},
                        iconAsset: Assets.previousIcon,
                        size: 35.r,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconWidget(
                        onPressed: () {
                          if (!positionData!.state.playing) {
                            trackCubit.audioPlayer!.play();
                          } else if (positionData.state.processingState !=
                              ProcessingState.completed) {
                            trackCubit.audioPlayer!.pause();
                          }
                        },
                        iconAsset: positionData?.state.playing == null
                            ? Assets.playIcon
                            : !positionData!.state.playing
                                ? Assets.playIcon
                                : Assets.pauseIcon,
                        size: 40.r,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconWidget(
                        onPressed: () {},
                        iconAsset: Assets.nextIcon,
                        size: 35.r,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
