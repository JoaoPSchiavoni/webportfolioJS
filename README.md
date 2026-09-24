# João Schiavoni — Flutter Portfolio

Portfólio responsivo em português e inglês. Flutter com localização ARB, foto, currículo, carrossel contínuo, animações com suporte a movimento reduzido, navegação e formulário via aplicativo de e-mail.

## Executar

```powershell
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

## Validar e compilar

```powershell
flutter analyze
flutter test
flutter build web --release
```

Publique o conteúdo de `build/web` em um servidor estático HTTPS. Para subdiretórios, use `flutter build web --base-href /nome/`.

## Conteúdo

- Traduções: `lib/l10n/app_pt.arb` e `app_en.arb`.
- Componentes e layout: `lib/app.dart`.
- Retrato: `assets/images/joao.png`.
- Currículo original, em português: `assets/documents/curriculo_joao.pdf`.
- Agendai Fisio e ExpenseTracker: informações fornecidas pelo autor e currículo.
- CloudTask API e AI Document API: conceitos explicitamente identificados; sem métricas ou links inventados.
- Os painéis dos projetos são ilustrações, não screenshots dos produtos.
- Formulário valida os campos e prepara `mailto:`; exige aplicativo de e-mail configurado e não transmite dados para um servidor.
- Currículo abre o PDF no navegador, que permite salvar o arquivo.

Não houve publicação automática. Adicione URLs reais dos repositórios e screenshots quando disponíveis.
