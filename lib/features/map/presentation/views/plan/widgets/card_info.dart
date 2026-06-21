import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.screenWidth,
    this.trip
  });

  final double screenWidth;
  final TripModel? trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          trip != null?'':'Nile Cruise',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          trip != null? trip!.title :'7 Days: The Grand Nile Tour',
          style: Theme.of(
            context,
          ).textTheme.labelLarge,
          softWrap: true,
        ),
        ElevatedButton(
          onPressed: () {
            if (trip != null) {
              context.read<PlanCubit>().selectActivePlan(trip!);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
            ),
            backgroundColor: Colors.white,
            fixedSize: Size(
              screenWidth * .6,
              40,
            ),
          ),
          child: Text(
            'View Route',
            style: TextStyle(
              color: Color(0xff8B4513),
            ),
          ),
        ),
      ],
    );
  }
}

