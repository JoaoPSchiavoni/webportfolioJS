import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @home.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get home;

  /// No description provided for @about.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get about;

  /// No description provided for @technologies.
  ///
  /// In pt, this message translates to:
  /// **'Tecnologias'**
  String get technologies;

  /// No description provided for @projects.
  ///
  /// In pt, this message translates to:
  /// **'Projetos'**
  String get projects;

  /// No description provided for @contact.
  ///
  /// In pt, this message translates to:
  /// **'Contato'**
  String get contact;

  /// No description provided for @menu.
  ///
  /// In pt, this message translates to:
  /// **'Menu de navegação'**
  String get menu;

  /// No description provided for @heroLabel.
  ///
  /// In pt, this message translates to:
  /// **'Software com propósito'**
  String get heroLabel;

  /// No description provided for @hello.
  ///
  /// In pt, this message translates to:
  /// **'Olá, eu sou'**
  String get hello;

  /// No description provided for @heroDescription.
  ///
  /// In pt, this message translates to:
  /// **'Construindo sistemas robustos, escaláveis e bem estruturados. Do primeiro endpoint à arquitetura da solução.'**
  String get heroDescription;

  /// No description provided for @seeProjects.
  ///
  /// In pt, this message translates to:
  /// **'Ver projetos'**
  String get seeProjects;

  /// No description provided for @resume.
  ///
  /// In pt, this message translates to:
  /// **'Baixar currículo'**
  String get resume;

  /// No description provided for @techLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tecnologias que fazem parte da minha jornada'**
  String get techLabel;

  /// No description provided for @aboutTitle.
  ///
  /// In pt, this message translates to:
  /// **'Além do código.\nUma visão do todo.'**
  String get aboutTitle;

  /// No description provided for @aboutBody.
  ///
  /// In pt, this message translates to:
  /// **'Olá, sou o João Pedro Schiavoni Sarilho, um desenvolvedor de software com foco em backend e apaixonado por construir sistemas robustos, escaláveis e bem estruturados. Atualmente, curso Análise e Desenvolvimento de Sistemas na UNIP e concentro meu trabalho no ecossistema .NET e em Python.\n\nAcredito que um bom software vai além de fazer o código funcionar. Tenho um forte interesse em engenharia e arquitetura de software, aplicando ativamente princípios como Clean Architecture e SOLID para garantir aplicações de fácil manutenção. Essa visão técnica me permitiu atuar como Tech Lead em projetos como o Agendai Fisio, onde fui responsável por definir a arquitetura do sistema, modelar o banco de dados e coordenar as entregas da equipe de desenvolvimento, integrando nosso backend com interfaces em Flutter.\n\nAlém da parte técnica, valorizo muito a comunicação e a visão global. Realizei um intercâmbio de um ano em Dublin, na Irlanda, o que consolidou minha fluência no inglês e me preparou para atuar em ambientes multiculturais.\n\nEstou sempre buscando o próximo nível técnico, seja explorando integrações com Inteligência Artificial, estudando para certificações como a Microsoft Azure AI Fundamentals ou lendo referências do setor. Meu objetivo é continuar evoluindo na área de Arquitetura de Software e entregar soluções que realmente façam a diferença.'**
  String get aboutBody;

  /// No description provided for @education.
  ///
  /// In pt, this message translates to:
  /// **'UNIP · Análise e Desenvolvimento de Sistemas\nConclusão prevista em 2027\nDublin, Irlanda · 1 ano de intercâmbio'**
  String get education;

  /// No description provided for @projectsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ideias que ganham estrutura.'**
  String get projectsTitle;

  /// No description provided for @projectsIntro.
  ///
  /// In pt, this message translates to:
  /// **'Uma seleção de projetos e conceitos que traduzem minha forma de pensar software.'**
  String get projectsIntro;

  /// No description provided for @fisio.
  ///
  /// In pt, this message translates to:
  /// **'Plataforma de gestão e agendamento clínico. Atuação como Tech Lead de uma equipe de 8 pessoas, definindo arquitetura, modelo de dados e padrões de qualidade. Interface em migração para Flutter.'**
  String get fisio;

  /// No description provided for @expense.
  ///
  /// In pt, this message translates to:
  /// **'Aplicação pessoal de controle e análise de finanças, com Flutter, FastAPI e PostgreSQL. Desenvolvimento solo com foco em persistência, tipagem estrita, modularização e arquitetura limpa.'**
  String get expense;

  /// No description provided for @cloud.
  ///
  /// In pt, this message translates to:
  /// **'Conceito de API para orquestração de tarefas assíncronas, com filas, retentativas e observabilidade. Proposta de arquitetura modular preparada para execução em containers.'**
  String get cloud;

  /// No description provided for @ai.
  ///
  /// In pt, this message translates to:
  /// **'Conceito de serviço para extração e consulta de informações em documentos. Proposta de integração com Azure AI, processamento assíncrono e respostas rastreáveis.'**
  String get ai;

  /// No description provided for @realProject.
  ///
  /// In pt, this message translates to:
  /// **'Projeto integrador · UNIP'**
  String get realProject;

  /// No description provided for @personalProject.
  ///
  /// In pt, this message translates to:
  /// **'Projeto pessoal'**
  String get personalProject;

  /// No description provided for @concept.
  ///
  /// In pt, this message translates to:
  /// **'Conceito · demonstração'**
  String get concept;

  /// No description provided for @projectVisual.
  ///
  /// In pt, this message translates to:
  /// **'Ilustração conceitual do projeto'**
  String get projectVisual;

  /// No description provided for @details.
  ///
  /// In pt, this message translates to:
  /// **'Explorar projeto'**
  String get details;

  /// No description provided for @close.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// No description provided for @realDetail.
  ///
  /// In pt, this message translates to:
  /// **'Descrição baseada no currículo. Os links específicos de código e demonstração serão adicionados quando estiverem disponíveis.'**
  String get realDetail;

  /// No description provided for @conceptDetail.
  ///
  /// In pt, this message translates to:
  /// **'Este projeto é uma proposta de portfólio. Não representa um produto entregue, experiência profissional ou resultados medidos.'**
  String get conceptDetail;

  /// No description provided for @contactTitle.
  ///
  /// In pt, this message translates to:
  /// **'Vamos construir\nalgo juntos?'**
  String get contactTitle;

  /// No description provided for @contactBody.
  ///
  /// In pt, this message translates to:
  /// **'Tem uma oportunidade, um projeto ou uma boa ideia? Vamos conversar sobre o próximo passo.'**
  String get contactBody;

  /// No description provided for @name.
  ///
  /// In pt, this message translates to:
  /// **'Seu nome'**
  String get name;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'Seu e-mail'**
  String get email;

  /// No description provided for @message.
  ///
  /// In pt, this message translates to:
  /// **'O que você tem em mente?'**
  String get message;

  /// No description provided for @send.
  ///
  /// In pt, this message translates to:
  /// **'Preparar e-mail'**
  String get send;

  /// No description provided for @mailHint.
  ///
  /// In pt, this message translates to:
  /// **'Abre seu aplicativo de e-mail para revisar e enviar a mensagem.'**
  String get mailHint;

  /// No description provided for @mailSubject.
  ///
  /// In pt, this message translates to:
  /// **'Contato pelo portfólio'**
  String get mailSubject;

  /// No description provided for @requiredField.
  ///
  /// In pt, this message translates to:
  /// **'Preencha este campo.'**
  String get requiredField;

  /// No description provided for @invalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'Informe um e-mail válido.'**
  String get invalidEmail;

  /// No description provided for @linkError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível abrir o link. Entre em contato: joaopschiavoni@gmail.com'**
  String get linkError;

  /// No description provided for @footer.
  ///
  /// In pt, this message translates to:
  /// **'Feito com Flutter. Pensado nos detalhes.'**
  String get footer;

  /// No description provided for @motionPaused.
  ///
  /// In pt, this message translates to:
  /// **'Animações pausadas · movimento reduzido'**
  String get motionPaused;

  /// No description provided for @enableMotion.
  ///
  /// In pt, this message translates to:
  /// **'Ativar animações'**
  String get enableMotion;

  /// No description provided for @pauseMotion.
  ///
  /// In pt, this message translates to:
  /// **'Pausar animações'**
  String get pauseMotion;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
