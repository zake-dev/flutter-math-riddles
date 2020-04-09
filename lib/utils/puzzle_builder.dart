import 'dart:math';

const PUZZLE_COUNT = 300;

Future<Map<String, dynamic>> getRandomPuzzle() async {
  final puzzleNumber = Random().nextInt(PUZZLE_COUNT) + 1;
  print('Puzzle No.$puzzleNumber selected.');
  Map puzzle;

  if (puzzleNumber <= 20)
    puzzle = await oneLineAdd();
  else if (puzzleNumber <= 40)
    puzzle = await oneLineSub();
  else if (puzzleNumber <= 52)
    puzzle = await oneLinePositiveMultiply();
  else if (puzzleNumber <= 60)
    puzzle = await oneLineNegativeMultiply();
  else if (puzzleNumber <= 75)
    puzzle = await oneLineDoubleAdd();
  else if (puzzleNumber <= 90)
    puzzle = await oneLineTripleAdd();
  else if (puzzleNumber <= 100)
    puzzle = await multiLineAdd();
  else if (puzzleNumber <= 110)
    puzzle = await multiLineSub();
  else if (puzzleNumber <= 125)
    puzzle = await multiLineDoubleAdd();
  else if (puzzleNumber <= 140)
    puzzle = await multiLineTripleAdd();
  else if (puzzleNumber <= 170)
    puzzle = await multiLineEquationHard();
  else if (puzzleNumber <= 200)
    puzzle = await multiLineEquationEasy();
  else if (puzzleNumber <= 240)
    puzzle = await triangleAddSub();
  else if (puzzleNumber <= 260)
    puzzle = await triangleMultiply();
  else if (puzzleNumber <= 280)
    puzzle = await triangleDoubleAdd();
  else if (puzzleNumber <= 300) puzzle = await triangleTripleAdd();

  return puzzle;
}

Future<Map<String, dynamic>> oneLineAdd() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'add';
  puzzle['point'] = random.nextInt(2) + 1;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(16);
  final funcNumber = random.nextInt(16);
  final ops = '+';
  int func(x, y) => (x + y);

  // Generate
  List numbers = [initialNumber];
  for (var i = 0; i < 3; i++) {
    int next = func(initialNumber, funcNumber);
    numbers.add(next);
    puzzle['workout'].add('$initialNumber $ops $funcNumber = $next');
    initialNumber = next;
  }
  puzzle['puzzle'] =
      numbers.take(3).map((n) => n.toString()).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';
  return puzzle;
}

Future<Map<String, dynamic>> oneLineSub() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'subtract';
  puzzle['point'] = random.nextInt(2) + 1;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(56) + 45;
  final funcNumber = random.nextInt(15) + 1;
  final ops = '-';
  int func(x, y) => (x - y);

  // Generate
  List numbers = [initialNumber];
  for (var i = 0; i < 3; i++) {
    int next = func(initialNumber, funcNumber);
    numbers.add(next);
    puzzle['workout'].add('$initialNumber $ops $funcNumber = $next');
    initialNumber = next;
  }
  puzzle['puzzle'] =
      numbers.take(3).map((n) => n.toString()).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';
  return puzzle;
}

Future<Map<String, dynamic>> oneLinePositiveMultiply() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'multiply';
  puzzle['point'] = random.nextInt(2) + 2;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(10) + 1;
  final funcNumber = random.nextInt(5) + 1;
  final ops = 'x';
  int func(x, y) => (x * y);

  // Generate
  List numbers = [initialNumber];
  for (var i = 0; i < 3; i++) {
    int next = func(initialNumber, funcNumber);
    numbers.add(next);
    puzzle['workout'].add('$initialNumber $ops $funcNumber = $next');
    initialNumber = next;
  }
  puzzle['puzzle'] =
      numbers.take(3).map((n) => n.toString()).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';
  return puzzle;
}

Future<Map<String, dynamic>> oneLineNegativeMultiply() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'multiply';
  puzzle['point'] = random.nextInt(2) + 2;
  puzzle['workout'] = [];

  int initialNumber = -(random.nextInt(10) + 1);
  final funcNumber = -(random.nextInt(5) + 1);
  final ops = 'x';
  int func(x, y) => (x * y);

  // Generate
  List numbers = [initialNumber];
  for (var i = 0; i < 3; i++) {
    int next = func(initialNumber, funcNumber);
    numbers.add(next);
    puzzle['workout'].add('$initialNumber $ops $funcNumber = $next');
    initialNumber = next;
  }
  puzzle['puzzle'] =
      numbers.take(3).map((n) => n.toString()).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';
  return puzzle;
}

