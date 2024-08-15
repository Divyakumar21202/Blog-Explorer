import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace/subspace/bloc/blog_bloc.dart';
import 'package:subspace/subspace/features/Blog%20Article/screens/blog_home_screen.dart';
import 'subspace/features/Blog Article/models/blog_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogBloc(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        darkTheme: ThemeData.dark(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const BlogHomeScreen(),
      ),
    );
  }
}
