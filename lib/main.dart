import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/clipboard/bloc/clipboard_bloc.dart';
import 'features/clipboard/bloc/clipboard_event.dart';
import 'features/clipboard/views/widgets/clipboard_details.dart';
import 'features/notes/models/note_item.dart';
import 'features/notes/data/notes_repository.dart';
import 'features/notes/bloc/notes_bloc.dart';
import 'features/notes/bloc/notes_event.dart';
import 'app/views/main_scaffold.dart';
import 'features/notes/views/note_detail_page.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(NoteItemAdapter());

  // Open the Hive boxes
  try {
    // Open box for notes
    await Hive.openBox<NoteItem>('note_items_box');
    
    // Open box for clipboard - using separate box as per requirement
    await Hive.openBox<NoteItem>('clipboard_box');
  } catch (e) {
    // Handle box open error
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Failed to initialize database',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                'Error: ${e.toString()}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ));
    return;
  }

  // Get clipboard box reference
  final clipboardBox = Hive.box<NoteItem>('clipboard_box');

  // Inject repositories and provide BLoCs
  runApp(
    RepositoryProvider(
      create: (_) => NotesRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotesBloc(context.read<NotesRepository>())
              ..add(LoadNotes()),
          ),
          BlocProvider(
            create: (context) => ClipboardBloc(clipboardBox: clipboardBox),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

/// Root widget for the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note This Point',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ).data,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
        ),
      ),
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
      // Add routes for navigation
      routes: {
        '/note_detail': (context) {
          final note = ModalRoute.of(context)!.settings.arguments as NoteItem;
          return NoteDetailPage(note: note);
        },
      },
      // Handle dynamic routes
      onGenerateRoute: (settings) {
        if (settings.name == '/clipboard_detail') {
          final item = settings.arguments as NoteItem;
          return MaterialPageRoute(
            builder: (context) => ClipboardDetailPage(item: item),
          );
        }
        return null;
      },
    );
  }
}

// Optional: Add app lifecycle observer for clipboard monitoring
class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  
  const AppLifecycleObserver({
    super.key,
    required this.child,
  });

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final clipboardBloc = context.read<ClipboardBloc>();
    
    switch (state) {
      case AppLifecycleState.resumed:
        // Start monitoring clipboard when app is in foreground
        clipboardBloc.add(MonitorClipboard());
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        // Stop monitoring when app goes to background
        clipboardBloc.add(StopMonitoringClipboard());
        break;
      case AppLifecycleState.hidden:
        // Handle hidden state if needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}