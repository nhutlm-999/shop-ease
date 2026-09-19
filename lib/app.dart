// route + theme
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ease/core/theme/app_theme.dart';
import 'package:shop_ease/models/product.dart';
import 'package:shop_ease/providers/theme_provider.dart';
import 'package:shop_ease/screens/main_screen.dart';


class ShopEaseApp extends StatelessWidget {
  const ShopEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'ShopEase',
            debugShowCheckedModeBanner: false,

            // THEME 
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            
            // ROUTE
            initialRoute: '/',
            routes: {
              '/': (_) => const MainScreen(),
            //   '/detail': (ctx) {
            //     final product =
            //         ModalRoute.of(ctx)!.settings.arguments as Product;
            //     return ProductDetailScreen(product: product);
            //   },
            }
          );
        },
      ),
    );
  }
}

