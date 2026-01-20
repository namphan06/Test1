import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list/list_product_bloc.dart';
import 'list/list_product_reponsitory_impl.dart';
import 'post/post_api.dart';
import 'post/post_bloc.dart';
import 'post/post_reponsitory_impl.dart';
import 'screen/list_product_screen.dart';
import 'supabase_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Cấu hình Dio với headers phù hợp để tránh lỗi 403
    final dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListProductBloc(
            ListProductRepositoryImpl(SupabaseService.instance.client),
          ),
        ),
        BlocProvider(
          create: (context) => PostBloc(
            PostRepositoryImpl(PostApi(dio)),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Quản lý Sản phẩm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
        ),
        home: const ListProductScreen(),
      ),
    );
  }
}
