import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

typedef CreatePuzzle();

final List<CreatePuzzle> easyPuzzle = [
  oneLineAdd,
  oneLineSub,
  oneLinePositiveMultiply,
  oneLineNegativeMultiply,
  multiLineAdd,
  multiLineSub,
  multiLineHideAddSub,
  multiLineHideMultiply,
  triangleAddSub,
  triangleMultiply,
  nineBoxes1,
  nineBoxes2,
  nineBoxes3,
  oneLineShift,
];
final List<CreatePuzzle> semiEasyPuzzle = [
  oneLineDoubleAdd,
  oneLineTripleAdd,
  multiLineDoubleAdd,
  multiLineTripleAdd,
  multiLineEquationEasy,
  triangleDoubleAdd,
  triangleTripleAdd,
  multiLineHideComplex2,
  multiLineComplex6,
  multiLineComplex7,
];
final List<CreatePuzzle> semiHardPuzzle = [
  multiLineComplex1,
  multiLineComplex2,
  multiLineComplex3,
  multiLineComplex5,
  multiLineComplex6,
  multiLineComplex7,
  triangleComplex1,
  triangleComplex2,
  oneLineComplex1,
  multiLineHideComplex1,
  multiLineHideComplex3,
];
final List<CreatePuzzle> hardPuzzle = [
  multiLineEquationHard,
  multiLineComplex4,
  triangleComplex3,
];

Future<Map<String, dynamic>> getRandomPuzzle() async {
  final prefs = await SharedPreferences.getInstance();
  final easyModeOn = prefs.getBool('easyMode');
  final normalModeOn = prefs.getBool('normalMode');
  final hardModeOn = prefs.getBool('hardMode');

  Map puzzle;

  if (easyModeOn) {
    final pool = ([easyPuzzle, semiEasyPuzzle]..shuffle())[0];
    puzzle = await (pool..shuffle())[0]();
  } else if (normalModeOn) {
    final difficulty = Random().nextDouble();
    if (difficulty < 0.4)
      puzzle = await (easyPuzzle..shuffle())[0]();
    else if (difficulty < 0.7)
      puzzle = await (semiEasyPuzzle..shuffle())[0]();
    else if (difficulty < 0.9)
      puzzle = await (semiHardPuzzle..shuffle())[0]();
    else if (difficulty < 1.0) puzzle = await (hardPuzzle..shuffle())[0]();
  } else if (hardModeOn) {
    final pool = ([semiHardPuzzle, hardPuzzle]..shuffle())[0];
    puzzle = await (pool..shuffle())[0]();
  }

  // puzzle = await oneLineShift();

  return puzzle;
}

Future<Map<String, dynamic>> oneLineAdd() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = '+';
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
  puzzle['hint'] = '-';
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
  puzzle['hint'] = 'x';
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
  puzzle['hint'] = 'x';
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

  puzzle['point'] = random.nextInt(1) + 4;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(8) + 3;
  final funcNumber = (random.nextInt(100) > 50)
      ? random.nextInt(4) + 1
      : -(random.nextInt(4) + 1);
  puzzle['hint'] = 'x2 ${(funcNumber < 0) ? '-' : '+'} a';
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

  puzzle['point'] = random.nextInt(1) + 4;
  puzzle['workout'] = [];

  int initialNumber = random.nextInt(6) + 5;
  final funcNumber = (random.nextInt(100) > 50)
      ? random.nextInt(8) + 1
      : -(random.nextInt(8) + 1);
  puzzle['hint'] = 'x3 ${(funcNumber < 0) ? '-' : '+'} a';
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

