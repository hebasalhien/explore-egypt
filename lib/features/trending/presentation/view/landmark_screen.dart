import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/dashed_rounded_button.dart';
import 'package:explore_egypt/features/trending/model/data_source/comment_remote_data_source.dart';
import 'package:explore_egypt/features/trending/model/entities/comment_model.dart';
import 'package:explore_egypt/features/trending/model/repo/comment_repo.dart';
import 'package:explore_egypt/features/trending/presentation/cubit/comment_cubit.dart';
import 'package:explore_egypt/features/trending/presentation/view/widgets/comment_widget.dart';
import 'package:explore_egypt/features/trending/presentation/view/widgets/landmark_appbar.dart';
import 'package:explore_egypt/features/trending/presentation/view/widgets/landmark_details_row.dart';
import 'package:explore_egypt/features/trending/presentation/view/widgets/landmark_gallery.dart';
import 'package:explore_egypt/features/trending/presentation/view/widgets/landmark_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandmarkScreen extends StatelessWidget {
  const LandmarkScreen({super.key, required this.landmark});
  final LandmarkModel landmark;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        return CommentCubit(
          CommentRepo(CommentRemoteDataSource(ApiService.instance)),
        )..getLandmarkComments(landmarkId: landmark.id!);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            LandmarkAppBar(landmark: landmark),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20,
                ),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LandmarkDetailsRow(landmark: landmark),
                    LandmarkInfoWidget(landmark: landmark),
                    LandmarkGallery(imagesUrl: landmark.imagesUrl),
                    Column(
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'What People Say',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4A3728),
                              ),
                            ),
                            Builder(
                              builder: (localContext) {
                                final commentCubit = localContext
                                    .read<CommentCubit>();

                                return TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: localContext,
                                      isScrollControlled: true,
                                      showDragHandle: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(35),
                                        ),
                                      ),
                                      builder: (sheetContext) {
                                        return BlocProvider.value(
                                          value: commentCubit,
                                          child: Builder(
                                            builder: (innerContext) {
                                              return Container(
                                                height:
                                                    MediaQuery.of(
                                                      innerContext,
                                                    ).size.height *
                                                    .55,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                        top: Radius.circular(
                                                          35,
                                                        ),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5,
                                                      ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'What People Say',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                            0xff4A3728,
                                                          ),
                                                        ),
                                                      ),
                                                      BlocBuilder<
                                                        CommentCubit,
                                                        CommentState
                                                      >(
                                                        builder: (context, state) {
                                                          if (state
                                                                  is CommentLoaded &&
                                                              state
                                                                  .comments
                                                                  .isNotEmpty) {
                                                            return CommentsList(
                                                              commentModel:
                                                                  state
                                                                      .comments,
                                                            );
                                                          } else if (state
                                                                  is CommentLoaded &&
                                                              state
                                                                  .comments
                                                                  .isEmpty) {
                                                            return Expanded(
                                                              child: Center(
                                                                child: Text(
                                                                  'No Comments Be the First one',
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return Text(
                                                              'nnnnn',
                                                            );
                                                          }
                                                        },
                                                      ),

                                                      AddCommentWidget(
                                                        landmarkId:
                                                            landmark.id!,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kPrimaryVariant,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        BlocBuilder<CommentCubit, CommentState>(
                          builder: (context, state) {
                            if (state is CommentLoaded &&
                                state.comments.isNotEmpty) {
                              return CommentWidget(
                                commentModel: state.comments[0],
                              );
                            } else if (state is CommentLoaded &&
                                state.comments.isEmpty) {
                              return AddCommentWidget(landmarkId: landmark.id!);
                            } else if (state is CommentLoading) {
                              return CircularProgressIndicator();
                            } else {
                              return Text('no comments found');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.commentModel});

  final List<CommentModel> commentModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: commentModel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CommentWidget(commentModel: commentModel[index]),
          );
        },
      ),
    );
  }
}

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({super.key, required this.landmarkId});
  final String landmarkId;
  @override
  Widget build(BuildContext context) {
    return DashedRoundedButton(
      onTap: () {
        final commentCubit = context.read<CommentCubit>();

        showBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          builder: (sheetContext) {
            final GlobalKey<FormState> formKey = GlobalKey();
            final TextEditingController message = TextEditingController();
            double selectedRating = 0; // ✅ holds the star rating

            return BlocProvider.value(
              value: commentCubit,
              child: StatefulBuilder(
                builder: (innerContext, setSheetState) {
                  return Container(
                    height: MediaQuery.of(context).size.height * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            // ✅ Star rating row instead of the text field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                StarRatingRow(
                                  onRatingChanged: (value) {
                                    setSheetState(
                                      () => selectedRating = value.toDouble(),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Text('Comment'),
                            CustomTextField(
                              controller: message,
                              label: 'Comment',
                              validator: Validators.generalValidator,
                              maxLength: 50,
                            ),

                            BlocConsumer<CommentCubit, CommentState>(
                              listener: (context, state) {
 if (state is CommentLoaded) {
                          Navigator.pop(innerContext); // close sheet on success
                        } else if (state is CommentFailure) {
                          
                        }                              },
                              builder: (context, state) {
                                        return ElevatedButton(
                          onPressed: state is CommentLoading
                              ? null
                              : () {
                                  if (selectedRating == 0) {
                                    ScaffoldMessenger.of(innerContext).showSnackBar(
                                      const SnackBar(content: Text('Please select a rating')),
                                    );
                                    return;
                                  }
                                  if (formKey.currentState!.validate()) {
                                    context.read<CommentCubit>().addNewComment(
                                      landmarkId: landmarkId,
                                      message: message.text,
                                      rating: selectedRating,
                                    );
                                  }
                                },
                          child: state is CommentLoading
                              ? const CircularProgressIndicator()
                              : const Text('Add comment'),
                        );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      label: 'Add Comment',
      color: AppColors.kPrimaryColor,
    );
  }
}

class StarRatingRow extends StatefulWidget {
  final int starCount;
  final ValueChanged<int> onRatingChanged;

  const StarRatingRow({
    super.key,
    this.starCount = 5,
    required this.onRatingChanged,
  });

  @override
  State<StarRatingRow> createState() => _StarRatingRowState();
}

class _StarRatingRowState extends State<StarRatingRow> {
  int _selected = 0;
  int _hovered = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        final value = index + 1;
        final isActive = value <= (_hovered > 0 ? _hovered : _selected);

        return GestureDetector(
          onTap: () {
            setState(() => _selected = value);
            widget.onRatingChanged(value);
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = value),
            onExit: (_) => setState(() => _hovered = 0),
            child: AnimatedScale(
              scale: _hovered == value ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  isActive ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isActive
                      ? const Color(0xFFEF9F27)
                      : Colors.grey.shade400,
                  size: 36,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
