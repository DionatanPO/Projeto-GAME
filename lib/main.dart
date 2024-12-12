import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importando Google Fonts
import 'package:shared_preferences/shared_preferences.dart'; // Importando SharedPreferences

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio das Cores',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.red,
                    Colors.green,
                    Colors.orange,
                    Colors.purple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Desafio das Cores',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Mantém branco como base
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Escolha a cor da palavra, não o significado!',
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GamePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size.fromHeight(50), // Altura fixa
                ),
                child: const Text(
                  'Iniciar Jogo',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.help_outline,
                    size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpPage()),
                  );
                },
              ),
              const Text(
                'Ajuda',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Como Jogar'),
        backgroundColor: Colors.white60,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título do objetivo do jogo
              Text(
                'Objetivo do Jogo:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'O Desafio das Cores é um jogo onde o objetivo é testar sua percepção visual e concentração. '
                'Você deve escolher a cor em que a palavra está escrita, ignorando o significado da palavra. '
                'Parece fácil, mas exige bastante foco e rapidez!',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // Exemplo do jogo
              Text(
                'Exemplo Prático:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Se a palavra "Vermelho" aparecer na cor azul, você deve escolher a cor azul, e não o significado da palavra.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // Explicação sobre o efeito Stroop
              Text(
                'Por que é desafiador?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'O cérebro tende a associar automaticamente as palavras ao seu significado. Esse fenômeno é chamado de "Efeito Stroop". O jogo desafia essa tendência, '
                'pois você precisa ignorar o significado da palavra e focar na cor em que ela está escrita, o que pode ser mais difícil do que parece.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // Dicas para o jogador
              Text(
                'Dicas para um bom desempenho:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '1. Concentre-se na cor do texto e ignore o significado da palavra.\n'
                '2. Responda rápido, mas cuidado com erros, pois isso pode diminuir sua pontuação.\n'
                '3. Mantenha a calma, especialmente nos níveis mais difíceis, onde o tempo é mais curto.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 40),

              // Botão de voltar ao início
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Voltar ao Início',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.lime
  ];

  final List<String> words = [
    'vermelho',
    'verde',
    'azul',
    'amarelo',
    'laranja',
    'roxo',
    'rosa',
    'ciano',
    'teal',
    'marrom',
    'indigo',
    'limão'
  ];

  String currentWord = '';
  Color currentColor = Colors.black;
  int score = 0;
  int wrongAnswers = 0;
  int timeLeft = 15;
  int currentLevel = 1;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    generateWord();
    startTimer();
  }

  void generateWord() {
    final random = Random();
    int wordIndex = random.nextInt(words.length);
    int colorIndex = random.nextInt(colors.length);

    setState(() {
      currentWord = words[wordIndex];
      currentColor = colors[colorIndex];
    });
  }

  void checkAnswer(Color selectedColor) {
    if (selectedColor == currentColor) {
      setState(() {
        score++;
        wrongAnswers = 0;
      });
    } else {
      setState(() {
        wrongAnswers++;
        score = max(0, score - 1);
      });
    }
    generateWord();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        if (currentLevel < 5) {
          setState(() {
            currentLevel++;
            timeLeft = 15 - currentLevel;
            if (timeLeft < 5) timeLeft = 5;
          });
          generateWord();
        } else {
          _timer.cancel();
          final prefs = await SharedPreferences.getInstance();
          int highScore = prefs.getInt('highScore') ?? 0;

          if (score > highScore) {
            await prefs.setInt('highScore', score);
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GameOverPage(
                score: score,
                highScore: prefs.getInt('highScore') ?? 0,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio das Cores'),
        centerTitle: true,
        backgroundColor: Colors.white60,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Palavra gerada
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 60,
                color: currentColor,
                fontWeight: FontWeight.bold,
              ),
              child: Text(currentWord),
            ),
            const SizedBox(height: 20),

            // Texto de Tempo Restante
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 28,
                color: timeLeft <= 5 ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              child: Text('Tempo restante: $timeLeft'),
            ),
            const SizedBox(height: 20),

            // Texto de Pontuação
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 28,
                color: score % 2 == 0 ? Colors.green : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              child: Text('Pontuação: $score'),
            ),
            const SizedBox(height: 20),

            // Texto de Nível
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 28,
                color: currentLevel <= 2 ? Colors.orange : Colors.purple,
                fontWeight: FontWeight.bold,
              ),
              child: Text('Nível: $currentLevel'),
            ),
            const SizedBox(height: 50),

            // Cores para seleção
            GridView.builder(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                Color color = colors[index];
                return GestureDetector(
                  onTap: () => checkAnswer(color),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: color,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GameOverPage extends StatelessWidget {
  final int score;
  final int highScore;

  const GameOverPage({
    super.key,
    required this.score,
    required this.highScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fim de Jogo'),
        backgroundColor: Colors.white60,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Parabéns!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Sua Pontuação: $score',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            Text(
              'Melhor Pontuação: $highScore',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Voltar ao Início',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
