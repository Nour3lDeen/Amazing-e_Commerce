import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';


class VideoPreviewComponent extends StatefulWidget {
  const VideoPreviewComponent({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPreviewComponent> createState() => _VideoPreviewComponentState();
}

class _VideoPreviewComponentState extends State<VideoPreviewComponent> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isVideoPressed = false; // To track if video is pressed or not

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    debugPrint('Video URL: ${widget.videoUrl}');
  }

  Future<void> _initializeVideoPlayer() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Initialize VideoPlayerController
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

      await _videoController!.initialize();

      // Initialize ChewieController
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        aspectRatio: _videoController!.value.aspectRatio,

        autoPlay: false,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.primaryColor,
        ),
        placeholder: Container(
          color: Colors.transparent,
          child: Center(
            child: LoadingAnimationWidget.inkDrop(
                color: AppColors.primaryColor, size: 15.sp),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: TextBody14(
              'خطأ في تحميل الفيديو',
              color: Colors.red,
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'خطأ في تحميل الفيديو';
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: LoadingAnimationWidget.inkDrop(
            color: AppColors.primaryColor, size: 15.sp),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: TextBody14(
          _errorMessage!,
          color: Colors.red,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_videoController == null ||
        !_videoController!.value.isInitialized ||
        _chewieController == null) {
      return const Center(
        child: TextBody14(
          'لم يتم تهيئة الفيديو',
          color: Colors.red, ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isVideoPressed = !_isVideoPressed;
        });
      },
      child: Center(
        child: Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Video behind the blur initially
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: VideoPlayer(_videoController!),
              ),
              // Blur effect above the video
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                  child: SizedBox(
                    height: 150.h,
                    width: double.infinity,
                  ),
                ),
              ),
              // Play button overlay
              SvgPicture.asset(
                AppAssets.play,
                height: 30.h,
                width: 30.w,
              ),
              // Show video controls only if pressed
              if (_isVideoPressed)
                Chewie(controller: _chewieController!),
            ],
          ),
        ),
      ),
    );
  }
}


/*
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:ecommerce/view_model/utils/texts/texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';


class VideoPreviewComponent extends StatefulWidget {
  const VideoPreviewComponent({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPreviewComponent> createState() => _VideoPreviewComponentState();
}

class _VideoPreviewComponentState extends State<VideoPreviewComponent> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isVideoPressed = false; // To track if video is pressed or not

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    debugPrint('Video URL: ${widget.videoUrl}');
  }

  Future<void> _initializeVideoPlayer() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Initialize VideoPlayerController
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

      await _videoController!.initialize();

      // Initialize ChewieController
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        aspectRatio: _videoController!.value.aspectRatio,

        autoPlay: false,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.primaryColor,
        ),
        placeholder: Container(
          color: Colors.transparent,
          child: Center(
            child: LoadingAnimationWidget.inkDrop(
                color: AppColors.primaryColor, size: 30.sp),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: TextBody14(
              'خطأ في تحميل الفيديو',
              color: Colors.red,
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'خطأ في تحميل الفيديو: $e';
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: LoadingAnimationWidget.inkDrop(
            color: AppColors.primaryColor, size: 30.sp),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(color: Colors.red, fontSize: 16.sp),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_videoController == null ||
        !_videoController!.value.isInitialized ||
        _chewieController == null) {
      return const Center(
        child: TextBody14(
          'لم يتم تهيئة الفيديو',
          color: Colors.red, ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isVideoPressed = !_isVideoPressed;
        });
      },
      child: Column(
        children: [
          Center(
            child: TextTitle(
              'فيديو توضيحي للمنتج',
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Video behind the blur initially
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: VideoPlayer(_videoController!),
                  ),
                  // Blur effect above the video
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                      child: SizedBox(
                        height: 150.h,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  // Play button overlay
                  SvgPicture.asset(
                    AppAssets.play,
                    height: 30.h,
                    width: 30.w,
                  ),
                  // Show video controls only if pressed
                  if (_isVideoPressed)
                    Chewie(controller: _chewieController!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
