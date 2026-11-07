import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/leaderboard_entry.dart';
import '../../data/leaderboard_repository.dart';
import '../widgets/leaderboard_tile.dart';
import '../widgets/my_rank_bar.dart';
import '../widgets/period_toggle.dart';
import '../widgets/podium.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final _repository = const LeaderboardRepository();

  LeaderboardPeriod _period = LeaderboardPeriod.weekly;
  late Future<List<LeaderboardEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.fetch(_period);
  }

  void _load(LeaderboardPeriod period) {
    setState(() {
      _period = period;
      _future = _repository.fetch(period);
    });
  }

  static const _months = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];
  static const _shortMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  /// Label rentang waktu: "2 Nov – 8 Nov 2026" atau "November 2026".
  String _periodLabel() {
    final now = DateTime.now();
    if (_period == LeaderboardPeriod.monthly) {
      return '${_months[now.month - 1]} ${now.year}';
    }
    // Minggu berjalan: Senin - Minggu.
    final start = now.subtract(Duration(days: now.weekday - 1));
    final end = start.add(const Duration(days: 6));
    return '${start.day} ${_shortMonths[start.month - 1]} – '
        '${end.day} ${_shortMonths[end.month - 1]} ${end.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<LeaderboardEntry>>(
        future: _future,
        builder: (context, snapshot) {
          final entries = snapshot.data;

          return Column(
            children: [
              _Header(
                period: _period,
                label: _periodLabel(),
                onPeriodChanged: _load,
              ),
              Expanded(child: _buildBody(snapshot, entries)),
              if (entries != null) MyRankBar(entries: entries),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(
    AsyncSnapshot<List<LeaderboardEntry>> snapshot,
    List<LeaderboardEntry>? entries,
  ) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.homeGreen),
      );
    }
    if (snapshot.hasError || entries == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat papan peringkat'),
            TextButton(
              onPressed: () => _load(_period),
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      );
    }
    if (entries.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada setoran di periode ini',
          style: TextStyle(color: AppColors.homeTextSecondary),
        ),
      );
    }

    final showPodium = entries.length >= 3;
    final rest = showPodium ? entries.skip(3).toList() : entries;
    final startRank = showPodium ? 4 : 1;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        if (showPodium) ...[
          Podium(first: entries[0], second: entries[1], third: entries[2]),
          const SizedBox(height: 20),
        ],
        if (rest.isNotEmpty)
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                for (var i = 0; i < rest.length; i++) ...[
                  LeaderboardTile(rank: startRank + i, entry: rest[i]),
                  if (i != rest.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 72,
                      endIndent: 16,
                      color: Colors.grey.shade100,
                    ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final LeaderboardPeriod period;
  final String label;
  final ValueChanged<LeaderboardPeriod> onPeriodChanged;

  const _Header({
    required this.period,
    required this.label,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.homeGreen, AppColors.homeGreenDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Papan Peringkat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Setor terbanyak • $label',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: PeriodToggle(selected: period, onChanged: onPeriodChanged),
          ),
        ],
      ),
    );
  }
}
