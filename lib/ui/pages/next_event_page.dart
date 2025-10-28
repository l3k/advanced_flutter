import 'package:advanced_flutter/presentation/presenters/next_event_presenter.dart';
import 'package:flutter/material.dart';

final class NextEventPage extends StatefulWidget {
  final NextEventPresenter presenter;
  final String groupId;

  const NextEventPage({
    required this.presenter,
    required this.groupId,
    super.key,
  });

  @override
  State<NextEventPage> createState() => _NextEventPageState();
}

class _NextEventPageState extends State<NextEventPage> {
  @override
  void initState() {
    widget.presenter.loadNextEvent(groupId: widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NextEventViewModel>(
        stream: widget.presenter.nextEventStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) return const SizedBox();
          final viewData = snapshot.data;
          return ListView(
            children: [
              if (viewData!.goalkeepers.isNotEmpty)
                ListSection(
                  title: 'DENTRO - GOLEIROS',
                  items: viewData.goalkeepers,
                ),
              if (viewData.players.isNotEmpty)
                ListSection(
                  title: 'DENTRO - JOGADORES',
                  items: viewData.players,
                ),
              if (viewData.out.isNotEmpty)
                ListSection(title: 'FORA', items: viewData.out),
              if (viewData.doubt.isNotEmpty)
                ListSection(title: 'DÚVIDA', items: viewData.doubt),
            ],
          );
        },
      ),
    );
  }
}

final class ListSection extends StatelessWidget {
  final String title;
  final List<NextEventPlayerViewModel> items;
  const ListSection({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(items.length.toString()),
        ...items.map((player) => Text(player.name)),
      ],
    );
  }
}