Future<Map<String, dynamic>> oneLineDoubleAdd() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'x2 and ...';
  puzzle['point'] = random.nextInt(3) + 2;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(8) + 3;
  final funcNumber = (random.nextInt(100) > 50)
      ? random.nextInt(4) + 1
      : -(random.nextInt(4) + 1);
  int func(x, y) => ((x * 2) + y);

  // Generate
  List numbers = [initialNumber];
  for (var i = 0; i < 3; i++) {
    int next = func(initialNumber, funcNumber);
    numbers.add(next);
    puzzle['workout'].add(
        '($initialNumber x 2) ${(funcNumber < 0) ? '-' : '+'} ${funcNumber.abs()} = $next');
    initialNumber = next;
  }
  puzzle['puzzle'] =
      numbers.take(3).map((n) => n.toString()).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';
  return puzzle;
}

Future<Map<String, dynamic>> oneLineTripleAdd() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'x3 and ...';
  puzzle['point'] = random.nextInt(3) + 3;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(6) + 3;
  final funcNumber = (random.nextInt(100) > 50)
      ? random.nextInt(8) + 1
      : -(random.nextInt(8) + 1);
  int func(x, y) => ((x * 3) + y);

  // Generate
  List numbers = [initialNumber];
  for (var i = 0; i < 3; i++) {
    int next = func(initialNumber, funcNumber);
    numbers.add(next);
    puzzle['workout'].add(
        '($initialNumber x 3) ${(funcNumber < 0) ? '-' : '+'} ${funcNumber.abs()} = $next');
    initialNumber = next;
  }
  puzzle['puzzle'] =
      numbers.take(3).map((n) => n.toString()).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';
  return puzzle;
}

