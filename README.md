<<<<<<< HEAD
# ip-master
IPV4 Flutter Game
=======
# 🧮 IPMaster

**IPMaster** é uma aplicação Flutter simples, intuitiva e moderna que permite converter números entre diferentes sistemas de numeração: Binário, Octal, Decimal e Hexadecimal. Ideal para estudantes, programadores ou qualquer pessoa que necessite de converter valores rapidamente.

![IPMaster Logo](assets/images/logo.png)

---

## 🚀 Funcionalidades

- 🔄 Conversão entre bases: Converte entre Binário (2), Octal (8), Decimal (10) e Hexadecimal (16).
- ✅ Validação de entrada: Garante que os números inseridos são válidos para a base escolhida.
- 📝 Histórico de conversões: Registo automático das conversões realizadas.
- 💡 Interface moderna e responsiva: Layout limpo.
- 🧩 Componentes reutilizáveis: Código organizado e modular com `widgets`, `models` e `funções`.
- ♻️ Botão para limpar campos e histórico de forma imediata.
- ⏳ Ecrã inicial com logótipo (Splash Screen) com carregamento antes da entrada na app. *(opcional)*

---

## 📄 Como utilizar

1. Introduz um número no campo de texto.
2. Seleciona a base de origem e a base de destino através dos menus suspensos.
3. Clica no botão “Converter”.
4. Visualiza o resultado no cartão apresentado e consulta o histórico por baixo.

Para limpar os campos e o histórico, usa o ícone de “refresh” no canto superior direito da aplicação.

---

## 📂 Estrutura da Aplicação

- `SplashScreen` *(opcional)*: Mostra a imagem/logo da app durante alguns segundos.
- `ConverterView`: Ecrã principal com formulário de conversão e histórico.
- `functions.dart`: Contém a lógica de conversão e validação de valores.
- `conversion.dart`: Modelo de dados para representar uma conversão.
- `dropdown_button.dart`: Widget reutilizável para seleção de bases numéricas.
- `assets/images/logo.png`: Logótipo da aplicação.

---

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento multiplataforma.
- **Dart**: Linguagem utilizada para lógica e UI.
- **Material Design**: Sistema de design que garante uma experiência visual agradável.

---

## 🔧 Como correr o projeto

1. Clona este repositório:
   ```bash
   git clone https://github.com/o-teu-utilizador/IPMaster.git
   cd IPMaster
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

## 📌 Notas

- Apenas são aceites números válidos de acordo com a base selecionada.
- O histórico não é persistente — será limpo ao fechar ou reiniciar a app.

---

## ✨ Conclusão

Com o **IPMaster**, podes converter rapidamente números entre diferentes sistemas numéricos de forma simples e eficaz. Seja para fins académicos, profissionais ou apenas por curiosidade, esta aplicação oferece uma solução prática e agradável de usar.
>>>>>>> 52465ee (Primeiro commit)
"# ip-master" 
