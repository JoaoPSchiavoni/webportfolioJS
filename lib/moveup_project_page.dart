import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

const _moveUpInk = Color(0xFF07130F);
const _moveUpSurface = Color(0xFF0E211A);
const _moveUpCard = Color(0xFF132B22);
const _moveUpGreen = Color(0xFF69D9A9);
const _moveUpSoft = Color(0xFFBCEBD5);
const _moveUpMuted = Color(0xFFA9BDB4);

class MoveUpProjectPage extends StatefulWidget {
  const MoveUpProjectPage({super.key});

  @override
  State<MoveUpProjectPage> createState() => _MoveUpProjectPageState();
}

class _MoveUpProjectPageState extends State<MoveUpProjectPage> {
  final featuresKey = GlobalKey();

  _MoveUpCopy get copy => AppLocalizations.of(context)!.localeName == 'pt'
      ? _MoveUpCopy.pt
      : _MoveUpCopy.en;

  void goToFeatures() {
    final target = featuresKey.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = copy;
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: _moveUpInk,
        colorScheme: const ColorScheme.dark(
          primary: _moveUpGreen,
          surface: _moveUpSurface,
        ),
        textTheme: Theme.of(context).textTheme
            .apply(bodyColor: _moveUpMuted, displayColor: Colors.white),
      ),
      child: Scaffold(
        backgroundColor: _moveUpInk,
        appBar: AppBar(
          backgroundColor: _moveUpInk.withValues(alpha: .94),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            tooltip: c.back,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _moveUpGreen,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.keyboard_double_arrow_up_rounded,
                  color: _moveUpInk,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'MoveUp',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.north_west_rounded, size: 17),
              label: Text(c.backToPortfolio),
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: SelectionArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _hero(c),
                _overview(c),
                _features(c),
                _productShowcase(c),
                _architecture(c),
                _decisions(c),
                _process(c),
                _technology(c),
                _closing(c),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hero(_MoveUpCopy c) => Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(.72, -.25),
        radius: 1.15,
        colors: [Color(0xFF164936), _moveUpInk],
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          right: -170,
          top: -210,
          child: _glowCircle(520, _moveUpGreen.withValues(alpha: .06)),
        ),
        Positioned(
          left: -130,
          bottom: -240,
          child: _glowCircle(430, _moveUpGreen.withValues(alpha: .035)),
        ),
        _content(
          child: LayoutBuilder(
            builder: (_, constraints) {
              final wide = constraints.maxWidth >= 900;
              final story = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _eyebrow(c.heroEyebrow),
                  const SizedBox(height: 22),
                  Text(
                    'MoveUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: wide ? 82 : 56,
                      height: .92,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -4,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    c.heroTitle,
                    style: TextStyle(
                      color: _moveUpSoft,
                      fontSize: wide ? 31 : 25,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    c.heroBody,
                    style: TextStyle(
                      color: const Color(0xFFD0DED8),
                      fontSize: wide ? 18 : 16,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FilledButton.icon(
                    onPressed: goToFeatures,
                    style: FilledButton.styleFrom(
                      backgroundColor: _moveUpGreen,
                      foregroundColor: _moveUpInk,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                    ),
                    icon: const Icon(Icons.south_rounded, size: 19),
                    label: Text(c.exploreFeatures),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _heroPill(Icons.offline_bolt_outlined, c.offline),
                      _heroPill(Icons.storage_rounded, c.localFirst),
                      _heroPill(Icons.backup_outlined, c.backup),
                    ],
                  ),
                ],
              );
              final visual = Semantics(
                image: true,
                label: c.devicesAlt,
                child: Image.asset(
                  'assets/images/moveup-devices.png',
                  fit: BoxFit.contain,
                ),
              );
              return Padding(
                padding: EdgeInsets.symmetric(vertical: wide ? 42 : 52),
                child: wide
                    ? SizedBox(
                        height: 760,
                        child: Row(
                          children: [
                            Expanded(flex: 5, child: story),
                            const SizedBox(width: 32),
                            Expanded(flex: 6, child: visual),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          story,
                          const SizedBox(height: 36),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 570),
                            child: visual,
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget _overview(_MoveUpCopy c) => _section(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow(c.overviewEyebrow),
        const SizedBox(height: 18),
        _sectionTitle(c.overviewTitle),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: _paragraph(c.overviewBody, size: 18),
        ),
        const SizedBox(height: 42),
        LayoutBuilder(
          builder: (_, constraints) {
            final width = constraints.maxWidth >= 760
                ? (constraints.maxWidth - 32) / 3
                : constraints.maxWidth;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _valueCard(width, Icons.wifi_off_rounded, c.valueOffline),
                _valueCard(width, Icons.sync_alt_rounded, c.valueSources),
                _valueCard(width, Icons.shield_outlined, c.valueIntegrity),
              ],
            );
          },
        ),
      ],
    ),
  );

  Widget _features(_MoveUpCopy c) {
    const icons = [
      Icons.fitness_center_rounded,
      Icons.timer_outlined,
      Icons.local_fire_department_outlined,
      Icons.insights_rounded,
      Icons.cloud_off_rounded,
      Icons.palette_outlined,
    ];
    return ColoredBox(
      key: featuresKey,
      color: _moveUpSurface,
      child: _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eyebrow(c.featuresEyebrow),
            const SizedBox(height: 18),
            _sectionTitle(c.featuresTitle),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (_, constraints) {
                final columns = constraints.maxWidth >= 1050
                    ? 3
                    : constraints.maxWidth >= 660
                    ? 2
                    : 1;
                final width =
                    (constraints.maxWidth - (columns - 1) * 18) / columns;
                return Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: List.generate(
                    c.featureTitles.length,
                    (index) => SizedBox(
                      width: width,
                      child: _featureCard(
                        icons[index],
                        c.featureTitles[index],
                        c.featureBodies[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _productShowcase(_MoveUpCopy c) => _section(
    child: LayoutBuilder(
      builder: (_, constraints) {
        final wide = constraints.maxWidth >= 900;
        final story = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _eyebrow(c.showcaseEyebrow),
            const SizedBox(height: 18),
            _sectionTitle(c.showcaseTitle),
            const SizedBox(height: 20),
            _paragraph(c.showcaseBody),
            const SizedBox(height: 26),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: c.showcaseTags.map(_tag).toList(),
            ),
          ],
        );
        final image = ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'assets/images/moveup-apresentacao.png',
            fit: BoxFit.cover,
          ),
        );
        return wide
            ? Row(
                children: [
                  Expanded(flex: 4, child: story),
                  const SizedBox(width: 54),
                  Expanded(flex: 6, child: image),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [story, const SizedBox(height: 32), image],
              );
      },
    ),
  );

  Widget _architecture(_MoveUpCopy c) => ColoredBox(
    color: _moveUpSurface,
    child: _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eyebrow(c.architectureEyebrow),
          const SizedBox(height: 18),
          _sectionTitle(c.architectureTitle),
          const SizedBox(height: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: _paragraph(c.architectureLead),
          ),
          const SizedBox(height: 38),
          LayoutBuilder(
            builder: (_, constraints) {
              final wide = constraints.maxWidth >= 820;
              final width = wide
                  ? (constraints.maxWidth - 20) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: width,
                    child: _architectureCard(
                      Icons.phone_iphone_rounded,
                      c.appArchitectureTitle,
                      c.appArchitectureBody,
                      c.appFlow,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _architectureCard(
                      Icons.dns_outlined,
                      c.apiArchitectureTitle,
                      c.apiArchitectureBody,
                      c.apiFlow,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _moveUpGreen.withValues(alpha: .08),
              border: Border.all(color: _moveUpGreen.withValues(alpha: .3)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.history_rounded, color: _moveUpGreen),
                const SizedBox(width: 14),
                Expanded(child: _paragraph(c.snapshotBody, size: 15)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _decisions(_MoveUpCopy c) => _section(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow(c.decisionsEyebrow),
        const SizedBox(height: 18),
        _sectionTitle(c.decisionsTitle),
        const SizedBox(height: 34),
        LayoutBuilder(
          builder: (_, constraints) {
            final columns = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 600
                ? 2
                : 1;
            final width = (constraints.maxWidth - (columns - 1) * 14) / columns;
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: c.decisions
                  .map(
                    (text) =>
                        SizedBox(width: width, child: _decisionCard(text)),
                  )
                  .toList(),
            );
          },
        ),
      ],
    ),
  );

  Widget _process(_MoveUpCopy c) => ColoredBox(
    color: _moveUpSurface,
    child: _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eyebrow(c.processEyebrow),
          const SizedBox(height: 18),
          _sectionTitle(c.processTitle),
          const SizedBox(height: 38),
          LayoutBuilder(
            builder: (_, constraints) {
              final columns = constraints.maxWidth >= 1000
                  ? 4
                  : constraints.maxWidth >= 620
                  ? 2
                  : 1;
              final width =
                  (constraints.maxWidth - (columns - 1) * 16) / columns;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: List.generate(
                  c.processTitles.length,
                  (index) => SizedBox(
                    width: width,
                    child: _processCard(
                      index + 1,
                      c.processTitles[index],
                      c.processBodies[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

  Widget _technology(_MoveUpCopy c) => _section(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow(c.technologyEyebrow),
        const SizedBox(height: 18),
        _sectionTitle(c.technologyTitle),
        const SizedBox(height: 38),
        LayoutBuilder(
          builder: (_, constraints) {
            final wide = constraints.maxWidth >= 900;
            final width = wide
                ? (constraints.maxWidth - 32) / 3
                : constraints.maxWidth;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: width,
                  child: _stackCard(
                    Icons.flutter_dash_rounded,
                    c.appStackTitle,
                    c.appStack,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _stackCard(
                    Icons.api_rounded,
                    c.apiStackTitle,
                    c.apiStack,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _stackCard(
                    Icons.verified_outlined,
                    c.qualityStackTitle,
                    c.qualityStack,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );

  Widget _closing(_MoveUpCopy c) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_moveUpSurface, Color(0xFF123D2E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780),
        child: Column(
          children: [
            _eyebrow(c.closingEyebrow),
            const SizedBox(height: 20),
            Text(
              c.closingTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
                height: 1.08,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              c.closingBody,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _moveUpMuted,
                fontSize: 17,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: _moveUpSoft,
                side: const BorderSide(color: _moveUpGreen),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 19,
                ),
              ),
              icon: const Icon(Icons.arrow_back_rounded, size: 19),
              label: Text(c.backToPortfolio),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _content({required Widget child}) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1240),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: child,
      ),
    ),
  );

  Widget _section({required Widget child}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 88),
    child: _content(child: child),
  );

  Widget _eyebrow(String text) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      color: _moveUpGreen,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      letterSpacing: 2.4,
    ),
  );

  Widget _sectionTitle(String text) => Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 40,
      height: 1.08,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.4,
    ),
  );

  Widget _paragraph(String text, {double size = 16}) => Text(
    text,
    style: TextStyle(color: _moveUpMuted, fontSize: size, height: 1.7),
  );

  Widget _glowCircle(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: _moveUpGreen.withValues(alpha: .07)),
    ),
  );

  Widget _heroPill(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .055),
      border: Border.all(color: Colors.white.withValues(alpha: .1)),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _moveUpGreen, size: 17),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFFD5E4DD),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  Widget _valueCard(double width, IconData icon, String text) => Container(
    width: width,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: _moveUpSurface,
      border: Border.all(color: const Color(0xFF234036)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _moveUpGreen.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _moveUpGreen),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _featureCard(IconData icon, String title, String body) => Container(
    constraints: const BoxConstraints(minHeight: 250),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: _moveUpCard,
      border: Border.all(color: const Color(0xFF26493B)),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _moveUpGreen.withValues(alpha: .13),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: _moveUpGreen),
        ),
        const SizedBox(height: 22),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _paragraph(body, size: 14),
      ],
    ),
  );

  Widget _architectureCard(
    IconData icon,
    String title,
    String body,
    List<String> flow,
  ) => Container(
    padding: const EdgeInsets.all(26),
    decoration: BoxDecoration(
      color: _moveUpCard,
      border: Border.all(color: const Color(0xFF26493B)),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _moveUpGreen, size: 30),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 13),
        _paragraph(body, size: 14),
        const SizedBox(height: 22),
        Wrap(
          spacing: 7,
          runSpacing: 8,
          children: flow.asMap().entries.expand((entry) sync* {
            yield _tag(entry.value);
            if (entry.key < flow.length - 1) {
              yield const Padding(
                padding: EdgeInsets.only(top: 7),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: _moveUpGreen,
                  size: 16,
                ),
              );
            }
          }).toList(),
        ),
      ],
    ),
  );

