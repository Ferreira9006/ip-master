# IP Master

**IP Master** é uma aplicação educativa desenvolvida em **Flutter** que permite aprender e praticar conceitos essenciais de redes de computadores, focando-se no **endereçamento IPv4**, incluindo Network ID, Broadcast, sub-redes e super-redes.

---

## 🎯 Objetivos do Projeto

- Ensinar os conceitos de IPv4 através de gamificação.
- Gerar perguntas dinâmicas por nível de dificuldade.
- Registar e autenticar utilizadores localmente com SQLite.
- Guardar pontuação e apresentar rankings competitivos.
- Tornar a experiência visual moderna, responsiva e acessível.

---

## 🧱 Funcionalidades

- **Login, Registo e Logout de Utilizadores**
- **Autenticação local via SQLite**
- **Validação de e-mail e password**
- **Dashboard com dados pessoais e pontuações por nível**
- **Sistema de perguntas automáticas por nível:**
  - Nível 1: IPv4 básico (/8, /16, /24)
  - Nível 2: Sub-redes comuns (/25, /26, /27, /28)
  - Nível 3: Super-redes (/19, /20, /21, /22)
- **Pontuação por pergunta e sessão**
- **Feedback visual imediato após cada resposta**
- **Ranking Top 5 por dificuldade**
- **Leaderboard acessível com e sem login**
- **Interface moderna, com animações e tema personalizável**
- **Splash Screen com animações**
- **Separação modular em widgets reutilizáveis**

---

## 🧪 Tecnologias Usadas

- [x] **Flutter (Dart)**
- [x] **SQLite** (via `sqflite`)
- [x] **Email Validator**
- [x] **Google Fonts**
- [x] **flutter_animate**
- [x] **Material 3 e theming adaptável**

---

## 🚀 Como correr o projeto

1. Clona o repositório:

   ```bash
   git clone https://github.com/o-teu-utilizador/ip-master.git
   cd ip-master
   ```

2. Instala as dependências:

   ```bash
   flutter pub get
   ```

3. Corre a aplicação:

   ```bash
   flutter run
   ```

---

## 📁 Estrutura do Projeto

```
lib/
├── core/
│   ├── theme.dart               # Tema global
│   ├── app_constants.dart       # Constantes do projeto
│   └── database_helper.dart     # Ligação à base de dados SQLite
│
├── modules/
│   ├── auth/                    # Registo, Login, Modelos
│   │   ├── data/                # Lógica de base de dados (users)
│   │   ├── models/              # Modelo User
│   │   └── views/               # Ecrãs de login e registo
│
│   ├── dashboard/               # Painel do utilizador e Leaderboard
│   │   └── views/
│
│   ├── quiz/                    # Lógica do jogo
│   │   ├── models/              # Modelo Question
│   │   ├── utils/               # Funções auxiliares (geração de perguntas)
│   │   └── views/               # Ecrã do jogo
│
│   └── ranking/                 # Dados e visualização do ranking
│       ├── data/
│       ├── models/
│       └── views/
│
├── views/
│   └── main.dart                # Ponto de entrada da aplicação
```

---

## 📌 Estado Atual

✅ Splash Screen animado  
✅ Login/Registo funcionais  
✅ Dashboard funcional com pontuação  
✅ Geração de perguntas aleatórias por nível  
✅ Feedback visual e pontuação por resposta  
✅ Ranking funcional com persistência local  
✅ Leaderboard acessível sem login  
✅ Estilo moderno e responsivo
