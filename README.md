# João Schiavoni — Flutter Portfolio

Portfólio responsivo em português e inglês. Flutter com localização ARB, foto, currículo, carrossel contínuo, animações com suporte a movimento reduzido, navegação e contato via WhatsApp.

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
- MoveUp e Spendly: projetos completos exibidos com informações e materiais fornecidos pelo autor.
- Os cards e as páginas de projeto usam apresentações visuais oficiais armazenadas em `assets/images/`.
- Formulário valida nome, e-mail opcional e mensagem, abrindo o WhatsApp com os dados preenchidos para revisão antes do envio.
- Currículo abre o PDF no navegador, que permite salvar o arquivo.

A publicação web é feita pela Vercel a partir da branch principal.
