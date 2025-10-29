import 'package:advanced_flutter/presentation/presenters/next_event_presenter.dart';
import 'package:advanced_flutter/ui/components/player_photo.dart';
import 'package:advanced_flutter/ui/components/player_position.dart';
import 'package:advanced_flutter/ui/components/player_status.dart';
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
    widget.presenter.isBusyStream.listen(
      (isBusy) => isBusy ? showLoading() : hideLoading(),
    );
    super.initState();
  }

  void showLoading() => showDialog(
    context: context,
    builder: (context) => const CircularProgressIndicator(),
  );

  void hideLoading() => Navigator.of(context).maybePop();

  Widget buildErrorLayout() => Column(
    children: [
      const Text('Algo errado aconteceu, tente novamente.'),
      ElevatedButton(
        onPressed: () {
          widget.presenter.loadNextEvent(
            groupId: widget.groupId,
            isReload: true,
          );
        },
        child: const Text('Recarregar'),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NextEventViewModel>(
        stream: widget.presenter.nextEventStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) return buildErrorLayout();
          final viewData = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              widget.presenter.loadNextEvent(
                groupId: widget.groupId,
                isReload: true,
              );
            },
            child: ListView(
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
            ),
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
        ...items.map(
          (player) => Row(
            children: [
              PlayerPhoto(initials: player.initials, photo: player.photo),
              Text(player.name),
              PlayerPosition(position: player.position),
              PlayerStatus(isConfirmed: player.isConfirmed),
            ],
          ),
        ),
      ],
    );
  }
}