Future<Map<String, dynamic>> oneLineComplex1() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  // Puzzle Setting
  puzzle['hint'] = 'ABC = A x B x C';
  puzzle['point'] = random.nextInt(3) + 5;
  puzzle['workout'] = [];

  int initialNumber;
  List numbers;
  while (true) {
    initialNumber = random.nextInt(8629) + 1111;
    // Generate
    numbers = [initialNumber];
    for (var i = 0; i < 3; i++) {
      List<int> digits =
          initialNumber.toString().split('').map((a) => int.parse(a)).toList();
      initialNumber = digits.reduce((a, b) => a * b);
      numbers.add(initialNumber);
      puzzle['workout'].add('${digits.join(' x ')} = $initialNumber');
    }

    if (numbers.contains(0)) {
      initialNumber = random.nextInt(869) + 111;
      numbers = [initialNumber];
      puzzle['workout'] = [];
      continue;
    }
    break;
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
  puzzle['point'] = random.nextInt(2) + 1;
  puzzle['hint'] = '+';
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
  puzzle['point'] = random.nextInt(2) + 1;
  puzzle['hint'] = '-';
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
  puzzle['point'] = random.nextInt(1) + 4;

  int func(x, y) => (2 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  puzzle['hint'] = 'x2 ${(flag < 0) ? '-' : '+'} a';
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
  puzzle['point'] = random.nextInt(2) + 4;

  int func(x, y) => (3 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  puzzle['hint'] = 'x3 ${(flag < 0) ? '-' : '+'} a';
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

Future<Map<String, dynamic>> multiLineComplex1() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 6;

  int func(x, y, z) => (pow(x, 2) + pow(y, 2) * z).abs();

  // Generate random numbers
  List<int> sampleNumbers =
      (List.generate(13, (i) => i + 1)..shuffle()).take(8).toList();
  List numbers = [];
  final int flag = (random.nextInt(100) > 50) ? -1 : 1;
  puzzle['hint'] = 'a\u00B2 ${flag < 0 ? '-' : '+'} b';
  for (int i = 0; i < 8; i += 2)
    numbers.add([sampleNumbers[i], flag * sampleNumbers[i + 1]]);

  // Build Puzzle
  List newPuzzle = [];
  for (final List<int> pair in numbers) {
    final a = pair[0];
    final b = pair[1];

    final answer = func(a, b, flag);
    newPuzzle.add('$a, ${b.abs()} = $answer');
    puzzle['workout'].add(
        '${(flag < 0) ? '| ' : ''}$a\u00B2 ${(flag < 0) ? '-' : '+'}  ${b.abs()}\u00B2${(flag < 0) ? ' |' : ''} = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineComplex2() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(1) + 7;
  puzzle['hint'] = 'ABC = A + B + C';

  // Generate random numbers
  List numbers = [];
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(90) + 11, random.nextInt(90) + 11]);

  // Build Puzzle
  List newPuzzle = [];
  final flag = (random.nextInt(100) > 50) ? -1 : 1;
  for (final pair in numbers) {
    final List<int> a = pair[0].toString().split('').map(int.parse).toList();
    final List<int> b = pair[1].toString().split('').map(int.parse).toList();
    final sumA = a.reduce((x, y) => x + y);
    final sumB = b.reduce((x, y) => x + y);
    final answer = (sumA + sumB * flag).abs();
    newPuzzle.add('${pair[0]}, ${pair[1]} = $answer');
    puzzle['workout'].add(
        '(${(sumA > sumB) ? a.join(' + ') : b.join(' + ')}) ${(flag < 0) ? '-' : '+'} (${(sumA < sumB) ? a.join(' + ') : b.join(' + ')}) = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineComplex3() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(1) + 7;
  puzzle['hint'] = 'ABC = A x B x C';

  // Generate random numbers
  List numbers = [];
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(89) + 11, random.nextInt(989) + 11]);

  // Build Puzzle
  List newPuzzle = [];
  final flag = (random.nextInt(100) > 50) ? -1 : 1;
  for (final pair in numbers) {
    final List<int> a = pair[0].toString().split('').map(int.parse).toList();
    final List<int> b = pair[1].toString().split('').map(int.parse).toList();
    final sumA = a.reduce((x, y) => x * y);
    final sumB = b.reduce((x, y) => x * y);
    final answer = (sumA + sumB * flag).abs();
    newPuzzle.add('${pair[0]}, ${pair[1]} = $answer');
    puzzle['workout'].add(
        '${(flag < 0) ? '| ' : ''}(${a.join(' x ')}) ${(flag < 0) ? '-' : '+'} (${b.join(' x ')})${(flag < 0) ? ' |' : ''} = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineComplex4() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 9;
  puzzle['hint'] = 'ABC = A x B x C';

  // Generate random numbers
  List numbers = [];
  for (int i = 0; i < 4; i++)
    numbers.add([random.nextInt(89) + 11, random.nextInt(89) + 11]);

  // Build Puzzle
  List newPuzzle = [];
  final flag = (random.nextInt(100) > 50) ? -1 : 1;
  for (final pair in numbers) {
    final List<int> a = pair[0].toString().split('').map(int.parse).toList();
    final List<int> b = pair[1].toString().split('').map(int.parse).toList();
    final sumA = a.reduce((x, y) => x * y);
    final sumB = b.reduce((x, y) => x + y);
    final answer = (sumA + sumB * flag).abs();
    newPuzzle.add('${pair[0]}, ${pair[1]} = $answer');
    puzzle['workout'].add(
        '${(flag < 0) ? '| ' : ''}(${a.join(' x ')}) ${(flag < 0) ? '-' : '+'} (${b.join(' + ')})${(flag < 0) ? ' |' : ''} = $answer');
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
  puzzle['point'] = Random().nextInt(1) + 8;
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
  puzzle['point'] = Random().nextInt(2) + 4;
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
  puzzle['hint'] = '+ or -';
  int func(x, y) => (x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  for (int i = 0; i < 3; i++)
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

  puzzle['answer'] = newPuzzle[2][2].toString();
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
  for (int i = 0; i < 3; i++)
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

  puzzle['answer'] = newPuzzle[2][2].toString();
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
  puzzle['point'] = random.nextInt(2) + 4;

  int func(x, y) => (2 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  puzzle['hint'] = 'x2 ${flag < 0 ? '-' : '+'} a';
  for (int i = 0; i < 3; i++)
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

  puzzle['answer'] = newPuzzle[2][2].toString();
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
  puzzle['point'] = random.nextInt(2) + 4;

  int func(x, y) => (3 * x + y);

  // Generate random numbers
  List numbers = [];
  int flag = (random.nextInt(100) > 50) ? 1 : -1;
  puzzle['hint'] = 'x3 ${flag < 0 ? '-' : '+'} a';
  for (int i = 0; i < 3; i++)
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

  puzzle['answer'] = newPuzzle[2][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> triangleComplex1() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 6;

  int func(x, y, z) => (pow(x, 2) + pow(y, 2) * z).abs();

  // Generate random numbers
  List<int> sampleNumbers =
      (List.generate(13, (i) => i + 1)..shuffle()).take(6).toList();
  List numbers = [];
  final int flag = (random.nextInt(100) > 50) ? -1 : 1;
  puzzle['hint'] = 'a\u00B2 ${flag < 0 ? '-' : '+'} b';
  for (int i = 0; i < 6; i += 2)
    numbers.add([sampleNumbers[i], flag * sampleNumbers[i + 1]]);

  // Build Puzzle
  List newPuzzle = [];
  for (final List<int> pair in numbers) {
    final a = pair[0];
    final b = pair[1];

    final answer = func(a, b, flag);
    newPuzzle.add([a, b.abs(), answer]);
    puzzle['workout'].add(
        '${(flag < 0) ? '| ' : ''}$a\u00B2 ${(flag < 0) ? '-' : '+'}  ${b.abs()}\u00B2${(flag < 0) ? ' |' : ''} = $answer');
  }
  puzzle['answer'] = newPuzzle[2][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> triangleComplex2() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 6;
  puzzle['hint'] = 'ABC = A x B x C';

  // Generate random numbers
  List numbers = [];
  final int flag = (random.nextInt(100) > 50) ? -1 : 1;
  for (int i = 0; i < 3; i++)
    numbers.add([random.nextInt(89) + 11, random.nextInt(89) + 11]);

  // Build Puzzle
  List newPuzzle = [];
  for (final List<int> pair in numbers) {
    final List<int> a = pair[0].toString().split('').map(int.parse).toList();
    final List<int> b = pair[1].toString().split('').map(int.parse).toList();
    final sumA = a.reduce((x, y) => x * y);
    final sumB = b.reduce((x, y) => x * y);
    final answer = (sumA + sumB * flag).abs();
    newPuzzle.add([pair[0], pair[1], answer]);
    puzzle['workout'].add(
        '${(flag < 0) ? '| ' : ''}(${a.join(' x ')}) ${(flag < 0) ? '-' : '+'} (${b.join(' x ')})${(flag < 0) ? ' |' : ''} = $answer');
  }
  puzzle['answer'] = newPuzzle[2][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> triangleComplex3() async {
  Map<String, dynamic> puzzle = {
    'type': 'triangle',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(3) + 8;
  puzzle['hint'] = 'ABC = A x B x C';

  // Generate random numbers
  List numbers = [];
  final int flag = (random.nextInt(100) > 50) ? -1 : 1;
  for (int i = 0; i < 3; i++)
    numbers.add([random.nextInt(89) + 11, random.nextInt(89) + 11]);

  // Build Puzzle
  List newPuzzle = [];
  for (final List<int> pair in numbers) {
    final List<int> a = pair[0].toString().split('').map(int.parse).toList();
    final List<int> b = pair[1].toString().split('').map(int.parse).toList();
    final sumA = a.reduce((x, y) => x * y);
    final sumB = b.reduce((x, y) => x + y);
    final answer = (sumA + sumB * flag).abs();
    newPuzzle.add([pair[0], pair[1], answer]);
    puzzle['workout'].add(
        '${(flag < 0) ? '| ' : ''}(${a.join(' x ')}) ${(flag < 0) ? '-' : '+'} (${b.join(' + ')})${(flag < 0) ? ' |' : ''} = $answer');
  }
  puzzle['answer'] = newPuzzle[2][2].toString();
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineHideAddSub() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 1;
  puzzle['hint'] = '+ or -';
  final flag = (random.nextInt(100) > 50) ? -1 : 1;
  int func(x, y) => (x + y * flag);
  final ops = (flag < 0) ? '-' : '+';
  final funcNumber = random.nextInt(30) + 1;

  // Generate random numbers
  List numbers = List.generate(50, (i) => i + funcNumber - 1);
  numbers = (numbers..shuffle()).take(4).toList();

  // Build Puzzle
  List newPuzzle = [];
  for (final number in numbers) {
    final answer = func(number, funcNumber);
    newPuzzle.add('$number = $answer');
    puzzle['workout'].add('$number $ops $funcNumber = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineHideMultiply() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 1;
  puzzle['hint'] = 'x';
  int func(x, y) => (x * y);
  final ops = 'x';
  final funcNumber = random.nextInt(8) + 2;

  // Generate random numbers
  List numbers = List.generate(12, (i) => i + 1);
  numbers = (numbers..shuffle()).take(4).toList();

  // Build Puzzle
  List newPuzzle = [];
  for (final number in numbers) {
    final answer = func(number, funcNumber);
    newPuzzle.add('$number = $answer');
    puzzle['workout'].add('$number $ops $funcNumber = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineHideComplex1() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 6;
  puzzle['hint'] = '+ a';
  int func(x, y) => (x + y);
  final ops = '+';

  // Generate random numbers
  final diff = random.nextInt(3) + 1;
  final extra = random.nextInt(5);
  List funcNumbers = List.generate(4, (i) => diff * (i + 1) + extra);
  List numbers = List.generate(20, (i) => i + 1);
  numbers = (numbers..shuffle()).take(4).toList();

  // Build Puzzle
  List newPuzzle = [];
  for (var i = 0; i < 4; i++) {
    final answer = func(numbers[i], funcNumbers[i]);
    newPuzzle.add('${numbers[i]} = $answer');
    puzzle['workout'].add('${numbers[i]} $ops ${funcNumbers[i]} = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineComplex5() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 6;
  puzzle['hint'] = '(a x b) + b';
  int func(x, y) => (x * y + y);

  // Generate random numbers
  List<int> sampleNumbers =
      (List.generate(13, (i) => i + 1)..shuffle()).take(8).toList();
  List numbers = [];
  for (int i = 0; i < 8; i += 2)
    numbers.add([sampleNumbers[i], sampleNumbers[i + 1]]);

  // Build Puzzle
  List newPuzzle = [];
  for (final List<int> pair in numbers) {
    final a = pair[0];
    final b = pair[1];

    final answer = func(a, b);
    newPuzzle.add('$a, $b = $answer');
    puzzle['workout'].add('($a x $b) + $b = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineHideComplex2() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 4;
  puzzle['hint'] = 'a\u00B2 + b';
  int func(x, y) => (pow(x, 2) + y);

  // Generate random numbers
  List<int> numbers =
      (List.generate(12, (i) => i + 1)..shuffle()).take(4).toList();
  final extra = random.nextInt(15) + 1;

  // Build Puzzle
  List newPuzzle = [];
  for (final number in numbers) {
    final answer = func(number, extra);
    newPuzzle.add('$number = $answer');
    puzzle['workout'].add('$number\u00B2 + $extra = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> nineBoxes1() async {
  Map<String, dynamic> puzzle = {
    'type': 'nineBoxes',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(1) + 3;
  final base = random.nextInt(12) + 1;
  puzzle['hint'] = '$base x ?';

  // Generate random numbers
  List<int> numbers = List.generate(9, (i) => (i + 1) * base);
  numbers.shuffle();

  // Build Puzzle
  for (var i = 1; i < 10; i++) {
    puzzle['workout'].add('$base x $i = ${base * i}');
  }
  puzzle['workout'].add('\nAnswer = ${numbers[0]}');
  puzzle['answer'] = numbers[0].toString();
  puzzle['puzzle'] = numbers.skip(1).take(8).toList();

  return puzzle;
}

Future<Map<String, dynamic>> nineBoxes2() async {
  Map<String, dynamic> puzzle = {
    'type': 'nineBoxes',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(1) + 2;
  puzzle['hint'] = 'a\u00B2';

  // Generate random numbers
  List<int> numbers = List.generate(9, (i) => pow((i + 1), 2));
  numbers.shuffle();

  // Build Puzzle
  for (var i = 1; i < 10; i++) {
    puzzle['workout'].add('$i\u00B2 = ${pow(i, 2)}');
  }
  puzzle['workout'].add('\nAnswer = ${numbers[0]}');
  puzzle['answer'] = numbers[0].toString();
  puzzle['puzzle'] = numbers.skip(1).take(8).toList();

  return puzzle;
}

Future<Map<String, dynamic>> nineBoxes3() async {
  Map<String, dynamic> puzzle = {
    'type': 'nineBoxes',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = 3;
  puzzle['hint'] = 'a\u00B2';

  // Generate random numbers
  int initNumber = random.nextInt(10) + 1;
  int funcNumber = random.nextInt(5) + 1;
  List<int> numbers =
      List.generate(9, (i) => (i + 1) * funcNumber + initNumber);
  numbers.shuffle();

  puzzle['hint'] = '$initNumber, $funcNumber';

  // Build Puzzle
  for (var i = 1; i < 10; i++) {
    puzzle['workout'].add('$i x $funcNumber = ${i * funcNumber}');
  }
  puzzle['workout'].add('\nAnswer = ${numbers[0]}');
  puzzle['answer'] = numbers[0].toString();
  puzzle['puzzle'] = numbers.skip(1).take(8).toList();

  return puzzle;
}

Future<Map<String, dynamic>> multiLineComplex6() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 5;
  puzzle['hint'] = '(a + b) x (a - b)';
  int func(x, y) => ((x + y) * (x - y).abs());

  // Generate random numbers
  List<int> sampleNumbers =
      (List.generate(12, (i) => i + 1)..shuffle()).take(8).toList();
  List<List<int>> numbers = [];
  for (var i = 0; i < 8; i += 2)
    numbers.add([sampleNumbers[i], sampleNumbers[i + 1]]);

  // Build Puzzle
  List newPuzzle = [];
  for (final pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add('$a, $b = $answer');
    puzzle['workout']
        .add('($a + $b) x (${max(a, b)} - ${min(a, b)}) = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineComplex7() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 5;
  int flag = (random.nextInt(100) > 50) ? -1 : 1;
  puzzle['hint'] = '(a x b) ${(flag < 0) ? '-' : '+'} (a + b)';
  int func(x, y) => ((x * y) + flag * (x + y).abs());

  // Generate random numbers
  List<int> sampleNumbers =
      (List.generate(11, (i) => i + 2)..shuffle()).take(8).toList();
  List<List<int>> numbers = [];
  for (var i = 0; i < 8; i += 2)
    numbers.add([sampleNumbers[i], sampleNumbers[i + 1]]);

  // Build Puzzle
  List newPuzzle = [];
  for (final pair in numbers) {
    final a = pair[0];
    final b = pair[1];
    final answer = func(a, b);
    newPuzzle.add('$a, $b = $answer');
    puzzle['workout']
        .add('($a x $b) ${(flag < 0) ? '-' : '+'} ($a + $b) = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> multiLineHideComplex3() async {
  Map<String, dynamic> puzzle = {
    'type': 'multiLine',
    'puzzle': [],
    'workout': [],
  };
  final random = Random();

  // Puzzle Setting
  puzzle['point'] = random.nextInt(2) + 5;
  puzzle['hint'] = 'AB = A\u00B2 + B';
  int func(x, y) => (pow(x, 2) + y);

  // Generate random numbers
  List<int> numbers =
      (List.generate(88, (i) => i + 11)..shuffle()).take(4).toList();

  // Build Puzzle
  List newPuzzle = [];
  for (final number in numbers) {
    final int a = number ~/ 10;
    final int b = number % 10;
    final answer = func(a, b);
    newPuzzle.add('$number = $answer');
    puzzle['workout'].add('$a\u00B2 + $b = $answer');
  }
  puzzle['answer'] = newPuzzle[3].split(' = ')[1];
  newPuzzle[3] = newPuzzle[3].split(' = ')[0] + ' = ?';
  puzzle['puzzle'] = newPuzzle;

  return puzzle;
}

Future<Map<String, dynamic>> oneLineShift() async {
  Map<String, dynamic> puzzle = {'type': 'oneLine'};
  final random = Random();

  List<Object> rotate(List<Object> list, int v) {
    if (list == null || list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  // Puzzle Setting
  puzzle['hint'] = 'ABCD, BCDA, CDAB, DABC';
  puzzle['point'] = random.nextInt(3) + 1;
  puzzle['workout'] = [];

  List<int> digits =
      (List.generate(9, (i) => i + 1)..shuffle()).take(4).toList();
  List<String> numbers = [];
  // Generate
  for (var i = 0; i < 4; i++) {
    numbers.add(digits.join(''));
    digits = rotate(digits, 1);
  }
  puzzle['workout'].add('${numbers[3]}');
  puzzle['puzzle'] = numbers.take(3).join(', ') + ', ?';
  puzzle['answer'] = '${numbers[3]}';

  return puzzle;
}
