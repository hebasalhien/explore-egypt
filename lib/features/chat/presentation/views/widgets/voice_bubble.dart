import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/model/entities/message_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class VoiceBubble extends StatefulWidget {
  const VoiceBubble({super.key, required this.message});
  final MessageModel message;

  @override
  State<VoiceBubble> createState() => _VoiceBubbleState();
}

class _VoiceBubbleState extends State<VoiceBubble> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    final path = widget.message.localPaths.isNotEmpty
        ? widget.message.localPaths.first
        : widget.message.files.first;

    try {
      if (widget.message.localPaths.isNotEmpty) {
        await _player.setFilePath(path);
      } else {
        await _player.setUrl(path);
      }

      _player.durationStream.listen((d) {
        if (mounted) setState(() => _duration = d ?? Duration.zero);
      });

      _player.positionStream.listen((p) {
        if (mounted) setState(() => _position = p);
      });

      _player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() => _isPlaying = state.playing);
          if (state.processingState == ProcessingState.completed) {
            _player.seek(Duration.zero);
            setState(() => _isPlaying = false);
          }
        }
      });
    } catch (e) {
      debugPrint('VoiceBubble error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get _isUser => widget.message.sender != 'bot';

  @override
  Widget build(BuildContext context) {
    final progress = _duration.inMilliseconds > 0
        ? _position.inMilliseconds / _duration.inMilliseconds
        : 0.0;

    return Row(
      mainAxisAlignment:
          _isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isUser ? AppColors.kPrimaryColor : AppColors.kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomLeft: _isUser ? Radius.circular(19) : Radius.zero,
              bottomRight: _isUser ? Radius.zero : Radius.circular(19),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 4),
                color: Colors.black.withAlpha(38),
              ),
            ],
          ),
          child: Row(
            children: [
              // play/pause button
              GestureDetector(
                onTap: () async {
                  if (_isPlaying) {
                    await _player.pause();
                  } else {
                    await _player.play();
                  }
                },
                child: Icon(
                  _isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: _isUser ? AppColors.kWhite : AppColors.kPrimaryColor,
                  size: 36,
                ),
              ),
              const SizedBox(width: 8),
              // progress + duration
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      backgroundColor: _isUser
                          ? Colors.white30
                          : AppColors.kPrimaryColor.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _isUser
                            ? AppColors.kWhite
                            : AppColors.kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      minHeight: 4,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatDuration(_position)} / ${_formatDuration(_duration)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: _isUser ? AppColors.kWhite : AppColors.kBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}