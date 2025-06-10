# IP Master

**IP Master** é um jogo educativo desenvolvido em Flutter que ajuda os utilizadores a aprenderem e testarem os seus conhecimentos sobre **endereçamento IPv4**, incluindo conceitos como Network ID, Broadcast e sub-redes.

## 🎯 Objetivos do Projeto

- Ensinar conceitos fundamentais de redes de computadores através da prática.
- Gerar perguntas automáticas com três níveis de dificuldade.
- Registar e autenticar utilizadores localmente com SQLite.
- Acompanhar pontuação e mostrar o ranking dos melhores jogadores.

## 🧱 Funcionalidades

- **Registo e Login de Utilizadores** (armazenados localmente com SQLite)
- **Validação de e-mail e password**
- **Pontuação associada ao utilizador**
- **Criação de perguntas automáticas por nível:**
  - Nível 1: IPv4 básico (/8, /16, /24)
  - Nível 2: Sub-redes
  - Nível 3: Super-redes
- **Feedback imediato após cada resposta**
- **Ranking dos 5 melhores scores**
- **Dashboard do utilizador com nome, e-mail e pontuação**
- **Botão de Logout**

## 🧪 Tecnologias Usadas

- **Flutter** (Dart)
- **SQLite** (via `sqflite`)
- **Validação com `email_validator`**

## 🚀 Como correr o projeto

1. Clona o repositório:
   ```bash
   git clone https://github.com/teu-utilizador/ip-master.git
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

## 📁 Estrutura atual do Projeto

```
lib/
├── views/              # Login, Registo, Dashboard
├── models/             # Modelo User
├── helpers/            # Acesso a base de dados SQLite
├── main.dart           # Entrada principal da aplicação
assets/
└── images/             # Logo
```

## 📌 Estado atual

✅ Login e registo funcionais  
✅ Base de dados local criada com sucesso  
🚧 Modo de jogo em desenvolvimento  
🚧 Ranking dinâmico por pontuação

## 🧑‍💻 Autores

- Gabriel Ferreira
- [Colaborador X, se aplicável]

## 📄 Licença

Este projeto é de uso académico. Pode ser adaptado e reutilizado com os devidos créditos.
