import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/main_map_page.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchPlan extends StatelessWidget {
  const SwitchPlan({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: trip.active
              ? Border.all(color: Color(0x66D38A5D), width: 2)
              : Border.all(color: Color(0xffF3F4F6), width: 2),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            trip.title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${trip.days} days  • ${trip.dayModel[0].activity.length} stops',
            style: TextStyle(
              color: Color(0xff9CA3AF),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/pyramid.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              if (trip.active)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffF3E9D9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Active',
                    style: TextStyle(color: Color(0xffD38A5D)),
                  ),
                ),
              IconButton(
                icon: Icon(
                  trip.active
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                ),
                onPressed: () {
                  context.read<PlanCubit>().togglePlanActivation(newPlanId: trip.id!);
                  Navigator.pop(context);
                },
                color: trip.active ? Color(0xffD38A5D) : Color(0xffD1D5DB),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<PlanCubit>(),
                  child: MainMapPage(trip: trip),
                ),
              ),
            );

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
