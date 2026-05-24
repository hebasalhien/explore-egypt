import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/generate_with_ai_button.dart';
import 'package:flutter/material.dart';

class AddNewPlace extends StatelessWidget {
  const AddNewPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .8,
      decoration: const BoxDecoration(
        color: Color(0xffFEF8F1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        spacing: 10,
        children: [
          Divider(
            thickness: 5,
            color: Color(0xffE5E7EB),
            indent: 140,
            endIndent: 140,
            radius: BorderRadius.circular(12),
          ),
          Text('Add Place', style: Theme.of(context).textTheme.headlineMedium),
          Text(
            'Add a new stop to day 1',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          CustomSearchBar(),
          GenerateWithAiButton(),
          Row(children: [Text('SUGGESTED PLACES')]),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Container(
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
                    Column(
                      children: [
                        Text('Giza Pyramids',
                            style: Theme.of(context).textTheme.headlineSmall),
                        Text('Giza Pyramids',
                            style: Theme.of(context).textTheme.headlineSmall),
                            Text('12:00 pm')
                            
                      ],
                    ),
                    Column(children: [
                      Text('15 \$'),

                    ],)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Save Changes')),
        ],
      ),
    );
  }
}

