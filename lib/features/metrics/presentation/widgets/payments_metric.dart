import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/bar_chart_payment_networking.dart';
import 'package:pamphlets_management/utils/styles/web_theme.dart';

import '../bloc/payment_bloc.dart';
import 'app_colors.dart';
import 'bar_chart_payment.dart';
import 'bar_chart_payment_events.dart';
import 'date_selectors.dart';
import 'legend_item.dart';

class PaymentsMetric extends StatefulWidget {
  const PaymentsMetric({super.key});

  @override
  State<PaymentsMetric> createState() => _PaymentsMetricState();
}

class _PaymentsMetricState extends State<PaymentsMetric> {
  int currentPageBarCharPayment = 0;
  int currentPageBarCharPaymentEvents = 0;
  int currentPageBarCharPaymentNetworking = 0;

  void nextPageBarCharPaymentEvent() {
    setState(() {
      currentPageBarCharPaymentEvents++;
    });
  }

  void previousPageBarCharPaymentEvent() {
    setState(() {
      if (currentPageBarCharPaymentEvents > 0) {
        currentPageBarCharPaymentEvents--;
      }
    });
  }

  void nextPageBarCharPaymentNetworking() {
    setState(() {
      currentPageBarCharPaymentNetworking++;
    });
  }

  void previousPageBarCharPaymentNetworking() {
    setState(() {
      if (currentPageBarCharPaymentNetworking > 0) {
        currentPageBarCharPaymentNetworking--;
      }
    });
  }

  void nextPageBarCharPayment() {
    setState(() {
      currentPageBarCharPayment++;
    });
  }

  void previousPageBarCharPayment() {
    setState(() {
      if (currentPageBarCharPayment > 0) {
        currentPageBarCharPayment--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state is PaymentSuccess) {
          final totalPaymentEvents = state.listPaymentEvents.length;
          final totalPages =
              totalPaymentEvents ~/ 5 + (totalPaymentEvents % 5 != 0 ? 1 : 0);
          final hastNextPagePaymentEvent =
              currentPageBarCharPaymentEvents < totalPages - 1;
          final hasNextPagePayments =
              currentPageBarCharPayment < totalPages - 1;
          final hasNextPageNetworkingPayment =
              currentPageBarCharPaymentNetworking < totalPages - 1;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Esta pantalla presenta métricas relacionadas con los pagos realizados por eventos, brindando una visión detallada de la actividad financiera. El primer gráfico muestra la cantidad total de pagos realizados por eventos, incluyendo aquellos asociados con el acceso al evento y los pagos por el servicio de networking. El segundo gráfico se enfoca específicamente en la cantidad de pagos relacionados con el acceso al evento. Finalmente, el tercer gráfico presenta las cantidades de pagos realizados exclusivamente por el servicio de networking en cada evento',
                    style: WebTheme.getTheme().textTheme.bodyLarge),
                const SizedBox(height: 40),
                DateSelectorsWidget(
                  onPressedFilter: (startDate, endDate) {
                    BlocProvider.of<PaymentBloc>(context).add(
                        LoadPayment(startDate: startDate, endDate: endDate));
                  },
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        'Pagos realizados por evento',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Referencia: '),
                        LegendItem(color: Colors.grey, text: 'Inactivo'),
                        SizedBox(width: 20.0),
                        LegendItem(
                            color: AppColors.contentColorCyan, text: 'Activo')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: size.width * 1,
                    height: size.height * 0.4,
                    child: BarCharPayment(
                      dataMetric: state.listPaymentDateEvents,
                      itemsPerPage: 5,
                      currentPage: currentPageBarCharPayment,
                    )),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPageBarCharPayment > 0
                          ? previousPageBarCharPayment
                          : null,
                    ),
                    Text('Página ${currentPageBarCharPayment + 1}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed:
                          hasNextPagePayments ? nextPageBarCharPayment : null,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.08),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        'Pagos realizados por acceso al evento',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Referencia: '),
                        SizedBox(width: 20.0),
                        LegendItem(color: Colors.grey, text: 'Inactivo'),
                        SizedBox(width: 20.0),
                        LegendItem(
                            color: AppColors.contentColorCyan, text: 'Activo')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: size.width * 1,
                    height: size.height * 0.4,
                    child: BarCharPaymentEvents(
                      dataMetric: state.listPaymentEvents,
                      itemsPerPage: 5,
                      currentPage: currentPageBarCharPaymentEvents,
                    )),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPageBarCharPaymentEvents > 0
                          ? previousPageBarCharPaymentEvent
                          : null,
                    ),
                    Text('Página ${currentPageBarCharPaymentEvents + 1}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: hastNextPagePaymentEvent
                          ? nextPageBarCharPaymentEvent
                          : null,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.08),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        'Pagos por servicio de networking al evento',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Referencia: '),
                        SizedBox(width: 20.0),
                        LegendItem(color: Colors.grey, text: 'Inactivo'),
                        SizedBox(width: 20.0),
                        LegendItem(
                            color: AppColors.contentColorCyan, text: 'Activo')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: size.width * 1,
                    height: size.height * 0.4,
                    child: BarCharPaymentNetworking(
                      dataMetric: state.listPaymentNetworking,
                      itemsPerPage: 5,
                      currentPage: currentPageBarCharPaymentNetworking,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPageBarCharPaymentNetworking > 0
                          ? previousPageBarCharPaymentNetworking
                          : null,
                    ),
                    Text('Página ${currentPageBarCharPaymentNetworking + 1}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: hasNextPageNetworkingPayment
                          ? nextPageBarCharPaymentNetworking
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is PaymentLoading) {
          return SizedBox(
            height: size.height * 0.5,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (state is PaymentFailure) {
          return SizedBox(
            height: size.height * 0.5,
            child: const Center(
              child: Text('FALLÓ EN LA CARGA DE LOS DATOS'),
            ),
          );
        }
        return SizedBox(
          height: size.height * 0.5,
          child: const Center(
            child: Text('NO FUE POSIBLE SOLICITAR LOS DATOS'),
          ),
        );
      },
    );
  }
}
