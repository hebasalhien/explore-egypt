import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:flutter/material.dart';

class SwitchPlan extends StatelessWidget {
  const SwitchPlan({
    super.key, required this.trip,

  });

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
            '${trip.days} days  • ${trip.dayModel.length} stops',
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
              trip.active
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffF3E9D9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(color: Color(0xffD38A5D)),
                      ),
                    )
                  : Icon(Icons.circle_outlined, color: Color(0xffD1D5DB)),
            ],
          ),
          onTap: () {
            // Handle switching the plan here
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
