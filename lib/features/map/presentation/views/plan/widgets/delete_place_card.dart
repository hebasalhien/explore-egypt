import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePlaceCard extends StatefulWidget {
  const DeletePlaceCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.activityModel,
  });
  final ActivityModel activityModel;
  final double screenHeight;
  final double screenWidth;

  @override
  State<DeletePlaceCard> createState() => _DeletePlaceCardState();
}

class _DeletePlaceCardState extends State<DeletePlaceCard> {
  bool isSelected = false;
  final blendedColor = Color.alphaBlend(
    Color(0xFFB00020).withOpacity(0.05),
    Colors.white,
  );
  void _toggle() {
    setState(() => isSelected = !isSelected);
    context.read<PlanCubit>().toggleLandmarkToList(
      landmarkId: widget.activityModel.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: widget.screenHeight * .17,
        decoration: BoxDecoration(
          color: isSelected ? blendedColor : AppColors.kBGColor,
          border: Border.all(
            color: isSelected ? AppColors.kErrorColor : const Color(0xffE2E8F0),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.activityModel.time,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                Text(
                  widget.activityModel.cost.toString().contains('\$')
                      ? widget.activityModel.cost.toString()
                      : '${widget.activityModel.cost.toString()}\$',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: IconButton(
                onPressed: _toggle,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    key: ValueKey(isSelected),
                    color: isSelected
                        ? AppColors.kErrorColor
                        : AppColors.kPrimaryColor,
                  ),
                ),
              ),
              title: Text(
                widget.activityModel.landmarkName,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.kBlack),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                widget.activityModel.description,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: const Color(0xff64748B),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                width: widget.screenWidth * .16,
                height: widget.screenHeight * .16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: widget.activityModel.image != null
                        ? NetworkImage(widget.activityModel.image!)
                        : const AssetImage("assets/images/pyramid.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
