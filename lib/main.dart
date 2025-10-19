import 'package:flutter/material.dart';

void main() {
  runApp(const PythonTutorialApp());
}

class PythonTutorialApp extends StatelessWidget {
  const PythonTutorialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Python',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red.shade800,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
// ---------------- HOME PAGE ----------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  // Reuse topics from AppDrawer
  static const topics = [
    "Syntax",
    "Comments",
    "Variables",
    "Data Types",
    "Numbers",
    "Casting",
    "Strings",
    "Booleans",
    "Operators",
    "Lists",
    "Tuples",
    "Sets",
    "Dictionaries",
    "If...Else",
    "While Loop",
    "For Loop",
    "Functions",
  ];


  @override
  Widget build(BuildContext context) {
    // Filter topics based on query
    final filteredTopics = topics
        .where((t) => t.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Learn Python')),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0E0), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🔍 Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() => query = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search topics...',
                    prefixIcon: const Icon(Icons.search, color: Colors.redAccent),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🧠 Show filtered topics (if searching)
                if (query.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Search Results:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...filteredTopics.map((topic) => Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.book, color: Colors.redAccent),
                          title: Text(topic),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TopicPage(id: topic),
                              ),
                            );
                          },
                        ),
                      )),
                      if (filteredTopics.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'No topics found.',
                            style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),

                // 🐍 Only show introduction if not searching
                if (query.isEmpty) ...[
                  Text(
                    '1. Introduction to Python',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'images/python.png',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ContentSection(
                    title: 'What is Python?',
                    content:
                    'Python is a popular, high-level programming language known for its readability and versatility. '
                        'It is widely used for web development, data analysis, AI, and automation. '
                        'Its simple syntax makes it ideal for beginners and professionals alike.',
                  ),
                  const SizedBox(height: 20),
                  const ContentSection(
                    title: 'What can Python do?',
                    content:
                    '• Web Development: Build backends with Django, Flask.\n'
                        '• Data Science & Analysis: Use Pandas, NumPy, Matplotlib.\n'
                        '• Machine Learning & AI: TensorFlow, PyTorch.\n'
                        '• Automation & Scripting: Automate tasks, web scraping.\n'
                        '• Software Development: Desktop apps & CLI tools.\n'
                        '• Scientific Computing: Complex numerical simulations.',
                  ),
                  const SizedBox(height: 20),
                  const ContentSection(
                    title: 'Why Use Python?',
                    content:
                    'Python’s simple, English-like syntax makes it easy to learn and allows for rapid development, '
                        'while its massive library ecosystem (like Pandas and TensorFlow) offers unmatched power '
                        'across fields like data science, web development, and automation.',
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 6,
                        shadowColor: Colors.red.shade200,
                      ),
                      child: const Text('Start Learning', style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TopicPage(id: 'Syntax'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- REUSABLE CONTENT SECTION ----------------
class ContentSection extends StatelessWidget {
  final String title;
  final String content;

  const ContentSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.red.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 28, color: Colors.red.shade800)),
            const SizedBox(height: 12),
            Text(content, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
// ---------------- ENHANCED DRAWER ----------------
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const topics = [
    "Syntax",
    "Comments",
    "Variables",
    "Data Types",
    "Numbers",
    "Casting",
    "Strings",
    "Booleans",
    "Operators",
    "Lists",
    "Tuples",
    "Sets",
    "Dictionaries",
    "If...Else",
    "While Loop",
    "For Loop",
    "Functions",
  ];

  // Match icons to topic names
  IconData _getIconForTopic(String topic) {
    switch (topic) {
      case "Syntax":
        return Icons.language;
      case "Comments":
        return Icons.comment;
      case "Variables":
        return Icons.data_object;
      case "Data Types":
        return Icons.category;
      case "Numbers":
        return Icons.pin;
      case "Casting":
        return Icons.compare_arrows;
      case "Strings":
        return Icons.text_fields;
      case "Booleans":
        return Icons.toggle_on;
      case "Operators":
        return Icons.functions;
      case "Lists":
        return Icons.format_list_bulleted;
      case "Tuples":
        return Icons.all_inclusive;
      case "Sets":
        return Icons.set_meal;
      case "Dictionaries":
        return Icons.menu_book;
      case "If...Else":
        return Icons.question_answer;
      case "While Loop":
        return Icons.loop;
      case "For Loop":
        return Icons.repeat;
      case "Functions":
        return Icons.integration_instructions;
      default:
        return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter topics based on search
    final filteredTopics = topics
        .where((topic) =>
        topic.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.deepOrangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              DrawerHeader(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Python Topics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 🔍 SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Search topic...",
                      hintStyle:
                      TextStyle(color: Colors.white.withOpacity(0.7)),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // TOPIC LIST
              Expanded(
                child: filteredTopics.isEmpty
                    ? const Center(
                  child: Text(
                    'No topics found',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
                    : ListView.separated(
                  itemCount: filteredTopics.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 0, color: Colors.white24),
                  itemBuilder: (context, index) {
                    final topic = filteredTopics[index];
                    return ListTile(
                      leading: Icon(
                        _getIconForTopic(topic),
                        color: Colors.white,
                      ),
                      title: Text(
                        topic,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      hoverColor: Colors.white24,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TopicPage(id: topic),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// ---------------- TOPIC PAGE WITH SCALE + FADE + SLIDE ----------------
class TopicPage extends StatefulWidget {
  final String id;
  const TopicPage({super.key, required this.id});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> topics = {
      'Syntax': [
        {
          'title': '• Syntax Basics',
          'desc':
          'Python syntax defines how code should be written. It uses indentation instead of braces and emphasizes simplicity.',
          'image': 'images/syntax.png',
        },
        {
          'title': '• Indentation in Python',
          'desc':
          'Indentation is very important in Python. It indicates a block of code, unlike other languages that use curly braces.',
          'image': 'images/indentation.png',
        },
      ],
      'Syntax': [
        {
          'title': '• Syntax Basics',
          'desc':
          'Python syntax defines how code should be written. It uses indentation instead of braces and emphasizes simplicity.',
          'image': 'images/syntax.png',
        },
        {
          'title': '• Indentation in Python',
          'desc':
          'Indentation is very important in Python. It indicates a block of code, unlike other languages that use curly braces.',
          'image': 'images/indentation.png',
        },
      ],
      'Comments': [
        {
          'title': '• Creating a Comments',
          'desc':
          'Comments help describe what your code does. Use # for single-line or triple quotes for multi-line comments.',
          'image': 'images/comments.png',
          'image2': 'images/comment.png',
        },
        {
          'title': '• Multiline Comments',
          'desc':
          'Multiline comments in Python refer to text that spans multiple lines but is ignored by the Python interpreter. However, unlike some other programming languages that have dedicated multi-line comment syntax, Python does not have a native, single syntax for multi-line comments.',
          'image': 'images/multiline.png',
          'image2': 'images/multiline2.png',
        },
      ],
      'Variables': [
        {
          'title': '• Python Variables',
          'desc':
          'Variables store values. Python automatically determines the type when you assign data.',
          'image': 'images/creating.png',
        },
        {
          'title': '• Many Values to Multiple Variables',
          'desc':
          'The phrase "Many Values to Multiple Variables" refers to a Python feature that allows you to assign several distinct values to several different variables in a single line of code.',
          'image': 'images/multiple.png',
        },
        {
          'title': '• One Value to Multiple Variables',
          'desc':
          'The technique of assigning One Value to Multiple Variables is a Python shortcut that lets you set several variables to the exact same value using a single statement.',
          'image': 'images/multiple2.png',
        },
        {
          'title': '• Unpack a Collection',
          'desc':
          'Unpacking a collection in Python is a concise way to extract the values from that collection and assign them directly to multiple variables.',
          'image': 'images/collection.png',
        },
        {
          'title': '• Global Variables',
          'desc':
          'Global variables are declared outside functions and can be accessed anywhere in the program.',
          'image': 'images/global.png',
        },
        {
          'title': '• The global Keyword',
          'desc':
          'The global keyword allows you to modify a global variable inside a function.',
          'image': 'images/global2.png',
        },
        {
          'title': '• Changing Globe to Variable',
          'desc':
          'Built-in Data Types In programming, data type is an important concept.'
              'Variables can store data of different types, and different types can do different things.',
          'image': 'images/global3.png',
        },
      ],
      'Data Types': [
        {
          'title': '• Built-in Data Types',
          'desc':
          'In programming, data type is an important concept.Variables can store data of different types, and different types can do different things.',
          'image': 'images/data.png',
        },
        {
          'title': '• Getting Data Types',
          'desc':
          'The type() function is a tool that allows you to inspect any value (like a number, text, or list) and immediately identify its exact data type class (e.g., int, str, list, dict)',
          'image': 'images/data2.png',
          'image2': 'images/data3.png',
          'image3': 'images/data4.png',
        },
      ],
      'Numbers': [
        {
          'title': '• Numbers',
          'desc':
          'Python handles numbers using three primary built-in data types: integers, floats, and complex numbers.',
          'image': 'images/number.png',
        },
        {
          'title': '• Int',
          'desc':
          'Int, or integer, is a whole number, positive or negative, without decimals, of unlimited length.',
          'image': 'images/int.png',
        },
        {
          'title': '• Float',
          'desc':
          'Float, or "floating point number" is a number, positive or negative, containing one or more decimals.',
          'image': 'images/float.png',
        },
        {
          'title': '• Complex',
          'desc':
          'The "complex" meaning in Python refers to the complex data type, which is used to represent complex numbers from mathematics.',
          'image': 'images/complex.png',
        },
      ],
      'Casting': [
        {
          'title': '• Specify a Variable Type',
          'desc':
          'Specifying a variable type in Python refers to Type Hinting—the practice of voluntarily adding annotations to your code to indicate the expected data type of a variable, function parameter, or function return value.',
          'image': 'images/variable.png',
          'image2': 'images/variable2.png',
          'image3': 'images/variable3.png',
        },
      ],
      'Strings': [
        {
          'title': '• Strings',
          'desc':
          'The strings in Python refers to their nature as immutable, ordered sequences of Unicode characters that serve as the fundamental data type for handling all forms of text.',
          'image': 'images/string.png',
        },
        {
          'title': '• Quotes Inside Quotes',
          'desc':
          'Handling quotes inside quotes in Python (and most programming languages) involves using a different type of quote for the outer string than for the inner quotes, or using an escape character.',
          'image': 'images/inside.png',
        },
        {
          'title': '• Assign String to a Variable',
          'desc':
          'The request "Assign String to a Variable" is a literal description of an action in programming. Therefore, an "another meaning" would involve interpreting the underlying concepts or alternative uses/methods related to that action in Python.',
          'image': 'images/string2.png',
        },
        {
          'title': '• Multiline Strings',
          'desc':
          'The request "Multiline strings in Python are used to define a string literal that spans multiple lines of text. The most common and recommended way to create them is by using triple quotes.',
          'image': 'images/multiline_string.png',
        },
        {
          'title': '• Slicing',
          'desc':
          'The request "Slicing in Python is a powerful and flexible way to extract a specific portion, or a substring, from a sequence, such as a string, list, or tuple.',
          'image': 'images/slicing.png',
        },
        {
          'title': '•Slice From the Start',
          'desc':
          'The request "Slicing from the start in Python means extracting a portion of a sequence (like a string, list, or tuple) beginning at the very first element (index 0) and continuing up to a specified index.',
          'image': 'images/start.png',
        },
        {
          'title': '→ Modify Strings',
          'desc':
          'Modifying strings in Python actually means creating a new string based on the original, because strings are immutable /they cant be changed after creation.',
        },
        {
          'title': '• Upper-Case',
          'desc':
          'Upper case in Python refers to converting all the characters in a string to their capital (uppercase) forms. This is achieved using the built-in string method.',
          'image': 'images/upper.png',
        },
        {
          'title': '• Lower-Case',
          'desc':
          'Lower case in Python refers to converting all the characters in a string to their small (lowercase) forms. This is done using the built-in string metho',
          'image': 'images/lower.png',
        },
        {
          'title': '• Remove Whitespace',
          'desc':
          'To remove whitespace from a string in Python, you use one of the built-in string methods: .strip(), .lstrip(), or .rstrip(). These methods create and return a new string based on the original.',
          'image': 'images/whitespace.png',
        },
        {
          'title': '• String Concatenation',
          'desc':
          'String concatenation is the process of joining two or more strings together to form a single, longer string. In Python, the simplest way to do this is by using the addition operator (+).',
          'image': 'images/concatenation.png',
        },
        {
          'title': '• String Format',
          'desc':
          'String formatting is the process of embedding variables, expressions, or values into a string literal to create a final, human-readable output. Python offers several methods for this, with f-strings (formatted string literals) being the most modern and recommended approach.',
          'image': 'images/format.png',
        },
        {
          'title': '• F-Strings',
          'desc':
          'F-strings (formatted string literals) are the most modern, powerful, and readable way to create formatted strings in Python (available since Python 3.6). They allow you to embed expressions and variables directly inside a string literal, making string formatting simple and highly concise.',
          'image': 'images/fstring.png',
        },
      ],
      'Booleans': [
        {
          'title': '• Booleans Values',
          'desc':
          'Boolean values in Python are a fundamental data type used to represent one of two truth states: True or False. They are essential for logical operations, decision-making, and controlling the flow of a program.',
          'image': 'images/values.png',
        },
        {
          'title': '• Evaluate Values and Variables',
          'desc':
          'Evaluating values and variables in Python primarily involves determining their truthiness (whether they are considered True or False in a logical context) and using comparison and logical operators to test and combine those values.',
          'image': 'images/valuesvariables.png',
        },
        {
          'title': '• Most Values are True',
          'desc':
          "it's a fundamental principle of Truthiness that most values evaluate to True when used in a Boolean context, such as an if statement or a while loop condition.",
          'image': 'images/true.png',
        },
      ],
      'Operators': [
        {
          'title': '• Operators',
          'desc':
          'Python operators are special symbols or keywords that perform operations on values and variables. These operations range from simple arithmetic to complex logical and comparison tests.',
          'image': 'images/operators.png',
        },
        {
          'title': '• Arithmetic Operators',
          'desc':
          'Arithmetic operators in Python are used to perform common mathematical operations on numeric values (integers, floats, and complex numbers). They are the fundamental tools for all calculations in the language.',
          'image': 'images/arithmetic.png',
        },
        {
          'title': '• Assignment Operators',
          'desc':
          'Assignment operators in Python are used to assign values to variables. The most basic is the simple assignment operator (=), but Python also provides several augmented assignment operators that combine an arithmetic or bitwise operation with the assignment, offering a concise shorthand.',
          'image': 'images/assignment.png',
          'image2': 'images/assignment2.png',
        },
        {
          'title': '• Comparison Operators',
          'desc':
          'Comparison operators (also known as relational operators) in Python are used to compare two values or variables. They always evaluate the relationship between the operands and return a Boolean value (True or False).',
          'image': 'images/comparison.png',
        },
      ],
      'Lists': [
        {
          'title': '• List',
          'desc':
          'Lists are one of the most fundamental and versatile data structures in Python. They are used to store multiple items in a single variable.',
          'image': 'images/list.png',
        },
        {
          'title': '→ List-Items',
          'desc':
          '#When we say that lists are ordered, it means that the items have a defined order, and that order will not change.'
              'If you add new items to a list, the new items will be placed at the end of the list.',
        },
        {
          'title': '→ Ordered',
          'desc':
          'Lists are one of the most fundamental and versatile data structures in Python. They are used to store multiple items in a single variable.'
              'List items are ordered, changeable, and allow duplicate values.'
              'List items are indexed, the first item has index [0], the second item has index [1] etc.',
        },
        {
          'title': '• List-length',
          'desc':
          'The list-length in Python is the number of items currently contained within a list. You find the length of a list using the built-in function len().',
          'image': 'images/length.png',
        },
        {
          'title': '• List Items - Data Types',
          'desc':
          'Python lists are highly flexible because they can hold items of different data types within the same list. This is known as being heterogeneous.',
          'image': 'images/types.png',
        },
        {
          'title': '• Access Items',
          'desc':
          'You can access items in a Python list (and other sequence types like strings and tuples) using indexing and slicing. The key concept is that Python uses zero-based indexing.',
          'image': 'images/access.png',
        },
        {
          'title': '• Range of Indexes',
          'desc':
          'It refers to selecting a subset of items from a sequence (like a list, tuple, or string) by specifying where the selection should start and where it should stop. This operation is called slicing.',
          'image': 'images/range.png',
        },
        {
          'title': '• Check if Item Exists',
          'desc':
          'You can check if an item exists in a Python list (or any other iterable like a string, tuple, or dictionary) using the in keyword, which is a membership operator. It returns a Boolean value (True or False).',
          'image': 'images/check.png',
        },
        {
          'title': '• Change Item Value',
          'desc':
          "You can change an item's value in a Python list because lists are mutable (changeable). You do this by referencing the item's index and using the assignment operator (=).",
          'image': 'images/item.png',
        },
        {
          'title': '• Append Items',
          'desc':
          "To append items to a Python list means to add a new item to the very end of the list. This is the simplest way to grow a list and is achieved using the built-in list method, .append().",
          'image': 'images/append.png',
        },
        {
          'title': '• Insert Items',
          'desc':
          "To insert items at a specific position within a Python list, you use the built-in list method, .insert(). This method adds a new item at a chosen index without replacing any existing item; it shifts all subsequent items one position to the right.",
          'image': 'images/insert.png',
        },
        {
          'title': '• Remove List Items',
          'desc':
          "You can remove items from a Python list using several built-in methods, depending on whether you know the item's value, its index, or want to remove all items.",
          'image': 'images/remove.png',
        },
        {
          'title': '• Loop Through a List',
          'desc':
          "The most common and Pythonic way to loop through a list is by using the for loop. This allows you to execute a block of code once for every item in the list.",
          'image': 'images/loop.png',
        },
        {
          'title': '• List Comprehension',
          'desc':
          "List comprehension provides a concise, readable, and often faster way to create new lists in Python based on existing sequences (like lists, tuples, or ranges). It allows you to express a for loop and the list creation process in a single line.",
          'image': 'images/comprehension.png',
        },
      ],
      'Tuples': [
        {
          'title': '• Tuples',
          'desc':
          'Tuples are one of the four built-in collection data types in Python, used to store multiple items in a single variable. They are similar to lists but have one crucial difference: they are immutable (unchangeable).',
          'image': 'images/tuples.png',
        },
        {
          'title': '→ Tuple Items',
          'desc':
          'Tuple items are ordered, unchangeable, and allow duplicate values.'
              'Tuple items are indexed, the first item has index [0], the second item has index [1] etc.',
        },
        {
          'title': '→ Ordered',
          'desc':
          'When we say that tuples are ordered, it means that the items have a defined order, and that order will not change.',
        },
        {
          'title': '→ Unchangeable',
          'desc':
          'Tuples are unchangeable, meaning that we cannot change, add or remove items after the tuple has been created.',
        },
        {
          'title': '• Access and Range Indexing',
          'desc':
          'Accessing and using a Range of Indexes in Python are fundamental operations for retrieving specific elements or subsets of elements from sequences like lists, tuples, or strings.',
          'image': 'images/accessrange.png',
        },
        {
          'title': '• Change Tuple Values',
          'desc':
          'You cannot directly change, add, or remove values in a Python tuple after it has been created because tuples are immutable.'
              'However, you can use a common workaround to achieve the effect of modification: by converting the tuple to a list, modifying the list, and then converting it back to a new tuple.',
          'image': 'images/changevalues.png',
        },
      ],
      'Sets': [
        {
          'title': '• Set',
          'desc':
          'A Set is an unordered, mutable collection data type in Python that stores unique elements. Sets are primarily used for mathematical set operations (like union, intersection, and difference) and for quickly testing membership and eliminating duplicate entries.',
          'image': 'images/set.png',
        },
        {
          'title': '→ Set Items',
          'desc':
          'Set items are unordered, unchangeable, and do not allow duplicate values.',
        },
        {
          'title': '→ Unordered',
          'desc':
          'Unordered means that the items in a set do not have a defined order.'
              'Set items can appear in a different order every time you use them, and cannot be referred to by index or key.',
        },
        {
          'title': '→ Unchangeable',
          'desc':
          'Set items are unchangeable, meaning that we cannot change the items after the set has been created.',
        },
        {
          'title': '→ Duplicates Not Allowed',
          'desc':
          'Sets cannot have two items with the same value.',
        },
        {
          'title': '• Access Items',
          'desc':
          'You can access items in a Python Set using the for loop to iterate over its elements or by using the in keyword to check for membership. Unlike lists and tuples, you cannot access items in a set by referring to an index or key, because sets are unordered.',
          'image': 'images/accessitem.png',
        },
        {
          'title': '• Add Items',
          'desc':
          'You can add items to a Python set using the built-in methods: .add() for a single element or .update() for multiple elements from an iterable.',
          'image': 'images/additems.png',
        },
        {
          'title': '• Remove Items',
          'desc':
          'ou can remove items from a Python Set using methods that delete a specified element by its value: .remove(), .discard(), .pop(), and .clear().',
          'image': 'images/removeitems.png',
        },
      ],
      'Dictionaries': [
        {
          'title': '• Dictionary',
          'desc':
          'A Dictionary is an unordered, changeable, and indexed collection data type in Python, used to store data in key:value pairs. It is optimized for retrieving a value when the key is known, making it ideal for associating pieces of information.',
          'image': 'images/dictionary.png',
        },
        {
          'title': '• Dictionary Items',
          'desc':
          'Dictionary items are the elements stored within a Python dictionary, and they consist of key:value pairs. Each item allows you to associate a unique identifier (key) with a piece of information (value).',
          'image': 'images/dictionaryitems.png',
        },
        {
          'title': '→ Ordered or Unordered',
          'desc':
          'When we say that dictionaries are ordered, it means that the items have a defined order, and that order will not change.'
              'Ordered means that the items do not have a defined order, you cannot refer to an item by using an index.',
        },
        {
          'title': '→ Changeable',
          'desc':
          'Dictionaries are changeable, meaning that we can change, add or remove items after the dictionary has been created.',
        },
        {
          'title': '→ Duplicates Not Allowed',
          'desc':
          'Dictionaries cannot have two items with the same key',
        },
        {
          'title': '• Dictionary Length',
          'desc':
          'The Dictionary Length in Python is the total number of key:value pairs (items) contained within the dictionary. You determine this length using the built-in function len().',
          'image': 'images/dictionarylength.png',
        },
        {
          'title': '• Change Values',
          'desc':
          'You can change the values associated with keys in a Python Dictionary by referencing the key and using the assignment operator (=). Dictionaries are mutable, so this operation modifies the dictionary in place.',
          'image': 'images/changevalue.png',
        },
        {
          'title': '• Adding Items',
          'desc':
          'You can add items to a Python dictionary by assigning a value to a new key using the assignment operator (=) or by using the built-in .update() method. Since dictionaries are mutable, these operations modify the dictionary in place.',
          'image': 'images/addingdict.png',
        },
        {
          'title': '• Accessing Items',
          'desc':
          "Accessing items in a Python dictionary is done by referencing the item's unique key. You can retrieve the value associated with a key using square bracket notation ([]) or the safer .get() method.",
          'image': 'images/accessingdict.png',
        },
        {
          'title': '• Get keys',
          'desc':
          'You can get the keys from a Python Dictionary using the built-in dictionary method, .keys(). This method returns a view object that displays a dynamic list of all the keys currently in the dictionary.',
          'image': 'images/getkeys.png',
        },
        {
          'title': '• Remove Item',
          'desc':
          'You can remove items (key:value pairs) from a Python Dictionary using several methods, depending on whether you know the key, want to remove the last inserted item, or want to clear the entire dictionary.',
          'image': 'images/removedict.png',
        },
        {
          'title': '• Loop Through a Dictionary',
          'desc':
          'You can loop through a dictionary in Python using a for loop. The way you structure the loop determines whether you access the keys, the values, or both key and value pairs.',
          'image': 'images/loopdict.png',
        },
      ],
      'If...Else': [
        {
          'title': '• If...Else',
          'desc':
          'If...Else is the fundamental construct in Python used for conditional execution, allowing your program to make decisions and execute different blocks of code based on whether a specified condition is True or False.',
          'image': 'images/ifelse.png',
        },
        {
          'title': '→ If...Else',
          'desc':
          'If...Else is the fundamental construct in Python used for conditional execution, allowing your program to make decisions and execute different blocks of code based on whether a specified condition is True or False.'
              'Conditions and If statements'
              'Python supports the usual logical conditions from mathematics:                                                                          '
              '1. Equals: a == b                                                                                               '
              '2. Not Equals: a != b                                                                                            '
              '3. Less than: a < b                                                                                               '
              '4. Less than or equal to: a <= b                                                                                   '
              '5. Greater than: a > b                                                                                              '
              '6. Greater than or equal to: a >= b                                                                                   '
              '• These conditions can be used in several ways, most commonly in "if statements" and loops.',
        },
        {
          'title': '• If Statement',
          'desc':
          'An If Statement is the basic building block of decision-making in Python. It evaluates a logical condition (an expression that results in either True or False) and executes a block of code only if the condition is met (i.e., it evaluates to True).',
          'image': 'images/ifstate.png',
        },
        {
          'title': '→ Indentation',
          'desc':
          'Python relies on indentation (whitespace at the beginning of a line) to define scope in the code. Other programming languages often use curly-brackets for this purpose.',
        },
        {
          'title': '• The Python Match Statement',
          'desc':
          'The Python match statement is used to compare a value against multiple patterns and execute code based on which pattern matches. It’s similar to a switch statement in other languages and makes complex conditional logic easier to read and manage.',
          'image': 'images/match.png',
        },
      ],
      'While Loop': [
        {
          'title': '• While Loop',
          'desc':
          "A While Loop in Python is used to execute a block of code repeatedly as long as a specified condition remains True. It's used when you don't know the exact number of iterations needed beforehand, and you want the loop to continue until a certain condition is met.",
          'image': 'images/whileloop.png',
        },
        {
          'title': '• The break Statement',
          'desc':
          'The break statement in Python is used to immediately terminate the execution of the innermost for loop or while loop. When break is executed, the program skips the remaining code within the loop body and exits the loop entirely, continuing execution at the first statement after the loop.',
          'image': 'images/breakstate.png',
        },
        {
          'title': '• The continue Statement',
          'desc':
          'The continue statement in Python is used to skip the rest of the code inside the current iteration of a for loop or a while loop and immediately jump to the next iteration. '
              'Unlike break, which terminates the entire loop, continue only interrupts the current cycle, allowing the loop to proceed with subsequent iterations.',
          'image': 'images/continuestate.png',
        },
        {
          'title': '• The else Statement',
          'desc':
          'The else statement in Python is used to define a block of code that should be executed when the preceding conditional structure—an if statement, a for loop, or a while loop—completes its task or evaluates to False.',
          'image': 'images/elsestate.png',
        },
      ],
      'For Loop': [
        {
          'title': '• For Loops',
          'desc':
          'A For Loop in Python is used for iterating over a sequence (like a list, tuple, dictionary, set, or string) or another iterable object. It executes a block of code once for each item in that sequence.',
          'image': 'images/forloop.png',
        },
        {
          'title': '• Looping Through a String',
          'desc':
          'You can loop through a string in Python using a for loop, treating the string as a sequence of characters. This is the most common and Pythonic way to process a string one character at a time.',
          'image': 'images/looping.png',
        },
        {
          'title': '• The range() Function',
          'desc':
          "The range() function in Python is a built-in function used to generate a sequence of numbers. It's most commonly used to control how many times a for loop executes. The sequence generated by range() is an immutable sequence type and does not store all the numbers in memory, making it highly memory efficient.",
          'image': 'images/rangeloop.png',
        },
      ],
      'Functions': [
        {
          'title': '→ Creating a Function',
          'desc':
          'Creating a function in Python is done using the def keyword. Functions are blocks of organized, reusable code that perform a single, related action, helping to break large programs into smaller, modular, and manageable pieces.',
        },
        {
          'title': '• Calling a Function',
          'desc':
          "Calling a function means executing the code defined inside the function. In Python, you call a function by writing its name followed by parentheses (), and providing any necessary arguments inside those parentheses.",
          'image': 'images/calling.png',
        },
        {
          'title': '• Return Values',
          'desc':
          "Return values are the results that a function sends back to the part of the program that called it. This is done using the return statement. Once a return statement is executed, the function immediately stops running, and the returned value replaces the original function call in the code.",
          'image': 'images/return.png',
        },
        {
          'title': '• Arguments',
          'desc':
          "Arguments are the actual values you pass to a function when you call it. They correspond to the parameters (the placeholder names) defined in the function header. Arguments are what a function needs to perform its task.",
          'image': 'images/arguments.png',
        },
        {
          'title': '• Number of Arguments',
          'desc':
          "The number of arguments you pass to a Python function when you call it must generally match the number of parameters defined in the function's header. 📏 However, Python provides flexible ways to handle arguments that allow for optional, varying, or keyword-based inputs.",
          'image': 'images/numarguments.png',
        },
        {
          'title': '• Mixing Positional and Keyword Arguments',
          'desc':
          "You can mix positional and keyword arguments when calling a function in Python, but you must follow a strict order: all positional arguments must come before any keyword arguments.",
          'image': 'images/mixing.png',
        },
        {
          'title': '• Global vs. Local scope',
          'desc':
          "In Python, scope refers to the region of a program where a variable is accessible. Understanding the difference between Global and Local scope is crucial for writing reliable and bug-free code.",
        },
        {
          'title': '• Globe',
          'desc':
          "In Python, a Global variable is a variable defined in the main body of a script, outside of any function. Variables in the global scope are accessible from anywhere in your program.",
          'image': 'images/globe.png',
        },
        {
          'title': '• Local',
          'desc':
          "A Local variable in Python is a variable defined and accessible only within the specific function or code block where it was created. This concept is central to Python's local scope.",
          'image': 'images/local.png',
        },
      ],
    };
    final contentList = topics[widget.id];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: contentList == null
              ? const Center(child: Text('Topic not found.'))
              : LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeInOut,
                  ),
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutBack,
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.05),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeOutCubic,
                      )),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: contentList.map((section) {
                            final images = section.entries
                                .where((e) => e.key.startsWith('image'))
                                .map((e) => e.value as String)
                                .toList();

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 28.0),
                              child: _buildContent(
                                title: section['title'] ?? '',
                                desc: section['desc'] ?? '',
                                images: images,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
    Widget _buildContent({
    required String title,
    required String desc,
    required List<String> images,
  }) {
    return Card(
      elevation: 12,
      shadowColor: Colors.red.shade300.withOpacity(0.6),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Lite',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              desc,
              style: const TextStyle(fontSize: 18, height: 1.6),
            ),
            const SizedBox(height: 18),

            // Images (now glossy & not faded)
            for (final img in images) ...[
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.transparent, // ensures full color
                      BlendMode.srcOver,
                    ),
                    child: Image.asset(
                      img,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high, // better color quality
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('❌ ERROR loading "$img": $error');
                        return Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}