import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:heal_v/app/main/feature/profile/manage_subscriptions/manage_subscriptions_page_bloc.dart';
import 'package:heal_v/app/main/model/currency_enum.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/common/utils/alert.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plans_dto.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../common/tools/localization_tools.dart';
import '../../../../../common/utils/constants.dart';
import '../../../../../common/widgets/loading_elevated_button.dart';
import '../../../../../feature/heal_v/api/auth/utils/auth_constants.dart';
import '../../../../../feature/heal_v/api/subscription/model/set_subscription_dto.dart';
import '../../../../../feature/heal_v/api/subscription/model/subscription_status_dto.dart';
import '../../../../../feature/heal_v/api/subscription/model/subscription_status_enum.dart';

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
    return BlocSelector<ManageSubscriptionsPageBloc, ManageSubscriptionsPageState, SubscriptionStatusDto?>(
      selector: (ManageSubscriptionsPageState state) => state.subscriptionStatusDto,
      builder: (context, subscriptionStatusDto) {
        final status = SubscriptionStatusEnum.from(subscriptionStatusDto?.status);
        switch (status) {
          case SubscriptionStatusEnum.active:
            return _activeSubscription(subscriptionStatusDto);
          case null || SubscriptionStatusEnum.incomplete || SubscriptionStatusEnum.pastDue:
            return _subscriptionPlans();
          case SubscriptionStatusEnum.canceled:
            if (subscriptionStatusDto?.cancelAtPeriodEnd == true) {
              return _activeSubscription(subscriptionStatusDto);
            } else {
              return _subscriptionPlans();
            }
        }
      },
    );
  }

  Widget _activeSubscription(SubscriptionStatusDto? subscriptionStatusDto) {
    final status = SubscriptionStatusEnum.from(subscriptionStatusDto?.status);
    return BlocSelector<ManageSubscriptionsPageBloc, ManageSubscriptionsPageState, SubscriptionPlanItemDto?>(
      selector: (ManageSubscriptionsPageState state) => state.plan,
      builder: (context, plan) {
        return plan == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    _planItem(context, false, plan, isActivePlan: true),
                    const SizedBox(height: 24),
                    if (status == SubscriptionStatusEnum.active) _cancelSubscriptionButton(context, plan) else _resumeSubscriptionButton(context, plan),
                  ],
                ),
              );
      },
    );
  }

  Widget _subscriptionPlans() {
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
        final isFreePlan = index == 0;
        return _planItem(context, isFreePlan, plans[index]);
      },
    );
  }

  Widget _planItem(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan, {bool isActivePlan = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: isFreePlan ? context.onBackground.withValues(alpha: 0.3) : context.quizDialogItemColor),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _planItemTitleContainer(context, isFreePlan, plan),
          const SizedBox(height: 12.0),
          _planItemDescriptionContainer(context, isFreePlan, plan, isActivePlan),
          const SizedBox(height: 12.0),
          _planItemAdvantages(context, isFreePlan, plan),
          if (!isActivePlan) ...[
            const SizedBox(height: 12.0),
            _selectPlanButton(context, isFreePlan, plan),
          ]
        ],
      ),
    );
  }

  Widget _planItemTitleContainer(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isFreePlan ? context.onBackground.withValues(alpha: 0.1) : context.primary.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _planItemTitleImage(context, isFreePlan, plan),
          _planItemTitle(context, isFreePlan, plan),
        ],
      ),
    );
  }

  Widget _planItemTitleImage(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    return isFreePlan || plan.images == null || plan.images?.isEmpty == true
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

  Widget _planItemTitle(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    return Text(
      isFreePlan ? tr('freePlan') : plan.name ?? emptyString,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        color: isFreePlan ? context.onBackground.withValues(alpha: 0.8) : context.primary.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _planItemDescriptionContainer(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan, bool isActivePlan) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isFreePlan
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _planItemPrice(context, isFreePlan, plan),
              if (!isActivePlan) ...[
                const SizedBox(width: 16.0),
                _planItemDescription(context, isFreePlan, plan),
              ]
            ],
          ),
          if (isActivePlan) ...[
            Text(
              '${tr('validUntil')}:',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                letterSpacing: 0.2,
                color: context.primary,
              ),
            ),
            Text(
              '${tr('nextBillingDate')}:',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                letterSpacing: 0.2,
                color: context.primary,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _planItemPrice(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    return Text(
      isFreePlan ? '${CurrencyEnum.usd.symbol} 0' : '${CurrencyEnum.from(plan.prices?.first.currency)?.symbol ?? CurrencyEnum.usd.symbol} ${plan.prices?.first.amount ?? 0}',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: isFreePlan
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

  Widget _planItemDescription(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    final text = isFreePlan ? tr('chargedMonthly') : plan.description ?? emptyString;
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

  Widget _planItemAdvantages(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    final List<String> advantages = isFreePlan
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
          return _planItemAdvantage(context, isFreePlan, advantages[advantageIndex]);
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _planItemAdvantage(context, isFreePlan, advantages[advantageIndex]),
              const SizedBox(
                height: 12.0,
              )
            ],
          );
        }
      }).toList(),
    );
  }

  Widget _planItemAdvantage(BuildContext context, bool isFreePlan, String advantage) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIcons.checkMark.svgAsset(
          width: 16.0,
          height: 16.0,
          colorFilter: ColorFilter.mode(isFreePlan ? context.onBackground.withValues(alpha: 0.3) : context.primary, BlendMode.srcIn),
        ),
        const SizedBox(width: 8.0),
        Text(
          advantage,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            letterSpacing: 0.2,
            color: isFreePlan ? context.onBackground.withValues(alpha: 0.3) : context.onBackground,
          ),
        ),
      ],
    );
  }

  Widget _selectPlanButton(BuildContext context, bool isFreePlan, SubscriptionPlanItemDto plan) {
    bool isSetSubscriptionLoading = false;
    return isFreePlan
        ? const SizedBox.shrink()
        : BlocSelector<ManageSubscriptionsPageBloc, ManageSubscriptionsPageState, bool>(
            selector: (ManageSubscriptionsPageState state) => state.isCreateSubscriptionLoading ?? false,
            builder: (BuildContext context, bool isCreateSubscriptionLoading) {
              if (isCreateSubscriptionLoading == false) {
                isSetSubscriptionLoading = false;
              }
              return SizedBox(
                width: double.infinity,
                child: LoadingElevatedButton(
                  progressIndicatorColor: Colors.white,
                  isLoading: isSetSubscriptionLoading,
                  onPressed: () {
                    final priceId = plan.prices?[0].id;
                    if (priceId != null && priceId.isNotEmpty == true) {
                      context.read<ManageSubscriptionsPageBloc>().add(ManageSubscriptionsPageEvent.createSubscription(priceId));
                      isSetSubscriptionLoading = true;
                    }
                  },
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
            },
          );
  }

  Widget _cancelSubscriptionButton(BuildContext context, SubscriptionPlanItemDto plan) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: () {
          showCancelSubscriptionDialog(() {
            context.read<ManageSubscriptionsPageBloc>().add(ManageSubscriptionsPageEvent.cancelSubscription());
          });
        },
        child: Text(
          tr('cancelSubscription'),
          style: TextStyle(
            color: context.background,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ));
  }

  Widget _resumeSubscriptionButton(BuildContext context, SubscriptionPlanItemDto plan) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: () {
          context.read<ManageSubscriptionsPageBloc>().add(ManageSubscriptionsPageEvent.resumeSubscription());
        },
        child: Text(
          tr('resumeSubscription'),
          style: TextStyle(
            color: context.background,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ));
  }

  @override
  Future<void> handleSideEffect(ManageSubscriptionsPageEffect effect) async {
    switch (effect) {
      case SubscriptionCreated():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            await showPaymentSheet(effect.createSubscriptionDto);
            break;
          case ResourceStatusEnum.error:
            break;
          case ResourceStatusEnum.loading:
            break;
        }
      case SubscriptionCancelled():
        break;
      case SubscriptionResumed():
        break;
    }
  }

  Future<void> showPaymentSheet(SetSubscriptionDto? createSubscriptionDto) async {
    final stripe = Stripe.instance;
    final authBloc = context.read<AuthBloc>();
    final billingDetails = BillingDetails(
      email: authBloc.state.user?.email,
      name: authBloc.state.user?.name,
      // phone: authBloc.state.user?.,
    );
    await stripe.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: tr('getHealVPlus'),
        returnURL: 'flutterstripe://redirect',
        customerId: createSubscriptionDto?.customerId,
        paymentIntentClientSecret: createSubscriptionDto?.clientSecret,
        customerEphemeralKeySecret: createSubscriptionDto?.customerEphemeralKeySecret,
        billingDetailsCollectionConfiguration: billingDetailsCollectionConfiguration,
        billingDetails: billingDetails,
        googlePay: PaymentSheetGooglePay(
          merchantCountryCode: createSubscriptionDto?.merchantCountryCode ?? emptyString,
          testEnv: kDebugMode ? true : false,
        ),
        applePay: PaymentSheetApplePay(
          merchantCountryCode: createSubscriptionDto?.merchantCountryCode ?? emptyString,
        ),
        style: ThemeMode.system,
        allowsDelayedPaymentMethods: true,
        // appearance: appearance,
      ),
    );
    try {
      await Stripe.instance.presentPaymentSheet();
      if (mounted) context.read<ManageSubscriptionsPageBloc>().add(ManageSubscriptionsPageEvent.getSubscriptionStatus());
      _showSuccessSnackBar();
    } catch (e) {
      log('$healVTag ${e.toString()}');
    }
  }

  _showSuccessSnackBar() {
    showTopSnackBar(
      Overlay.of(context),
      Material(
        color: Colors.transparent,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: context.onBackground.withValues(alpha: 0.1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 8),
              AppIcons.checked.svgAsset(
                width: 48,
                height: 48,
                colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${tr('success')}!',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tr('yourSubscriptionWasActivatedSuccessfully'),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        color: context.onBackground.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    // attachDefaultsToPaymentMethod: true,
  );
}
