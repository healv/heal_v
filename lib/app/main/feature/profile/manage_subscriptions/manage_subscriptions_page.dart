import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:heal_v/app/main/feature/profile/manage_subscriptions/manage_subscriptions_page_bloc.dart';
import 'package:heal_v/app/main/model/currency_enum.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plan_dto.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/tools/localization_tools.dart';
import '../../../../../common/utils/constants.dart';
import '../../../../../feature/heal_v/api/auth/utils/auth_constants.dart';

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
          tr('manageSubscriptions'),
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
    return BlocSelector<ManageSubscriptionsPageBloc, ManageSubscriptionsPageState, List<SubscriptionPlanItemDto>>(
      selector: (ManageSubscriptionsPageState state) => state.plans ?? [],
      builder: (context, plans) {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
          child: _planItemsListView(context, plans),
        );
      },
    );
  }

  Widget _planItemsListView(BuildContext context, List<SubscriptionPlanItemDto> plans) {
    return ListView.separated(
      itemCount: plans.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 24.0),
      itemBuilder: (_, index) {
        return _planItem(context, index, plans[index]);
      },
    );
  }

  Widget _planItem(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: index == 0 ? context.onBackground.withValues(alpha: 0.3) : context.quizDialogItemColor),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _planItemTitleContainer(context, index, plan),
          const SizedBox(height: 12.0),
          _planItemDescriptionContainer(context, index, plan),
          const SizedBox(height: 12.0),
          _planItemAdvantages(context, index, plan),
          const SizedBox(height: 12.0),
          _selectPlanButton(context, index, plan),
        ],
      ),
    );
  }

  Widget _planItemTitleContainer(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: index == 0 ? context.onBackground.withValues(alpha: 0.1) : context.primary.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _planItemTitleImage(context, index, plan),
          _planItemTitle(context, index, plan),
        ],
      ),
    );
  }

  Widget _planItemTitleImage(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return index == 0 || plan.images == null || plan.images?.isEmpty == true
        ? const SizedBox.shrink()
        : Container(
            height: 16.0,
            width: 16.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  '${AuthConstants.baseHost}${plan.images!.first}',
                ),
              ),
            ),
          );
  }

  Widget _planItemTitle(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return Text(
      index == 0 ? tr('freePlan') : plan.name ?? emptyString,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        color: index == 0 ? context.onBackground.withValues(alpha: 0.8) : context.primary.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _planItemDescriptionContainer(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: index == 0
              ? [
                  context.onBackground.withValues(alpha: 0.1),
                  context.onBackground.withValues(alpha: 0.1),
                ]
              : [
                  context.quizDialogItemColor.withValues(alpha: 0.3),
                  context.primary.withValues(alpha: 0.3),
                ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _planItemPrice(context, index, plan),
          const SizedBox(width: 16.0),
          _planItemDescription(context, index, plan),
        ],
      ),
    );
  }

  Widget _planItemPrice(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return Text(
      index == 0 ? '${CurrencyEnum.usd.symbol} 0' : '${CurrencyEnum.from(plan.prices?.first.currency)?.symbol ?? CurrencyEnum.usd.symbol} ${plan.prices?.first.amount ?? 0}',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: index == 0
                ? [
                    context.onBackground,
                    context.onBackground,
                  ]
                : [
                    context.quizDialogItemColor,
                    context.primary,
                  ],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      ),
    );
  }

  Widget _planItemDescription(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    final text = index == 0 ? tr('chargedMonthly') : plan.description ?? emptyString;
    final words = text.split(' ');

    List<String> line1 = [];
    List<String> line2 = [];

    words.forEachIndexed((index, word) {
      if (index < words.length / 2 - 1) {
        line1.add(word);
      } else {
        line2.add(word);
      }
    });

    return Text(
      '${line1.join(' ')}\n${line2.join(' ')}',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        letterSpacing: 0.2,
        color: context.onBackground,
      ),
    );
  }

  Widget _planItemAdvantages(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    final List<String> advantages = index == 0
        ? [
            tr('stepByStepLearning'),
            tr('quizzesAndReflectionExercises'),
            tr('dailyReminders'),
          ]
        : [];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: advantages.mapIndexed((advantageIndex, advantage) {
        if (advantageIndex == advantages.length - 1) {
          return _planItemAdvantage(context, index, advantages[advantageIndex]);
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _planItemAdvantage(context, index, advantages[advantageIndex]),
              const SizedBox(
                height: 12.0,
              )
            ],
          );
        }
      }).toList(),
    );
  }

  Widget _planItemAdvantage(BuildContext context, int index, String advantage) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIcons.checkMark.svgAsset(
          width: 16.0,
          height: 16.0,
          colorFilter: ColorFilter.mode(index == 0 ? context.onBackground.withValues(alpha: 0.3) : context.primary, BlendMode.srcIn),
        ),
        const SizedBox(width: 8.0),
        Text(
          advantage,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            letterSpacing: 0.2,
            color: index == 0 ? context.onBackground.withValues(alpha: 0.3) : context.onBackground,
          ),
        ),
      ],
    );
  }

  Widget _selectPlanButton(BuildContext context, int index, SubscriptionPlanItemDto plan) {
    return index == 0
        ? const SizedBox.shrink()
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(tr('selectPlan'),
                  style: TextStyle(
                    color: context.background,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  )),
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
        // await stripe.initPaymentSheet(
        //   paymentSheetParameters: SetupPaymentSheetParameters(
        //     merchantDisplayName: '<Application package name>',
        //     returnURL: 'flutterstripe://redirect',
        //     customerId: effect.createSubscriptionDto?.debug?.customerId,
        //     paymentIntentClientSecret: effect.createSubscriptionDto?.clientSecret,
        //     // customerEphemeralKeySecret: paymentIntent.ephemeralKey,
        //     billingDetailsCollectionConfiguration: billingDetailsCollectionConfiguration,
        //     billingDetails: billingDetails,
        //     // googlePay: PaymentSheetGooglePay(
        //     //   merchantCountryCode: paymentIntent.merchantCountryCode,
        //     //   // testEnv: 'true for live mode, false for test mode',
        //     // ),
        //     // applePay: PaymentSheetApplePay(
        //     //   merchantCountryCode: paymentIntent.merchantCountryCode,
        //     // ),
        //     // style: ThemeMode.light,
        //     appearance: appearance,
        //   ),
        // );
        await Stripe.instance.presentPaymentSheet();
        break;
    }
  }

  PaymentSheetAppearance get appearance {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return PaymentSheetAppearance(
      colors: PaymentSheetAppearanceColors(
        primary: context.primary,
        primaryText: context.primary,
        secondaryText: colorScheme.secondary,
        background: context.background,
        icon: context.primary,
        error: colorScheme.error,
        placeholderText: colorScheme.secondary,
        componentText: colorScheme.secondary,
        componentBorder: theme.dividerColor,
        componentDivider: theme.dividerColor,
        componentBackground: context.background,
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
