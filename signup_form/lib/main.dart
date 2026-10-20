import 'package:flutter/material.dart';
import 'summary_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: const SignUpScreen(),
  );
}

const groups = ['IT-2301', 'IT-2302', 'IT-2303', 'IT-2304', 'IT-2305'];

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Ключ формы для запуска validate()
  final _formKey = GlobalKey<FormState>();

  // Текстовые контроллеры объявлены в State и будут освобождены в dispose
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _birthController = TextEditingController();

  // FocusNode для явного перехода на поле Email
  final _emailFocus = FocusNode();

  // Переменные состояния для формы[cite: 2]
  String? _selectedGroup;
  DateTime? _birthDate;
  bool _agreed = false;
  bool _done = false;

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _confirm, _birthController]) {
      c.dispose();
    }
    _emailFocus.dispose();
    super.dispose();
  }

  // Всплывающий календарь для выбора даты рождения (Level 4)[cite: 2]
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    // ВАЖНО: Проверка mounted после использования await[cite: 2]
    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _birthDate = picked;
        final day = picked.day.toString().padLeft(2, '0');
        final month = picked.month.toString().padLeft(2, '0');
        _birthController.text = '$day.$month.${picked.year}';
      });
    }
  }

  // Обработка кнопки Sign up (Level 2)[cite: 2]
  void _submit() {
    // Единственное разрешенное использование '!' — на _formKey.currentState[cite: 2]
    if (_formKey.currentState!.validate()) {
      setState(() {
        _done = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created')),
      );
    }
  }

  // Сброс формы к начальному состоянию (Level 5)[cite: 2]
  void _reset() {
    _name.clear();
    _email.clear();
    _password.clear();
    _confirm.clear();
    _birthController.clear();

    setState(() {
      _selectedGroup = null;
      _birthDate = null;
      _agreed = false;
      _done = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: _done
          ? SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SummaryCard(
              name: _name.text,
              email: _email.text,
              group: _selectedGroup ?? '',
              birthDate: _birthController.text,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: _reset,
              child: const Text('Start over'),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          // Авто-валидация включается после первого взаимодействия[cite: 2]
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // Поле: Имя[cite: 2]
              TextFormField(
                controller: _name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if ((v ?? '').trim().length < 2) {
                    return 'Name is too short';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),

              // Поле: Email[cite: 2]
              TextFormField(
                controller: _email,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'name@kbtu.kz',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final email = (v ?? '').trim();
                  if (!email.contains('@') || !email.contains('.')) {
                    return 'Email looks wrong';
                  }
                  return null;
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),

              // Поле: Пароль[cite: 2]
              TextFormField(
                controller: _password,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  helperText: 'At least 8 characters',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if ((v ?? '').length < 8) {
                    return 'Password is too short';
                  }
                  return null;
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),

              // Поле: Подтверждение пароля[cite: 2]
              TextFormField(
                controller: _confirm,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v != _password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 12),

              // Выпадающий список: Группа[cite: 2]
              DropdownButtonFormField<String>(
                value: _selectedGroup,
                decoration: const InputDecoration(
                  labelText: 'Group',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final g in groups)
                    DropdownMenuItem(value: g, child: Text(g))
                ],
                onChanged: (val) {
                  setState(() {
                    _selectedGroup = val;
                  });
                },
                validator: (g) => g == null ? 'Choose a group' : null,
              ),
              const SizedBox(height: 12),

              // Выбор даты рождения (ReadOnly TextFormField)[cite: 2]
              TextFormField(
                controller: _birthController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of birth',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _pickDate,
                validator: (_) =>
                _birthDate == null ? 'Select date of birth' : null,
              ),
              const SizedBox(height: 12),

              // Чекбокс согласия с правилами[cite: 2]
              CheckboxListTile(
                value: _agreed,
                title: const Text('I agree to the rules'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) {
                  setState(() {
                    _agreed = val ?? false;
                  });
                },
              ),

              // ВАЖНО: Используется SizedBox вместо Spacer[cite: 2]
              const SizedBox(height: 24),

              // Кнопка регистрация (деактивирована, если _agreed == false)[cite: 2]
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: _agreed ? _submit : null,
                  child: const Text('Sign up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}