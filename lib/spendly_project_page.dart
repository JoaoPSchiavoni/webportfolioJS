import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpendlyProjectPage extends StatefulWidget {
  const SpendlyProjectPage({this.onGetStarted, super.key});

  final VoidCallback? onGetStarted;

  @override
  State<SpendlyProjectPage> createState() => _SpendlyProjectPageState();
}

class _SpendlyProjectPageState extends State<SpendlyProjectPage> {
  static const _contentWidth = 1240.0;
  static const _midnight = Color(0xFF080C16);

  final _scrollController = ScrollController();
  final _featuresKey = GlobalKey();
  final _architectureKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final target = key.currentContext;
    if (target == null) return;
    await Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: .02,
    );
  }

  void _getStarted() {
    if (widget.onGetStarted != null) {
      widget.onGetStarted!();
      return;
    }
    final navigator = Navigator.of(context);
    if (navigator.canPop()) navigator.pop();
  }

  Future<void> _openLink(Uri uri) async {
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) throw StateError('Could not open $uri');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir este link agora.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFD),
        body: SafeArea(
          bottom: false,
          child: ColoredBox(
            color: const Color(0xFFFCFCFD),
            child: Column(
              children: [
                _LandingHeader(
                  isDark: false,
                  showBackButton: Navigator.of(context).canPop(),
                  onBack: () => Navigator.of(context).maybePop(),
                  onFeatures: () => _scrollTo(_featuresKey),
                  onArchitecture: () => _scrollTo(_architectureKey),
                  onGetStarted: _getStarted,
                ),
                Expanded(
                  child: SelectionArea(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          _HeroSection(
                            onGetStarted: _getStarted,
                            onExploreFeatures: () => _scrollTo(_featuresKey),
                          ),
                          const _BuildStrip(),
                          const _MetricsSection(isDark: false),
                          _FeaturesSection(key: _featuresKey, isDark: false),
                          const _RealAppShowcase(),
                          const _ProductStorySection(isDark: false),
                          _ArchitectureSection(key: _architectureKey),
                          _FinalCallToAction(onGetStarted: _getStarted),
                          _LandingFooter(
                            onFeatures: () => _scrollTo(_featuresKey),
                            onArchitecture: () => _scrollTo(_architectureKey),
                            onEmail: () => _openLink(
                              Uri(
                                scheme: 'mailto',
                                path: 'Joaopschiavoni@gmail.com',
                                queryParameters: {
                                  'subject': 'Contato sobre o Spendly',
                                },
                              ),
                            ),
                            onGitHub: () => _openLink(
                              Uri.parse(
                                'https://github.com/JoaoPSchiavoni/ExpenseTrackapp',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _LandingHeader extends StatelessWidget {
  const _LandingHeader({
    required this.isDark,
    required this.showBackButton,
    required this.onBack,
    required this.onFeatures,
    required this.onArchitecture,
    required this.onGetStarted,
  });

  final bool isDark;
  final bool showBackButton;
  final VoidCallback onBack;
  final VoidCallback onFeatures;
  final VoidCallback onArchitecture;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? AppColors.darkBackground : const Color(0xFFFBFCFE),
      child: Container(
        height: 78,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder.withValues(alpha: .72),
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final showNavigation = constraints.maxWidth >= 900;
            final compact = constraints.maxWidth < 430;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: _SpendlyProjectPageState._contentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth < 720 ? 16 : 28,
                  ),
                  child: Row(
                    children: [
                      if (showBackButton) ...[
                        IconButton(
                          onPressed: onBack,
                          tooltip: 'Voltar',
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const SizedBox(width: 4),
                      ],
                      const SpendlyMark(size: 38, withShadow: false),
                      if (!compact) ...[
                        const SizedBox(width: 10),
                        Text(
                          'Spendly',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -.7,
                              ),
                        ),
                      ],
                      const Spacer(),
                      if (showNavigation) ...[
                        _HeaderLink(
                          key: const ValueKey('landing-nav-features'),
                          label: 'Recursos',
                          onPressed: onFeatures,
                        ),
                        _HeaderLink(
                          key: const ValueKey('landing-nav-architecture'),
                          label: 'Tecnologia',
                          onPressed: onArchitecture,
                        ),
                        const SizedBox(width: 10),
                      ],
                      FilledButton(
                        key: const ValueKey('landing-header-cta'),
                        onPressed: onGetStarted,
                        style: FilledButton.styleFrom(
                          minimumSize: Size(compact ? 104 : 142, 46),
                          padding: EdgeInsets.symmetric(
                            horizontal: compact ? 16 : 21,
                          ),
                          backgroundColor: isDark
                              ? Colors.white
                              : AppColors.ink,
                          foregroundColor: isDark
                              ? AppColors.ink
                              : Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(compact ? 'Começar' : 'Experimentar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      child: Text(label),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onGetStarted,
    required this.onExploreFeatures,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onExploreFeatures;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return _SectionFrame(
      verticalPadding: 30,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sideBySide = constraints.maxWidth >= 900;
          final horizontalPadding = sideBySide ? 54.0 : 24.0;
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Eyebrow(
                icon: Icons.auto_awesome_rounded,
                text: 'SEU DINHEIRO, COM MAIS CLAREZA',
              ),
              SizedBox(height: sideBySide ? 30 : 22),
              Text(
                'Organize hoje.\nRespire tranquilo amanhã.',
                style: theme.textTheme.displayLarge?.copyWith(
                  color: AppColors.ink,
                  fontSize: sideBySide ? 58 : 42,
                  height: 1.03,
                  fontWeight: FontWeight.w800,
                  letterSpacing: sideBySide ? -2.7 : -1.8,
                ),
              ),
              const SizedBox(height: 22),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  'Acompanhe gastos, orçamentos e metas em uma experiência simples, visual e feita para decisões melhores.',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: muted,
                    height: 1.52,
                    fontSize: sideBySide ? 18 : 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    key: const ValueKey('landing-primary-cta'),
                    onPressed: onGetStarted,
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    label: const Text('Experimentar agora'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 54),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      backgroundColor: AppColors.ink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: onExploreFeatures,
                    icon: const Icon(Icons.grid_view_rounded, size: 18),
                    label: const Text('Explorar solução'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 54),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      foregroundColor: AppColors.ink,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFDDE1E8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Wrap(
                spacing: 16,
                runSpacing: 9,
                children: [
                  _TrustItem(text: 'Modo demonstração'),
                  _TrustItem(text: 'Dados protegidos'),
                  _TrustItem(text: 'Multiplataforma'),
                ],
              ),
            ],
          );

          const visual = _HeroVisual();
          final body = sideBySide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 10, child: copy),
                    const SizedBox(width: 28),
                    const Expanded(flex: 11, child: visual),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [copy, const SizedBox(height: 34), visual],
                );

          return Container(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              sideBySide ? 48 : 34,
              horizontalPadding,
              sideBySide ? 24 : 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sideBySide ? 38 : 28),
              border: Border.all(color: const Color(0xFFE7E8EC)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFDFBFF),
                  Color(0xFFF6ECF4),
                ],
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: body,
          );
        },
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'iPhone exibindo a interface real do aplicativo Spendly.',
      child: AspectRatio(
        aspectRatio: 1.02,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 8,
              right: 8,
              bottom: 18,
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .12),
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(240, 35),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Image(
                image: AssetImage(
                  'assets/images/spendly-landing/spendly-iphone-hand-mockup.png',
                ),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                excludeFromSemantics: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? .17 : .09),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: isDark ? .32 : .16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: .8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: AppColors.green,
          size: 18,
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildStrip extends StatelessWidget {
  const _BuildStrip();

  @override
  Widget build(BuildContext context) {
    const technologies = [
      (Icons.flutter_dash_rounded, 'Flutter'),
      (Icons.bolt_rounded, 'FastAPI'),
      (Icons.storage_rounded, 'PostgreSQL'),
      (Icons.shield_outlined, 'JWT'),
      (Icons.devices_rounded, 'Web + mobile'),
    ];
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FB),
      child: _SectionFrame(
        verticalPadding: 28,
        child: Column(
          children: [
            const Text(
              'CONSTRUÍDO COM',
              style: TextStyle(
                color: Color(0xFF8A919E),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.25,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 18,
              children: [
                for (final technology in technologies)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(technology.$1, color: AppColors.ink, size: 21),
                      const SizedBox(width: 8),
                      Text(
                        technology.$2,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -.3,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RealAppShowcase extends StatelessWidget {
  const _RealAppShowcase();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: _SectionFrame(
        verticalPadding: 78,
        child: Column(
          children: [
            const _SectionHeading(
              eyebrow: 'O PRODUTO, DE VERDADE',
              title: 'Uma tela real. Dentro de um iPhone.',
              subtitle: 'O mockup abaixo usa uma captura direta do Spendly em execução — sem substituir o produto por uma interface genérica.',
            ),
            const SizedBox(height: 46),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3F7),
                borderRadius: BorderRadius.circular(32),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final sideBySide = constraints.maxWidth >= 820;
                  final phone = const _ExactIPhone();
                  final copy = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD83D),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_outlined,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Tudo o que importa, sem ruído.',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColors.ink,
                          fontSize: 34,
                          height: 1.08,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Patrimônio, entradas, saídas, projeções e saúde financeira aparecem em uma leitura rápida e acionável.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF626875),
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const _ShowcaseLine(
                        number: '01',
                        title: 'Visão mensal consolidada',
                        text: 'Saldo, receitas, despesas e carteiras em um único resumo.',
                      ),
                      const _ShowcaseLine(
                        number: '02',
                        title: 'Fluxo de caixa visual',
                        text: 'Comparação direta entre entradas e saídas ao longo dos meses.',
                      ),
                      const _ShowcaseLine(
                        number: '03',
                        title: 'Navegação realmente móvel',
                        text: 'A mesma base Flutter se adapta a iPhone, web e desktop.',
                        showDivider: false,
                      ),
                    ],
                  );
                  if (!sideBySide) {
                    return Column(
                      children: [phone, const SizedBox(height: 42), copy],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 9, child: phone),
                      const SizedBox(width: 58),
                      Expanded(flex: 10, child: copy),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExactIPhone extends StatelessWidget {
  const _ExactIPhone();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 330),
        child: AspectRatio(
          aspectRatio: 1170 / 2487,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF080A0D),
              borderRadius: BorderRadius.circular(52),
              border: Border.all(color: const Color(0xFF343840), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .22),
                  blurRadius: 34,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(43),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ColoredBox(color: Color(0xFFF4F6FA)),
                  const Positioned.fill(
                    top: 28,
                    child: Image(
                      image: AssetImage(
                        'assets/images/spendly-landing/spendly-dashboard-real.png',
                      ),
                      fit: BoxFit.fill,
                      excludeFromSemantics: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 92,
                      height: 27,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowcaseLine extends StatelessWidget {
  const _ShowcaseLine({
    required this.number,
    required this.title,
    required this.text,
    this.showDivider = true,
  });

  final String number;
  final String title;
  final String text;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: Color(0xFFD7DCE4)))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 38,
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFF8B929E),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF676E7A),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsSection extends StatelessWidget {
  const _MetricsSection({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    const metrics = [
      (
        value: '80+',
        label: 'operações financeiras integradas',
        icon: Icons.hub_rounded,
      ),
      (
        value: '1 lugar',
        label: 'para planejar, acompanhar e decidir',
        icon: Icons.dashboard_customize_rounded,
      ),
      (
        value: '6+ telas',
        label: 'adaptadas a mobile, web e desktop',
        icon: Icons.devices_rounded,
      ),
    ];

    return _SectionFrame(
      verticalPadding: 22,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xFF15233A).withValues(alpha: .05),
                    blurRadius: 26,
                    offset: const Offset(0, 12),
                  ),
                ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 680;
            if (stacked) {
              return Column(
                children: [
                  for (var index = 0; index < metrics.length; index++) ...[
                    if (index > 0)
                      Divider(
                        height: 28,
                        color: Theme.of(context).dividerColor,
                      ),
                    _Metric(
                      value: metrics[index].value,
                      label: metrics[index].label,
                      icon: metrics[index].icon,
                    ),
                  ],
                ],
              );
            }
            return IntrinsicHeight(
              child: Row(
                children: [
                  for (var index = 0; index < metrics.length; index++) ...[
                    if (index > 0)
                      VerticalDivider(
                        width: 34,
                        color: Theme.of(context).dividerColor,
                      ),
                    Expanded(
                      child: _Metric(
                        value: metrics[index].value,
                        label: metrics[index].label,
                        icon: metrics[index].icon,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label, required this.icon});

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -.5),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({required this.isDark, super.key});

  final bool isDark;

  static const _features = [
    _FeatureItem(
      icon: Icons.space_dashboard_rounded,
      color: AppColors.primary,
      title: 'Dashboard inteligente',
      text: 'Saldo, receitas, despesas e fluxo de caixa traduzidos em uma visão simples e acionável.',
    ),
    _FeatureItem(
      icon: Icons.donut_large_rounded,
      color: AppColors.cyan,
      title: 'Orçamentos sob controle',
      text: 'Defina limites, acompanhe o consumo por categoria e receba alertas antes de ultrapassar o plano.',
    ),
    _FeatureItem(
      icon: Icons.track_changes_rounded,
      color: AppColors.green,
      title: 'Metas que ganham forma',
      text: 'Transforme objetivos em progresso visual e acompanhe cada passo da sua reserva financeira.',
    ),
    _FeatureItem(
      icon: Icons.auto_awesome_motion_rounded,
      color: AppColors.purple,
      title: 'Rotina automatizada',
      text: 'Organize recorrências, regras de categorização e assinaturas sem repetir trabalho todos os meses.',
    ),
    _FeatureItem(
      icon: Icons.upload_file_rounded,
      color: AppColors.amber,
      title: 'Importação sem atrito',
      text: 'Traga extratos CSV e OFX, revise os lançamentos e concentre seu histórico em um único espaço.',
    ),
    _FeatureItem(
      icon: Icons.insights_rounded,
      color: AppColors.pink,
      title: 'Decisões com contexto',
      text: 'Compare períodos, projete o saldo e gere relatórios para entender o que mudou e agir com confiança.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: isDark ? AppColors.darkSurface : const Color(0xFFF4F6FA),
      child: _SectionFrame(
        verticalPadding: 108,
        child: Column(
          children: [
            const _SectionHeading(
              eyebrow: 'RECURSOS PARA A VIDA REAL',
              title: 'Menos planilhas. Mais clareza.',
              subtitle: 'O Spendly reúne o essencial para você sair do modo reativo e assumir o controle do seu dinheiro.',
            ),
            const SizedBox(height: 52),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 980
                    ? 3
                    : constraints.maxWidth >= 620
                    ? 2
                    : 1;
                const gap = 16.0;
                final width =
                    (constraints.maxWidth - (gap * (columns - 1))) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final feature in _features)
                      SizedBox(
                        width: width,
                        child: _FeatureCard(item: feature, isDark: isDark),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 26),
            Text(
              'E ainda: conversão de moedas, alertas de vencimento e relatório financeiro mensal em PDF.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem {
  const _FeatureItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String text;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.item, required this.isDark});

  final _FeatureItem item;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceHigh : Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF15233A).withValues(alpha: .045),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: .11),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(item.icon, color: item.color, size: 26),
            ),
            const SizedBox(height: 26),
            Text(
              item.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -.45,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.52,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductStorySection extends StatelessWidget {
  const _ProductStorySection({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = Semantics(
      image: true,
      label: 'Tela do Spendly com indicadores de receitas, despesas e meta de economia.',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? .26 : .10),
              blurRadius: 38,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: const AspectRatio(
          aspectRatio: 1672 / 941,
          child: Image(
            image: AssetImage(
              'assets/images/spendly-landing/spendly-editorial-features-16x9.png',
            ),
            fit: BoxFit.cover,
            excludeFromSemantics: true,
          ),
        ),
      ),
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Eyebrow(
          icon: Icons.visibility_rounded,
          text: 'VISÃO COMPLETA, SEM RUÍDO',
        ),
        const SizedBox(height: 24),
        Text(
          'Tudo o que importa, no momento certo.',
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: 40,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Os números deixam de ser uma lista e passam a contar uma história: o que entrou, para onde foi e quanto falta para chegar ao próximo objetivo.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 26),
        const _ProductBullet(
          icon: Icons.bolt_rounded,
          title: 'Leitura rápida',
          text: 'Indicadores claros e comparações que ajudam você a agir.',
        ),
        const SizedBox(height: 18),
        const _ProductBullet(
          icon: Icons.notifications_active_outlined,
          title: 'Acompanhamento proativo',
          text:
              'Alertas de orçamento, cobrança e vencimento antes da surpresa.',
        ),
        const SizedBox(height: 18),
        const _ProductBullet(
          icon: Icons.lock_outline_rounded,
          title: 'Privacidade por padrão',
          text: 'Sessão protegida e recursos financeiros isolados por usuário.',
        ),
      ],
    );

    return _SectionFrame(
      verticalPadding: 112,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 880) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [image, const SizedBox(height: 48), copy],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 12, child: image),
              const SizedBox(width: 64),
              Expanded(flex: 9, child: copy),
            ],
          );
        },
      ),
    );
  }
}

class _ProductBullet extends StatelessWidget {
  const _ProductBullet({
    required this.icon,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.green, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArchitectureSection extends StatelessWidget {
  const _ArchitectureSection({super.key});

  static const _technologies = [
    'Flutter',
    'Dart',
    'Material 3',
    'HTTP REST',
    'FastAPI',
    'Python',
    'PostgreSQL',
    'SQLAlchemy',
    'Alembic',
    'JWT',
    'Secure Storage',
    'Docker',
    'Render',
    'Neon',
    'Pytest',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _SpendlyProjectPageState._midnight,
      child: _SectionFrame(
        verticalPadding: 112,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: .30),
                ),
              ),
              child: const Text(
                'ENGENHARIA QUE SUSTENTA A EXPERIÊNCIA',
                style: TextStyle(
                  color: Color(0xFF79A8FF),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .8,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: const Text(
                'Uma base moderna, segura e pronta para crescer.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  height: 1.08,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.7,
                ),
              ),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                'O cliente Flutter conversa com uma API REST em FastAPI, com autenticação JWT e persistência PostgreSQL. No front, a organização feature-first mantém telas e responsabilidades fáceis de evoluir.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .68),
                  fontSize: 17,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 50),
            const _ArchitectureFlow(),
            const SizedBox(height: 50),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 880 ? 3 : 1;
                const gap = 16.0;
                final width = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - gap * 2) / 3;
                const cards = [
                  _EngineeringCard(
                    icon: Icons.account_tree_rounded,
                    color: AppColors.primary,
                    title: 'Organização feature-first',
                    text: 'Módulos por funcionalidade, componentes compartilhados em core e contratos de API centralizados.',
                  ),
                  _EngineeringCard(
                    icon: Icons.shield_outlined,
                    color: AppColors.green,
                    title: 'Segurança de sessão',
                    text: 'JWT, armazenamento seguro do token e dados financeiros sempre vinculados ao proprietário.',
                  ),
                  _EngineeringCard(
                    icon: Icons.cloud_done_outlined,
                    color: AppColors.purple,
                    title: 'Entrega multiplataforma',
                    text: 'Uma base Flutter para mobile, web e desktop, apoiada por backend containerizado e testado.',
                  ),
                ];
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final card in cards)
                      SizedBox(width: width, child: card),
                  ],
                );
              },
            ),
            const SizedBox(height: 44),
            Text(
              'Tecnologias e serviços',
              style: TextStyle(
                color: Colors.white.withValues(alpha: .55),
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.05,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                for (final technology in _technologies)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .055),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .10),
                      ),
                    ),
                    child: Text(
                      technology,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArchitectureFlow extends StatelessWidget {
  const _ArchitectureFlow();

  static const _nodes = [
    _ArchitectureNode(
      icon: Icons.devices_rounded,
      label: 'Flutter',
      caption: 'App e web',
      color: AppColors.cyan,
    ),
    _ArchitectureNode(
      icon: Icons.api_rounded,
      label: 'REST + JWT',
      caption: 'Contrato seguro',
      color: AppColors.primary,
    ),
    _ArchitectureNode(
      icon: Icons.bolt_rounded,
      label: 'FastAPI',
      caption: 'Regras e automações',
      color: AppColors.purple,
    ),
    _ArchitectureNode(
      icon: Icons.storage_rounded,
      label: 'PostgreSQL',
      caption: 'Dados persistidos',
      color: AppColors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final vertical = constraints.maxWidth < 720;
        if (vertical) {
          return Column(
            children: [
              for (var index = 0; index < _nodes.length; index++) ...[
                _ArchitectureNodeCard(node: _nodes[index]),
                if (index < _nodes.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: Colors.white.withValues(alpha: .35),
                    ),
                  ),
              ],
            ],
          );
        }
        return Row(
          children: [
            for (var index = 0; index < _nodes.length; index++) ...[
              Expanded(child: _ArchitectureNodeCard(node: _nodes[index])),
              if (index < _nodes.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white.withValues(alpha: .35),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _ArchitectureNode {
  const _ArchitectureNode({
    required this.icon,
    required this.label,
    required this.caption,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String caption;
  final Color color;
}

class _ArchitectureNodeCard extends StatelessWidget {
  const _ArchitectureNodeCard({required this.node});

  final _ArchitectureNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: .10)),
      ),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: node.color.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(node.icon, color: node.color, size: 23),
          ),
          const SizedBox(height: 14),
          Text(
            node.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            node.caption,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .52),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _EngineeringCard extends StatelessWidget {
  const _EngineeringCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111724),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .62),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _FinalCallToAction extends StatelessWidget {
  const _FinalCallToAction({required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _SpendlyProjectPageState._midnight,
      child: _SectionFrame(
        verticalPadding: 52,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFF246BFD), Color(0xFF3D7CF4), Color(0xFF26B990)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 720;
              final copy = Column(
                crossAxisAlignment: stacked
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sua vida financeira pode ser mais simples.',
                    textAlign: stacked ? TextAlign.center : TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Explore o Spendly e veja seus números com novos olhos.',
                    textAlign: stacked ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .82),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              );
              final button = FilledButton.icon(
                key: const ValueKey('landing-final-cta'),
                onPressed: onGetStarted,
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(
                  stacked ? 'Começar agora' : 'Começar gratuitamente',
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 58),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.ink,
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              );
              if (stacked) {
                return Column(
                  children: [copy, const SizedBox(height: 28), button],
                );
              }
              return Row(
                children: [
                  Expanded(child: copy),
                  const SizedBox(width: 36),
                  button,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LandingFooter extends StatelessWidget {
  const _LandingFooter({
    required this.onFeatures,
    required this.onArchitecture,
    required this.onEmail,
    required this.onGitHub,
  });

  final VoidCallback onFeatures;
  final VoidCallback onArchitecture;
  final VoidCallback onEmail;
  final VoidCallback onGitHub;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _SpendlyProjectPageState._midnight,
      child: _SectionFrame(
        verticalPadding: 34,
        child: Column(
          children: [
            Divider(color: Colors.white.withValues(alpha: .09)),
            const SizedBox(height: 28),
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 720;
                final brand = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SpendlyMark(size: 38, withShadow: false),
                    const SizedBox(width: 10),
                    const Text(
                      'Spendly',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -.6,
                      ),
                    ),
                  ],
                );
                final links = Wrap(
                  alignment: stacked ? WrapAlignment.center : WrapAlignment.end,
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    _FooterLink(label: 'Recursos', onPressed: onFeatures),
                    _FooterLink(label: 'Tecnologia', onPressed: onArchitecture),
                    _FooterLink(label: 'GitHub', onPressed: onGitHub),
                    _FooterLink(label: 'Contato', onPressed: onEmail),
                  ],
                );
                if (stacked) {
                  return Column(
                    children: [brand, const SizedBox(height: 22), links],
                  );
                }
                return Row(children: [brand, const Spacer(), links]);
              },
            ),
            const SizedBox(height: 28),
            Text(
              '© ${DateTime.now().year} Spendly. Controle financeiro com clareza.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: .45),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white.withValues(alpha: .76),
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 13),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          eyebrow,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.05,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: 44,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.6,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 660),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({required this.child, required this.verticalPadding});

  final Widget child;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: _SpendlyProjectPageState._contentWidth,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width < 720 ? 20 : 30,
            vertical: width < 720 ? verticalPadding * .72 : verticalPadding,
          ),
          child: child,
        ),
      ),
    );
  }
}

abstract final class AppColors {
  static const primary = Color(0xFF3D7CF4);
  static const primaryDark = Color(0xFF2563EB);
  static const cyan = Color(0xFF18B8D9);
  static const green = Color(0xFF2CCB8C);
  static const amber = Color(0xFFFFAE35);
  static const pink = Color(0xFFE94F91);
  static const purple = Color(0xFF886BFF);
  static const danger = Color(0xFFFF5F6D);

  static const darkBackground = Color(0xFF080A0F);
  static const darkSurface = Color(0xFF11141B);
  static const darkSurfaceHigh = Color(0xFF181C25);
  static const darkBorder = Color(0xFF222734);

  static const lightBackground = Color(0xFFF4F6FA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceHigh = Color(0xFFEFF2F8);
  static const lightBorder = Color(0xFFE2E7F0);
  static const ink = Color(0xFF111827);
}

abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: AppColors.primary,
      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      error: AppColors.danger,
    );
    final textColor = isDark ? Colors.white : AppColors.ink;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      textTheme: ThemeData(brightness: brightness).textTheme
          .apply(bodyColor: textColor, displayColor: textColor),
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      dividerColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        indicatorColor: AppColors.primary.withValues(alpha: .16),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppColors.darkSurfaceHigh
            : AppColors.lightSurfaceHigh,
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? Colors.white : AppColors.ink,
        contentTextStyle: TextStyle(
          color: isDark ? AppColors.ink : Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class SpendlyMark extends StatelessWidget {
  const SpendlyMark({this.size = 68, this.withShadow = true, super.key});

  final double size;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size * .28);

    return Semantics(
      image: true,
      label: 'Logo Spendly',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: withShadow
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: .24),
                    blurRadius: size * .32,
                    offset: Offset(0, size * .14),
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          'assets/images/spendly-landing/spendly-app-icon.png',
          fit: BoxFit.cover,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
