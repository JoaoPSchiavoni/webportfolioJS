import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';

const orange = Color(0xFFFF6B35);
const background = Color(0xFF0B151D);
const surface = Color(0xFF111F29);
const muted = Color(0xFFA9B2B8);

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  Locale locale = const Locale('pt');
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'João Schiavoni | Software Developer',
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(primary: orange, surface: surface),
      fontFamily: 'Arial',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, height: 1.7, color: muted),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: orange,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
          side: const BorderSide(color: Color(0xFF34434E)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    home: PortfolioPage(
      onLocale: (value) => setState(() => locale = Locale(value)),
    ),
  );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, required this.onLocale});
  final ValueChanged<String> onLocale;
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  final keys = List.generate(5, (_) => GlobalKey());
  final name = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();
  final form = GlobalKey<FormState>();
  late final AnimationController motion = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 32),
  );
  bool menu = false;
  bool reduced = false;
  AppLocalizations get t => AppLocalizations.of(context)!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reduced = MediaQuery.disableAnimationsOf(context);
    if (reduced) {
      motion.stop();
    } else if (!motion.isAnimating) {
      motion.repeat();
    }
  }

  @override
  void dispose() {
    motion.dispose();
    name.dispose();
    email.dispose();
    message.dispose();
    super.dispose();
  }

  void go(int index) {
    setState(() => menu = false);
    final target = keys[index].currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: Duration(milliseconds: reduced ? 0 : 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> open(String url) async {
    try {
      final uri = Uri.parse(url);
      final ok = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
      if (!ok) {
        throw StateError('Unavailable');
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.linkError)));
      }
    }
  }

  Widget label(String text) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      color: orange,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 2.5,
    ),
  );
  Widget heading(String text, {double size = 42}) => Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: size,
      height: 1.15,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.5,
    ),
  );
  Widget chip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFF1B2A35),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, color: Color(0xFFCED6DB)),
    ),
  );
  Widget section(int index, Widget child, {Color? color}) => Container(
    key: keys[index],
    width: double.infinity,
    color: color,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: child,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 800;
    final nav = [t.home, t.about, t.technologies, t.projects, t.contact];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: background,
                border: Border(bottom: BorderSide(color: Color(0xFF22303A))),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: SizedBox(
                    height: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: TextButton(
                              onPressed: () => go(0),
                              child: Text(
                                mobile ? 'JS.' : 'JS. / SCHIAVONI',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF34434E)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: ['pt', 'en']
                                .map(
                                  (lang) => Semantics(
                                    selected: t.localeName == lang,
                                    child: TextButton(
                                      onPressed: () => widget.onLocale(lang),
                                      style: TextButton.styleFrom(
                                        foregroundColor: t.localeName == lang
                                            ? orange
                                            : muted,
                                        minimumSize: const Size(48, 44),
                                      ),
                                      child: Text(lang.toUpperCase()),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: mobile
                                ? IconButton(
                                    tooltip: t.menu,
                                    onPressed: () =>
                                        setState(() => menu = !menu),
                                    icon: Icon(menu ? Icons.close : Icons.menu),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [1, 3, 4]
                                        .map(
                                          (i) => TextButton(
                                            onPressed: () => go(i),
                                            child: Text(
                                              nav[i],
                                              style: const TextStyle(
                                                color: muted,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (menu && mobile)
              Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  5,
                  (i) =>
                      TextButton(onPressed: () => go(i), child: Text(nav[i])),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    section(0, hero(mobile)),
                    section(
                      2,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          label(t.techLabel),
                          const SizedBox(height: 30),
                          carousel(),
                        ],
                      ),
                      color: surface,
                    ),
                    section(1, about(mobile)),
                    section(3, projects(mobile), color: surface),
                    section(4, contact(mobile)),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF22303A)),
                        ),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 32,
                        runSpacing: 12,
                        children: [
                          Text(
                            '© ${DateTime.now().year} João Schiavoni',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(t.footer, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hero(bool mobile) {
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(t.heroLabel),
        const SizedBox(height: 24),
        Text(t.hello, style: const TextStyle(color: muted, fontSize: 20)),
        const SizedBox(height: 12),
        heading('João\nSchiavoni.', size: mobile ? 58 : 78),
        const SizedBox(height: 22),
        AnimatedBuilder(
          animation: motion,
          builder: (_, _) => AnimatedSwitcher(
            duration: Duration(milliseconds: reduced ? 0 : 500),
            child: Text(
              (motion.value * 8).floor().isEven
                  ? 'Software Developer'
                  : 'Backend Developer',
              key: ValueKey((motion.value * 8).floor().isEven),
              style: TextStyle(
                fontSize: mobile ? 23 : 27,
                fontWeight: FontWeight.w600,
                color: orange,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Text(
            t.heroDescription,
            style: const TextStyle(fontSize: 18, height: 1.7),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => go(3),
              icon: const Icon(Icons.arrow_outward, size: 18),
              label: Text(t.seeProjects),
            ),
            OutlinedButton.icon(
              onPressed: () => open(
                Uri.base
                    .resolve('assets/assets/documents/curriculo_joao.pdf')
                    .toString(),
              ),
              icon: const Icon(Icons.file_download_outlined, size: 18),
              label: Text(t.resume),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          children: [
            socialIcon(
              'GitHub',
              'assets/icons/github.svg',
              'https://github.com/JoaoPSchiavoni',
            ),
            socialIcon(
              'LinkedIn',
              'assets/icons/linkedin.svg',
              'https://www.linkedin.com/in/joao-schiavoni',
            ),
          ],
        ),
      ],
    );
    final portrait = SizedBox(
      height: mobile ? 390 : 565,
      child: AnimatedBuilder(
        animation: motion,
        builder: (_, _) => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 390,
              height: 390,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    orange.withValues(alpha: .22),
                    orange.withValues(alpha: .02),
                  ],
                ),
                border: Border.all(color: orange.withValues(alpha: .3)),
              ),
            ),
            Transform.rotate(
              key: const ValueKey('portrait-orbit'),
              angle: motion.value * math.pi * 4,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  border: Border.all(color: orange.withValues(alpha: .25)),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(
                  0,
                  reduced ? 0 : math.sin(motion.value * math.pi * 16) * 8,
                ),
                child: ShaderMask(
                  shaderCallback: (rect) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white, Colors.transparent],
                    stops: [0, .78, 1],
                  ).createShader(rect),
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/joao.png',
                    fit: BoxFit.contain,
                    semanticLabel: 'João Schiavoni',
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 45,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: surface,
                  border: Border.all(color: const Color(0xFF34434E)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '</>   Clean code.\n       Clear purpose.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [portrait, const SizedBox(height: 24), copy],
          )
        : Row(
            children: [
              Expanded(child: copy),
              const SizedBox(width: 40),
              Expanded(child: portrait),
            ],
          );
  }

  Widget socialIcon(String label, String asset, String url) => IconButton(
    tooltip: label,
    onPressed: () => open(url),
    style: IconButton.styleFrom(
      minimumSize: const Size(48, 48),
      padding: const EdgeInsets.all(10),
      backgroundColor: surface,
      hoverColor: orange.withValues(alpha: .16),
      side: const BorderSide(color: Color(0xFF34434E)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    icon: SvgPicture.asset(
      asset,
      width: 28,
      height: 28,
      excludeFromSemantics: true,
    ),
  );

  Widget carousel() {
    const tech = [
      '.NET',
      'Python',
      'FastAPI',
      'Flask',
      'Flutter',
      'PostgreSQL',
      'MySQL',
      'SQL Server',
      'Azure',
      'AWS',
      'Git',
      'Docker',
    ];
    const textStyle = TextStyle(
      inherit: false,
      fontFamily: 'Arial',
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.7,
      decoration: TextDecoration.none,
    );
    final scaler = MediaQuery.textScalerOf(context);
    final direction = Directionality.of(context);
    // Each label keeps its natural width, followed by the same 40 px gap.
    final widths = tech.map((text) {
      final painter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: direction,
        textScaler: scaler,
      )..layout();
      final width = painter.width.ceilToDouble();
      painter.dispose();
      return width;
    }).toList();
    const iconWidth = 24.0;
    const iconGap = 14.0;
    const itemGap = 40.0;
    final cycleWidth = widths.fold<double>(
      0,
      (sum, width) => sum + iconWidth + iconGap + width + itemGap,
    );
    return Semantics(
      label: tech.join(', '),
      child: ExcludeSemantics(
        child: SizedBox(
          height: 55,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final copies = (constraints.maxWidth / cycleWidth).ceil() + 2;
              return ClipRect(
                child: AnimatedBuilder(
                  animation: motion,
                  builder: (_, child) => OverflowBox(
                    alignment: Alignment.centerLeft,
                    maxWidth: double.infinity,
                    child: Transform.translate(
                      key: const ValueKey('technology-motion'),
                      offset: Offset(-motion.value * cycleWidth, 0),
                      child: child,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(copies * tech.length, (index) {
                      final i = index % tech.length;
                      return Padding(
                        padding: const EdgeInsets.only(right: itemGap),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: iconWidth,
                              child: Icon(
                                Icons.emergency,
                                color: orange,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: iconGap),
                            SizedBox(
                              width: widths[i],
                              child: Text(
                                tech[i],
                                style: textStyle,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget about(bool mobile) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label('01 / ${t.about}'),
        const SizedBox(height: 20),
        heading(t.aboutTitle),
        const SizedBox(height: 28),
        ...[
          ('01', 'Backend Development'),
          ('02', 'Software Engineering'),
          ('03', 'Software Architecture'),
        ].map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Text(
                  item.$1,
                  style: const TextStyle(
                    color: orange,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    item.$2,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    final story = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.aboutBody),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            'Clean Architecture',
            'SOLID',
            'REST APIs',
          ].map(chip).toList(),
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: orange, width: 2)),
          ),
          child: Text(t.education),
        ),
      ],
    );
    return mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [intro, const SizedBox(height: 24), story],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: intro),
              const SizedBox(width: 72),
              Expanded(flex: 6, child: story),
            ],
          );
  }

  Widget projects(bool mobile) {
    final data = [
      (
        'Agendai Fisio',
        t.fisio,
        '.NET · Flutter · PostgreSQL',
        t.realProject,
        Icons.calendar_month_outlined,
        const Color(0xFF7CB7AC),
      ),
      (
        'ExpenseTracker',
        t.expense,
        'FastAPI · Flutter · PostgreSQL',
        t.personalProject,
        Icons.bar_chart_rounded,
        const Color(0xFFB5A0DC),
      ),
      (
        'CloudTask API',
        t.cloud,
        '.NET · Docker · PostgreSQL · AWS',
        t.concept,
        Icons.cloud_outlined,
        const Color(0xFF8DB8DD),
      ),
      (
        'AI Document API',
        t.ai,
        'Python · FastAPI · Azure AI · Docker',
        t.concept,
        Icons.description_outlined,
        orange,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label('02 / ${t.projects}'),
        const SizedBox(height: 20),
        heading(t.projectsTitle),
        const SizedBox(height: 16),
        Text(t.projectsIntro),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (_, c) => Wrap(
            spacing: 24,
            runSpacing: 24,
            children: data.asMap().entries.map((entry) {
              final p = entry.value;
              return SizedBox(
                width: c.maxWidth < 700 ? c.maxWidth : (c.maxWidth - 24) / 2,
                child: HoverCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(minHeight: 190),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [p.$6.withValues(alpha: .16), background],
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(p.$5, color: p.$6, size: 36),
                                Text(
                                  '0${entry.key + 1}',
                                  style: TextStyle(
                                    color: p.$6,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Text(
                              p.$1,
                              style: TextStyle(
                                color: p.$6,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              t.projectVisual,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label(p.$4),
                            const SizedBox(height: 12),
                            Text(
                              p.$1,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(p.$2),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: p.$3.split(' · ').map(chip).toList(),
                            ),
                            const SizedBox(height: 20),
                            TextButton.icon(
                              onPressed: () => showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(p.$1),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      '${p.$4}\n\n${p.$2}\n\n${p.$3}\n\n${entry.key < 2 ? t.realDetail : t.conceptDetail}',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(t.close),
                                    ),
                                  ],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_outward, size: 18),
                              label: Text(t.details),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget contact(bool mobile) {
    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label('03 / ${t.contact}'),
        const SizedBox(height: 20),
        heading(t.contactTitle),
        const SizedBox(height: 20),
        Text(t.contactBody),
        const SizedBox(height: 28),
        SelectableText(
          'joaopschiavoni@gmail.com',
          style: TextStyle(color: orange, fontSize: mobile ? 16 : 20),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          children: [
            socialIcon(
              'GitHub',
              'assets/icons/github.svg',
              'https://github.com/JoaoPSchiavoni',
            ),
            socialIcon(
              'LinkedIn',
              'assets/icons/linkedin.svg',
              'https://www.linkedin.com/in/joao-schiavoni',
            ),
          ],
        ),
      ],
    );
    final fields = Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: name,
            decoration: InputDecoration(labelText: t.name),
            validator: (v) =>
                v == null || v.trim().isEmpty ? t.requiredField : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: t.email),
            validator: (v) =>
                v != null &&
                    RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim())
                ? null
                : t.invalidEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: message,
            minLines: 4,
            maxLines: 7,
            decoration: InputDecoration(labelText: t.message),
            validator: (v) =>
                v == null || v.trim().isEmpty ? t.requiredField : null,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              if (form.currentState!.validate()) {
                final subject = Uri.encodeComponent(
                  '${t.mailSubject} — ${name.text.trim()}',
                );
                final body = Uri.encodeComponent(
                  '${name.text.trim()} <${email.text.trim()}>\n\n${message.text.trim()}',
                );
                open(
                  'mailto:joaopschiavoni@gmail.com?subject=$subject&body=$body',
                );
              }
            },
            icon: const Icon(Icons.arrow_outward, size: 18),
            label: Text(t.send),
          ),
          const SizedBox(height: 12),
          Text(t.mailHint, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
    return mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [info, const SizedBox(height: 36), fields],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: info),
              const SizedBox(width: 80),
              Expanded(child: fields),
            ],
          );
  }
}

class HoverCard extends StatefulWidget {
  const HoverCard({super.key, required this.child});
  final Widget child;
  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hover = false;
  final Set<int> pointers = {};

  void release(PointerEvent event) {
    setState(() => pointers.remove(event.pointer));
  }

  @override
  Widget build(BuildContext context) {
    final active = hover || pointers.isNotEmpty;
    final reduced = MediaQuery.disableAnimationsOf(context);
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      // Raw pointer events preserve scrolling and the nested project button.
      child: Listener(
        onPointerDown: (event) => setState(() => pointers.add(event.pointer)),
        onPointerUp: release,
        onPointerCancel: release,
        child: AnimatedContainer(
          duration: Duration(milliseconds: reduced ? 0 : 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            0,
            active && !reduced ? -5 : 0,
            0,
          ),
          decoration: BoxDecoration(
            color: background,
            border: Border.all(
              color: active ? orange : const Color(0xFF293944),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
