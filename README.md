# 📱 Flutter Contact App

Aplicativo mobile de gerenciamento de contatos, utilizando Flutter no frontend e Node.js/Express no backend.

---

## ✅ Funcionalidades

- Criar novos contatos com nome, email e telefone
- Listar contatos existentes
- Pesquisar contatos por nome com debounce
- Editar contatos
- Deletar contatos
- Exibe loading durante requisições
- Mensagens de erro e feedback ao usuário
- Mensagem de "Nenhum contato encontrado" quando aplicável

---

## 🧱 Arquitetura

- Flutter com **Provider**, **GetIt** (Injeção de dependência), **Dio** (requisições HTTP)
- Backend em **Node.js + Express** com rotas REST
- Estrutura em camadas (model, repository, service, UI)

---

## 🚀 Como rodar

1. Vá para a pasta `flutter_contact_app`
2. Instale as dependências:

```bash
flutter pub get
```

3. Rode o app:

```bash
flutter run
```

> Certifique-se de que o emulador ou dispositivo esteja rodando e que o backend esteja ativo no `localhost`.

> ⚠️ Se estiver rodando em dispositivo físico ou emulador Android, troque `localhost` pelo IP local da sua máquina no `contact_repository.dart`.

---

## 🛠 Build APK

Para gerar o APK de testes:

```bash
flutter build apk --release
```

O arquivo será gerado em:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🧪 Testes

- Estrutura pronta para testes unitários e de widget.
- Exemplo: validações, chamadas HTTP, atualização de estado via Provider.

---

## 📂 Estrutura de Pastas (Frontend)

```
lib/
├── core/di/
├── data/models/
├── data/repositories/
├── domain/usecases/
├── presentation/
│   ├── providers/
│   ├── screens/
│   └── routes.dart
├── app.dart
└── main.dart
```

---

## ✍️ Autor

Feito por Jhonata Carvalho
📧 jhonatacbarros@gmail.com
