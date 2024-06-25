import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/events_panel.dart';
import 'package:pamphlets_management/features/info_event/presentation/bloc/bloc/info_event_bloc.dart';
import 'package:pamphlets_management/features/info_event/presentation/pages/info_event_page.dart';
import 'package:pamphlets_management/features/log_out/presentation/bloc/log_out_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/pages/info_metric_page.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/metrics_panel.dart';
import 'package:pamphlets_management/features/settings/presentation/pages/setting_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String _HOME_VIEW_NAME_ROUTE = '/homeView';
  final _navigatorKey = GlobalKey<NavigatorState>();

  bool _isMetricOptionSelected = false;
  bool _isSettingsSelected = false;
  bool _isEventSelected = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: getAppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: EventsPanel(
                        isEventSelected: _isEventSelected,
                        onSelectEvent: _selectEvent,
                      ),
                    ),
                    PanelItem(
                      title: 'Métricas',
                      icon: Icons.bar_chart,
                      isSelected: _isMetricOptionSelected,
                      onSelectMetric: _selectMetric,
                    ),
                    PanelItem(
                      title: 'Configuraciones',
                      icon: Icons.settings,
                      isSelected: _isSettingsSelected,
                      onSelectMetric: _selectSettings,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: (_) => MaterialPageRoute(
                      settings: RouteSettings(name: _HOME_VIEW_NAME_ROUTE),
                      builder: (_) {
                        if (_isMetricOptionSelected) {
                          return const InfoMetricPage();
                        }

                        if (_isSettingsSelected) {
                          return const SettingPage();
                        }

                        return const InfoEventPage();
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0.2,
      automaticallyImplyLeading: false,
      title: Text(
        "Pamphlets",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () =>
              BlocProvider.of<LogOutBloc>(context).add(StartLogOut()),
          icon: const Icon(Icons.exit_to_app_rounded),
          label: const Text("Salir"),
        ),
      ],
    );
  }

  void _selectEvent(int eventId, int indexSelected) {
    context.read<InfoEventBloc>().add(InfoEventStart(eventId: eventId));

    _popUntilFirstPage();

    setState(() {
      _isMetricOptionSelected = false;
      _isSettingsSelected = false;
      _isEventSelected = true;
    });
  }

  void _selectMetric() {
    _popUntilFirstPage();

    setState(() {
      _isMetricOptionSelected = true;
      _isSettingsSelected = false;
      _isEventSelected = false;
    });
  }

  void _selectSettings() {
    _popUntilFirstPage();

    setState(() {
      _isMetricOptionSelected = false;
      _isSettingsSelected = true;
      _isEventSelected = false;
    });
  }

  void _popUntilFirstPage() {
    if (_navigatorKey.currentState != null) {
      _navigatorKey.currentState!
          .popUntil((route) => route.settings.name == _HOME_VIEW_NAME_ROUTE);
    }
  }
}
