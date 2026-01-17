import 'package:flutter/material.dart';
import 'package:core/libs.dart';
import 'package:order/order.dart';

// Thin wrapper screens to chain Delivery 2 -> 8 widgets into a flow.
// These are purely UI navigational connectors; data wiring can be added later.

class DeliveryAddressStepScreen extends StatelessWidget {
  const DeliveryAddressStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryAddressWidget(
            onSelectAddress: (_) => GoRouter.of(context).push('/order/delivery/vehicle'),
            onChooseOnMap: () => GoRouter.of(context).push('/order/delivery/vehicle'),
          ),
        ),
      ),
    );
  }
}

class DeliveryVehicleSelectionStepScreen extends StatelessWidget {
  const DeliveryVehicleSelectionStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryVehicleSelectionWidget(
            onContinue: () => GoRouter.of(context).push('/order/delivery/package'),
          ),
        ),
      ),
    );
  }
}

class DeliveryPackageDetailsStepScreen extends StatelessWidget {
  const DeliveryPackageDetailsStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryPackageDetailsWidget(
            onContinue: () => GoRouter.of(context).push('/order/delivery/price'),
          ),
        ),
      ),
    );
  }
}

class DeliveryPriceEstimateStepScreen extends StatelessWidget {
  const DeliveryPriceEstimateStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryPriceEstimateWidget(
            onContinue: () => GoRouter.of(context).push('/order/delivery/tracking'),
          ),
        ),
      ),
    );
  }
}

class DeliveryOverviewStepScreen extends StatelessWidget {
  const DeliveryOverviewStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryOverviewWidget(
            onStart: () => GoRouter.of(context).push('/order/delivery'),
          ),
        ),
      ),
    );
  }
}

class DeliveryTrackingStepScreen extends StatelessWidget {
  const DeliveryTrackingStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DeliveryTrackingWidget(
            onHelp: () => GoRouter.of(context).push('/order/delivery/final'),
            onCallDriver: () {},
            onContinue: () => GoRouter.of(context).push('/order/delivery/final'),
          ),
        ),
      ),
    );
  }
}
