import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:heal_v/app/main/feature/profile/manage_subscriptions/manage_subscriptions_page_bloc.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/tools/localization_tools.dart';

class ManageSubscriptionsPage extends StatefulWidget {
  const ManageSubscriptionsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ManageSubscriptionsPageState();
}

class _ManageSubscriptionsPageState extends BlocDependentSideEffectState<ManageSubscriptionsPage, ManageSubscriptionsPageBloc, ManageSubscriptionsPageEffect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.center,
          tr('manageSubscription'),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: context.onBackground,
          ),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          context.read<ManageSubscriptionsPageBloc>().add(ManageSubscriptionsPageEvent.createSubscription());
        },
        child: Text('Test Stripe'),
      ),
    );
  }

  @override
  Future<void> handleSideEffect(ManageSubscriptionsPageEffect effect) async {
    switch (effect) {
      case SubscriptionCreated():
        final stripe = Stripe.instance;
        final authBloc = context.read<AuthBloc>();
        final billingDetails = BillingDetails(
          email: authBloc.state.user?.email,
          name: authBloc.state.user?.name,
          // phone: authBloc.state.user?.,
        );
        await stripe.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: '<Application package name>',
            returnURL: 'flutterstripe://redirect',
            customerId: effect.createSubscriptionDto?.debug?.customerId,
            paymentIntentClientSecret: effect.createSubscriptionDto?.clientSecret,
            // customerEphemeralKeySecret: paymentIntent.ephemeralKey,
            billingDetailsCollectionConfiguration: billingDetailsCollectionConfiguration,
            billingDetails: billingDetails,
            // googlePay: PaymentSheetGooglePay(
            //   merchantCountryCode: paymentIntent.merchantCountryCode,
            //   // testEnv: 'true for live mode, false for test mode',
            // ),
            // applePay: PaymentSheetApplePay(
            //   merchantCountryCode: paymentIntent.merchantCountryCode,
            // ),
            // style: ThemeMode.light,
            appearance: appearance,
          ),
        );
        await Stripe.instance.presentPaymentSheet();
        break;
    }
  }

  PaymentSheetAppearance get appearance {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return PaymentSheetAppearance(
      colors: PaymentSheetAppearanceColors(
        primary: colorScheme.primary,
        primaryText: colorScheme.primary,
        secondaryText: colorScheme.secondary,
        background: colorScheme.background,
        icon: colorScheme.primary,
        error: colorScheme.error,
        placeholderText: colorScheme.secondary,
        componentText: colorScheme.secondary,
        componentBorder: theme.dividerColor,
        componentDivider: theme.dividerColor,
        componentBackground: colorScheme.background,
      ),
      primaryButton: PaymentSheetPrimaryButtonAppearance(
        colors: PaymentSheetPrimaryButtonTheme(
          light: PaymentSheetPrimaryButtonThemeColors(
            text: colorScheme.secondary,
          ),
          dark: PaymentSheetPrimaryButtonThemeColors(
            text: colorScheme.secondary,
          ),
        ),
        shapes: const PaymentSheetPrimaryButtonShape(borderWidth: 0),
      ),
    );
  }

  final billingDetailsCollectionConfiguration = const BillingDetailsCollectionConfiguration(
    name: CollectionMode.always,
    email: CollectionMode.always,
    address: AddressCollectionMode.full,
    attachDefaultsToPaymentMethod: true,
  );
}