Future<Map<String, dynamic>> multiLineAdd() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 2;
  puzzle['hint'] = 'add';
  int func(x, y) => (x + y);
  final ops = '+';

  // Generate random numbers
  List numbers = [];
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(50) + 1, random.nextInt(50) + 1]);

  // Build Puzzle
  List newPuzzle = [];
  for (final pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add('$a, $b = $answer');
    puzzle['workout'].add('$a $ops $b = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineSub() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 2;
  puzzle['hint'] = 'subtract';
  int func(x, y) => (x - y);
  final ops = '-';

  // Generate random numbers
  List numbers = [];
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(50) + 25, random.nextInt(25) + 1]);

  // Build Puzzle
  List newPuzzle = [];
  for (final pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add('$a, $b = $answer');
    puzzle['workout'].add('$a $ops $b = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineDoubleAdd() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(3) + 3;
  puzzle['hint'] = 'x2 and ...';
  int func(x, y) => (2 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(50) + 25, flag * (random.nextInt(25) + 1)]);

  // Build Puzzle
  List newPuzzle = [];
  for (final pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add('$a, ${b.abs()} = $answer');
    puzzle['workout']
        .add('($a x 2) ${(b < 0) ? '-' : '+'} ${b.abs()} = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineTripleAdd() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(4) + 4;
  puzzle['hint'] = 'x3 and ...';
  int func(x, y) => (3 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(30) + 15, flag * (random.nextInt(30) + 1)]);

  // Build Puzzle
  List newPuzzle = [];
  for (final pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add('$a, ${b.abs()} = $answer');
    puzzle['workout']
        .add('($a x 3) ${(b < 0) ? '-' : '+'} ${b.abs()} = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineEquationHard() async {
  final sampleMarks = ['◉', '◆', '◇', '▲', '△', '▣', '□', '◈'];
  sampleMarks.shuffle();
  final marks = sampleMarks.take(3).toList();

  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': []
  };

  // Puzzle Setting
  final List<int> answers =
      (List.generate(10, (i) => i + 1)..shuffle()).take(3).toList();
  final x = answers[0];
  final y = answers[1];
  final z = answers[2];

  puzzle['answer'] = '${x + z}';
  puzzle['point'] = Random().nextInt(4) + 6;
  puzzle['hint'] = 'Find ${marks[1]} first';

  // Generate
  List<String> lines = [];
  final List<int> numbers =
      (List.generate(6, (i) => i + 1)..shuffle()).take(5).toList();
  final a = numbers[0];
  final b = numbers[1];
  final c = numbers[2];
  final d = numbers[3];
  final e = numbers[4];

  lines.add(
      '${(a > 1) ? a : ''}${marks[0]} + ${(b > 1) ? b : ''}${marks[1]} = ${a * x + b * y}');
  lines.add(
      '${(c > 1) ? c : ''}${marks[0]} + ${(b > 1) ? b : ''}${marks[1]} = ${c * x + b * y}');
  lines.add(
      '${(d > 1) ? d : ''}${marks[1]} + ${(e > 1) ? e : ''}${marks[2]} = ${d * y + e * z}');
  lines.shuffle();
  lines.add('${marks[0]} + ${marks[2]} = ?');

  puzzle['puzzle'] = lines;

  // Save workout
  puzzle['workout'].add('${marks[0]} = $x');
  puzzle['workout'].add('${marks[1]} = $y');
  puzzle['workout'].add('${marks[2]} = $z');
  puzzle['workout'].add('${marks[0]} + ${marks[2]} = ${x + z}');

  return puzzle;
}

Future<Map<String, dynamic>> multiLineEquationEasy() async {
  final sampleMarks = ['◉', '◆', '◇', '▲', '△', '▣', '□', '◈'];
  sampleMarks.shuffle();
  final marks = sampleMarks.take(3).toList();

  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': []
  };

  // Puzzle Setting
  final List<int> answers =
      (List.generate(10, (i) => i + 1)..shuffle()).take(3).toList();
  final x = answers[0];
  final y = answers[1];
  final z = answers[2];

  puzzle['answer'] = '${y + z}';
  puzzle['point'] = Random().nextInt(4) + 4;
  puzzle['hint'] = 'Find ${marks[0]} first';

  // Generate
  List<String> lines = [];
  final List<int> numbers =
      (List.generate(6, (i) => i + 1)..shuffle()).take(5).toList();
  final b = numbers[1];
  final c = numbers[2];
  final d = numbers[3];
  final e = numbers[4];

  lines.add('${marks[0]} + ${marks[0]} = ${2 * x}');
  lines.add(
      '${(c > 1) ? c : ''}${marks[0]} + ${(b > 1) ? b : ''}${marks[1]} = ${c * x + b * y}');
  lines.add(
      '${(d > 1) ? d : ''}${marks[1]} + ${(e > 1) ? e : ''}${marks[2]} = ${d * y + e * z}');
  lines.add('${marks[1]} + ${marks[2]} = ?');

  puzzle['puzzle'] = lines;

  // Save workout
  puzzle['workout'].add('${marks[0]} = $x');
  puzzle['workout'].add('${marks[1]} = $y');
  puzzle['workout'].add('${marks[2]} = $z');
  puzzle['workout'].add('${marks[1]} + ${marks[2]} = ${y + z}');

  return puzzle;
}

Future<Map<String, dynamic>> triangleAddSub() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': <List<dynamic>>[],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(3) + 1;
  puzzle['hint'] = 'sum or diffrence';
  int func(x, y) => (x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(71) + 30, flag * (random.nextInt(30) + 1)]);

  // Build Puzzle
  List<dynamic> newPuzzle = [];
  for (List<int> pair in numbers) {
    pair.shuffle();
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add([a, b, answer]);
    if (a < 0 || b < 0)
      puzzle['workout'].add('| ${a.abs()} - ${b.abs()} | = $answer');
    else
      puzzle['workout'].add('${a.abs()} + ${b.abs()} = $answer');
  }

  puzzle['answer'] = newPuzzle[3][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> triangleMultiply() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': <List<dynamic>>[],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(3) + 1;
  puzzle['hint'] = 'a x b';
  int func(x, y) => (x * y);

  // Generate random numbers
  List numbers = [];
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(14) + 2, random.nextInt(15) + 1]);

  // Build Puzzle
  List<dynamic> newPuzzle = [];
  for (List<int> pair in numbers) {
    pair.shuffle();
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add([a, b, answer]);
    puzzle['workout'].add('${a.abs()} x ${b.abs()} = $answer');
  }

  puzzle['answer'] = newPuzzle[3][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> triangleDoubleAdd() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': <List<dynamic>>[],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 5;
  puzzle['hint'] = 'x2 and ...';
  int func(x, y) => (2 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(45) + 16, flag * (random.nextInt(30) + 1)]);

  // Build Puzzle
  List<dynamic> newPuzzle = [];
  for (List<int> pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add([a, b, answer]);
    puzzle['workout']
        .add('(${a.abs()} x 2) ${(b < 0) ? '-' : '+'} ${b.abs()} = $answer');
  }

  puzzle['answer'] = newPuzzle[3][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> triangleTripleAdd() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': <List<dynamic>>[],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 6;
  puzzle['hint'] = 'x3 and ...';
  int func(x, y) => (3 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(30) + 11, flag * (random.nextInt(30) + 1)]);

  // Build Puzzle
  List<dynamic> newPuzzle = [];
  for (List<int> pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add([a, b, answer]);
    puzzle['workout']
        .add('(${a.abs()} x 3) ${(b < 0) ? '-' : '+'} ${b.abs()} = $answer');
  }

  puzzle['answer'] = newPuzzle[3][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}