  Widget _decisionCard(String text) => Container(
    constraints: const BoxConstraints(minHeight: 96),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _moveUpSurface,
      border: Border.all(color: const Color(0xFF223E33)),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_rounded, color: _moveUpGreen, size: 19),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFD0DED8),
              fontSize: 14,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _processCard(int number, String title, String body) => Container(
    constraints: const BoxConstraints(minHeight: 260),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: _moveUpCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF26493B)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: _moveUpGreen,
            fontSize: 13,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _paragraph(body, size: 14),
      ],
    ),
  );

  Widget _stackCard(IconData icon, String title, List<String> items) =>
      Container(
        constraints: const BoxConstraints(minHeight: 330),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _moveUpSurface,
          border: Border.all(color: const Color(0xFF234036)),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: _moveUpGreen, size: 30),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(spacing: 8, runSpacing: 8, children: items.map(_tag).toList()),
          ],
        ),
      );

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
    decoration: BoxDecoration(
      color: _moveUpGreen.withValues(alpha: .09),
      border: Border.all(color: _moveUpGreen.withValues(alpha: .2)),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _moveUpSoft,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class _MoveUpCopy {
  const _MoveUpCopy({
    required this.back,
    required this.backToPortfolio,
    required this.heroEyebrow,
    required this.heroTitle,
    required this.heroBody,
    required this.exploreFeatures,
    required this.offline,
    required this.localFirst,
    required this.backup,
    required this.devicesAlt,
    required this.overviewEyebrow,
    required this.overviewTitle,
    required this.overviewBody,
    required this.valueOffline,
    required this.valueSources,
    required this.valueIntegrity,
    required this.featuresEyebrow,
    required this.featuresTitle,
    required this.featureTitles,
    required this.featureBodies,
    required this.showcaseEyebrow,
    required this.showcaseTitle,
    required this.showcaseBody,
    required this.showcaseTags,
    required this.architectureEyebrow,
    required this.architectureTitle,
    required this.architectureLead,
    required this.appArchitectureTitle,
    required this.appArchitectureBody,
    required this.appFlow,
    required this.apiArchitectureTitle,
    required this.apiArchitectureBody,
    required this.apiFlow,
    required this.snapshotBody,
    required this.decisionsEyebrow,
    required this.decisionsTitle,
    required this.decisions,
    required this.processEyebrow,
    required this.processTitle,
    required this.processTitles,
    required this.processBodies,
    required this.technologyEyebrow,
    required this.technologyTitle,
    required this.appStackTitle,
    required this.appStack,
    required this.apiStackTitle,
    required this.apiStack,
    required this.qualityStackTitle,
    required this.qualityStack,
    required this.closingEyebrow,
    required this.closingTitle,
    required this.closingBody,
  });

  final String back;
  final String backToPortfolio;
  final String heroEyebrow;
  final String heroTitle;
  final String heroBody;
  final String exploreFeatures;
  final String offline;
  final String localFirst;
  final String backup;
  final String devicesAlt;
  final String overviewEyebrow;
  final String overviewTitle;
  final String overviewBody;
  final String valueOffline;
  final String valueSources;
  final String valueIntegrity;
  final String featuresEyebrow;
  final String featuresTitle;
  final List<String> featureTitles;
  final List<String> featureBodies;
  final String showcaseEyebrow;
  final String showcaseTitle;
  final String showcaseBody;
  final List<String> showcaseTags;
  final String architectureEyebrow;
  final String architectureTitle;
  final String architectureLead;
  final String appArchitectureTitle;
  final String appArchitectureBody;
  final List<String> appFlow;
  final String apiArchitectureTitle;
  final String apiArchitectureBody;
  final List<String> apiFlow;
  final String snapshotBody;
  final String decisionsEyebrow;
  final String decisionsTitle;
  final List<String> decisions;
  final String processEyebrow;
  final String processTitle;
  final List<String> processTitles;
  final List<String> processBodies;
  final String technologyEyebrow;
  final String technologyTitle;
  final String appStackTitle;
  final List<String> appStack;
  final String apiStackTitle;
  final List<String> apiStack;
  final String qualityStackTitle;
  final List<String> qualityStack;
  final String closingEyebrow;
  final String closingTitle;
  final String closingBody;

  static const pt = _MoveUpCopy(
    back: 'Voltar',
    backToPortfolio: 'Voltar ao portfólio',
    heroEyebrow: 'Aplicativo full stack · Local-first',
    heroTitle: 'Organize sua rotina. Treine no seu ritmo.',
    heroBody: 'Planeje fichas, registre cada série, controle seus descansos e acompanhe sua evolução em uma experiência mobile rápida, acessível e pronta para funcionar sem internet.',
    exploreFeatures: 'Conhecer o MoveUp',
    offline: 'Funciona offline',
    localFirst: 'Dados no dispositivo',
    backup: 'Backup e restauração',
    devicesAlt: 'Telas do MoveUp mostrando treino em andamento, descanso e calendário de consistência',
    overviewEyebrow: 'Visão do produto',
    overviewTitle: 'A jornada de treino em um só lugar.',
    overviewBody: 'O MoveUp torna o acompanhamento de treinos mais simples, organizado e motivador. O aplicativo permite criar fichas personalizadas ou usar modelos prontos, registrar cargas e repetições durante a sessão e acompanhar frequência, desempenho e medidas corporais ao longo do tempo.',
    valueOffline: 'Uso completo sem conexão',
    valueSources: 'Local, API ou modo preview',
    valueIntegrity: 'Dados íntegros e históricos preservados',
    featuresEyebrow: 'Principais funcionalidades',
    featuresTitle: 'Do planejamento à evolução.',
    featureTitles: [
      'Fichas que se adaptam',
      'Treino sem interrupções',
      'Consistência visível',
      'Evolução baseada em dados',
      'Local-first de verdade',
      'Experiência mobile cuidada',
    ],
    featureBodies: [
      'Criação e edição de fichas, modelos ABC, superior/inferior e corpo inteiro, além de um catálogo de exercícios com instruções e ilustrações.',
      'Registro de cargas, repetições e séries, temporizador circular de descanso e controles para pausar, retomar, concluir ou cancelar uma sessão.',
      'Calendário de frequência, dias planejados, metas semanais e sistema de sequência “OnFire” para transformar rotina em motivação.',
      'Histórico completo, gráficos de carga máxima, volume e desempenho, além do registro mensal de medidas corporais.',
      'Banco SQLite no dispositivo, funcionamento offline, exportação e restauração de backups e importação opcional de dados da API.',
      'Temas claro, escuro e automático, componentes responsivos e Semantics para uma navegação mais acessível.',
    ],
    showcaseEyebrow: 'Experiência em foco',
    showcaseTitle: 'Menos atrito. Mais constância.',
    showcaseBody: 'A interface prioriza o que importa durante o treino: saber o que fazer agora, registrar rapidamente o resultado e visualizar o próximo passo. Calendário, metas e feedback de sequência tornam o progresso fácil de entender.',
    showcaseTags: [
      'Treino em andamento',
      'Descanso guiado',
      'Calendário',
      'OnFire',
    ],
    architectureEyebrow: 'Arquitetura',
    architectureTitle: 'Camadas independentes, produto flexível.',
    architectureLead: 'A separação entre interface, regras de negócio e dados permite alternar a origem das informações sem modificar as telas. Cada módulo — treinos, sessões, consistência, progresso e configurações — mantém suas próprias responsabilidades.',
    appArchitectureTitle: 'Aplicativo Flutter',
    appArchitectureBody: 'Organizado por funcionalidades, usa Stores e domínio para coordenar a interface. O padrão Gateway abstrai persistência local, comunicação remota e dados de demonstração.',
    appFlow: ['Interface', 'Stores', 'Domínio', 'Gateways', 'SQLite / API'],
    apiArchitectureTitle: 'API ASP.NET Core',
    apiArchitectureBody: 'Controllers tratam HTTP, Services concentram validações e regras, Repositories isolam o acesso aos dados e DTOs mantêm contratos explícitos.',
    apiFlow: ['Controllers', 'Services', 'Repositories', 'EF Core', 'SQLite'],
    snapshotBody: 'As sessões armazenam snapshots das fichas e dos exercícios. Assim, alterar uma ficha no futuro não modifica o histórico de treinos já realizados.',
    decisionsEyebrow: 'Decisões técnicas',
    decisionsTitle: 'Integridade pensada desde a base.',
    decisions: [
      'Arquitetura local-first para garantir uso offline.',
      'UUIDs consistentes entre aplicativo e API.',
      'Operações idempotentes para evitar duplicidades.',
      'Transações contra gravações incompletas.',
      'Snapshots para preservar o histórico.',
      'Regras de integridade aplicadas também no banco.',
      'Datas em UTC com conversão por fuso horário.',
      'Índice exclusivo para apenas uma sessão ativa.',
      'Backup validado e restaurado em uma transação.',
    ],
    processEyebrow: 'Como foi construído',
    processTitle: 'Evolução por etapas, sem perder a base.',
    processTitles: [
      'Fundação',
      'Sessão completa',
      'Consistência',
      'Local-first e evolução',
    ],
    processBodies: [
      'Catálogo de exercícios, fichas e operações de criação, edição e exclusão.',
      'Execução do treino com séries, descanso, pausa, retomada, conclusão e histórico.',
      'Calendário, rotina semanal, metas e o sistema motivacional OnFire.',
      'SQLite como padrão, backup, restauração, importação da API, gráficos e medidas corporais.',
    ],
    technologyEyebrow: 'Tecnologia e qualidade',
    technologyTitle: 'Uma stack preparada para evoluir.',
    appStackTitle: 'Aplicativo',
    appStack: [
      'Flutter',
      'Dart',
      'Material Design',
      'Drift ORM',
      'SQLite',
      'HTTP',
      'UUID',
      'Timezone',
      'File Selector',
      'Share Plus',
      'CustomPainter',
      'Semantics',
    ],
    apiStackTitle: 'Back-end',
    apiStack: [
      'C#',
      '.NET 10',
      'ASP.NET Core Web API',
      'Entity Framework Core',
      'SQLite',
      'REST',
      'OpenAPI',
      'DTOs',
      'Dependency Injection',
      'CORS',
      'Problem Details',
      'Migrations',
    ],
    qualityStackTitle: 'Qualidade e testes',
    qualityStack: [
      'Flutter Test',
      'Widget Tests',
      'Integration Tests',
      'xUnit',
      'ASP.NET Core Test Host',
      'SQLite isolado',
      'Flutter Analyze',
      'Contratos HTTP',
      'Transações',
      'Concorrência',
      'Integridade de dados',
    ],
    closingEyebrow: 'MoveUp',
    closingTitle: 'Seu próximo treino começa com organização.',
    closingBody: 'Uma aplicação full stack que une experiência mobile, arquitetura local-first e cuidado com a integridade dos dados.',
  );

  static const en = _MoveUpCopy(
    back: 'Back',
    backToPortfolio: 'Back to portfolio',
    heroEyebrow: 'Full-stack application · Local-first',
    heroTitle: 'Organize your routine. Train at your pace.',
    heroBody: 'Plan routines, log every set, control rest periods and follow your progress in a fast, accessible mobile experience designed to work offline.',
    exploreFeatures: 'Discover MoveUp',
    offline: 'Works offline',
    localFirst: 'On-device data',
    backup: 'Backup and restore',
    devicesAlt: 'MoveUp screens showing an active workout, rest timer and consistency calendar',
    overviewEyebrow: 'Product overview',
    overviewTitle: 'The entire workout journey in one place.',
    overviewBody: 'MoveUp makes workout tracking simpler, more organized and motivating. Users can create custom routines or start from templates, log weights and repetitions during a session, and track consistency, performance and body measurements over time.',
    valueOffline: 'Complete offline experience',
    valueSources: 'Local, API or preview mode',
    valueIntegrity: 'Reliable data and preserved history',
    featuresEyebrow: 'Core features',
    featuresTitle: 'From planning to progress.',
    featureTitles: [
      'Flexible workout routines',
      'Uninterrupted sessions',
      'Visible consistency',
      'Data-driven progress',
      'Truly local-first',
      'Thoughtful mobile UX',
    ],
    featureBodies: [
      'Create and edit routines, use ABC, upper/lower and full-body templates, and browse an exercise catalog with instructions and illustrations.',
      'Log weights, repetitions and sets, use a circular rest timer, and pause, resume, complete or cancel a session.',
      'Review a consistency calendar, planned days, weekly goals and the “OnFire” streak system that turns routine into motivation.',
      'Explore full workout history, maximum load, volume and performance charts, plus monthly body measurement records.',
      'Keep data in on-device SQLite, work offline, export and restore backups, and optionally import data from the API.',
      'Choose light, dark or system themes and use responsive, accessible interfaces supported by Semantics.',
    ],
    showcaseEyebrow: 'Experience in focus',
    showcaseTitle: 'Less friction. More consistency.',
    showcaseBody: 'The interface prioritizes what matters during a workout: knowing what to do now, logging results quickly and seeing the next step. Calendar, goals and streak feedback make progress easy to understand.',
    showcaseTags: ['Active workout', 'Guided rest', 'Calendar', 'OnFire'],
    architectureEyebrow: 'Architecture',
    architectureTitle: 'Independent layers, flexible product.',
    architectureLead: 'Separating interface, business rules and data access makes it possible to switch data sources without changing the screens. Each module — workouts, sessions, consistency, progress and settings — owns its responsibilities.',
    appArchitectureTitle: 'Flutter application',
    appArchitectureBody: 'Organized by feature, it uses Stores and domain rules to coordinate the interface. The Gateway pattern abstracts local persistence, remote communication and preview data.',
    appFlow: ['Interface', 'Stores', 'Domain', 'Gateways', 'SQLite / API'],
    apiArchitectureTitle: 'ASP.NET Core API',
    apiArchitectureBody: 'Controllers handle HTTP, Services hold validation and business rules, Repositories isolate data access, and DTOs keep contracts explicit.',
    apiFlow: ['Controllers', 'Services', 'Repositories', 'EF Core', 'SQLite'],
    snapshotBody: 'Sessions store snapshots of workout routines and exercises. Future routine changes therefore never rewrite previously completed workout history.',
    decisionsEyebrow: 'Technical decisions',
    decisionsTitle: 'Integrity designed from the foundation.',
    decisions: [
      'Local-first architecture for offline use.',
      'Consistent UUIDs across application and API.',
      'Idempotent operations to prevent duplicates.',
      'Transactions to prevent partial writes.',
      'Snapshots that preserve workout history.',
      'Integrity rules enforced in the database.',
      'UTC dates converted by local timezone.',
      'Unique index allowing one active session.',
      'Validated backup restored in one transaction.',
    ],
    processEyebrow: 'How it was built',
    processTitle: 'Incremental evolution on a solid foundation.',
    processTitles: [
      'Foundation',
      'Complete session',
      'Consistency',
      'Local-first and progress',
    ],
    processBodies: [
      'Exercise catalog, workout routines and create, edit and delete operations.',
      'Workout execution with sets, rest, pause, resume, completion and history.',
      'Calendar, weekly routine, goals and the motivational OnFire system.',
      'SQLite by default, backup, restore, API import, progress charts and body measurements.',
    ],
    technologyEyebrow: 'Technology and quality',
    technologyTitle: 'A stack ready to evolve.',
    appStackTitle: 'Application',
    appStack: [
      'Flutter',
      'Dart',
      'Material Design',
      'Drift ORM',
      'SQLite',
      'HTTP',
      'UUID',
      'Timezone',
      'File Selector',
      'Share Plus',
      'CustomPainter',
      'Semantics',
    ],
    apiStackTitle: 'Back end',
    apiStack: [
      'C#',
      '.NET 10',
      'ASP.NET Core Web API',
      'Entity Framework Core',
      'SQLite',
      'REST',
      'OpenAPI',
      'DTOs',
      'Dependency Injection',
      'CORS',
      'Problem Details',
      'Migrations',
    ],
    qualityStackTitle: 'Quality and testing',
    qualityStack: [
      'Flutter Test',
      'Widget Tests',
      'Integration Tests',
      'xUnit',
      'ASP.NET Core Test Host',
      'Isolated SQLite',
      'Flutter Analyze',
      'HTTP Contracts',
      'Transactions',
      'Concurrency',
      'Data integrity',
    ],
    closingEyebrow: 'MoveUp',
    closingTitle: 'Your next workout starts with organization.',
    closingBody: 'A full-stack application combining mobile experience, local-first architecture and careful data integrity.',
  );
}
