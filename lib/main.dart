import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingo_panda/data/data_sources/comment_remote_data_source.dart';
import 'package:lingo_panda/data/repositories/comment_repository_impl.dart';
import 'package:lingo_panda/presentation/provider/comment_provider.dart';
import 'package:lingo_panda/routing/routes.dart';
import 'package:lingo_panda/styling/custom_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CommentProvider(
            CommentRepositoryImpl(CommentRemoteDataSource()),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: true,
        routerConfig: RoutingUtils.buildGoRouter(),
        theme: CustomTheme.theme,
      ),
    );
  }
}
