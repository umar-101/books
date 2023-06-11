import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talepreview/features/talepreview/bloc/events/TalePreviewEvent.dart';

import '../../utils/utils.dart';
import 'bloc/TalePreviewBloc.dart';
import 'bloc/states/TalePreviewState.dart';
import 'components/GreetingCard.dart';
import 'components/PlaceholderCard.dart';
import 'components/ReadCounter.dart';
import 'components/TalePreviewCard.dart';
import 'models/TalePreview.dart';

@RoutePage(name: 'TalePreviewRoute')
class TalePreviewScreen extends StatefulWidget {
  const TalePreviewScreen({super.key});

  @override
  State<TalePreviewScreen> createState() => _TalePreviewScreenState();
}

class _TalePreviewScreenState extends State<TalePreviewScreen> {
  bool english = true;

  @override
  void didChangeDependencies() {
    final TalePreviewBloc talePreviewBloc =
        BlocProvider.of<TalePreviewBloc>(context);
    talePreviewBloc.add(TablePreviewFetch());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                context.setLocale(const Locale('en'));
                setState(() {
                  english = true;
                });
              },
              child: Container(
                width: 80,
                height: 35,
                decoration: english == true
                    ? BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: Center(
                  child: Text(
                    'EN',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: english ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                context.setLocale(const Locale('de'));
                setState(() {
                  english = false;
                });
              },
              child: Container(
                width: 80,
                height: 35,
                decoration: !english
                    ? BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: Center(
                  child: Text('DE',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: !english ? Colors.white : Colors.black)),
                ),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
        body: SafeArea(child: BlocBuilder<TalePreviewBloc, TalePreviewState>(
            builder: (context, state) {
          if (state is TalePreviewFetched) {
            List<TalePreview> talePreviews =
                sortTalePreviews(state.talePreviews);

            return ListView.builder(
              itemCount: talePreviews.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, top: 50, left: 10, right: 10),
                    child: TalePreviewCard(
                      talePreview: talePreviews[index],
                    ),
                  );
                }
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: TalePreviewCard(
                    talePreview: talePreviews[index],
                  ),
                );
              },
            );
          }
          return Container();
        })));
  }
}
