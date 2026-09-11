import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../manager/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  String _formatPrayerTime(String timeStr, BuildContext context) {
    try {
      final parts = timeStr.trim().split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0].trim());
        final minute = parts[1].trim().split(' ')[0].padLeft(2, '0');
        final isPm = hour >= 12;
        if (hour > 12) hour -= 12;
        if (hour == 0) hour = 12;
        final hourStr = hour.toString().padLeft(2, '0');
        final isArabic = context.locale.languageCode == 'ar';
        final period = isArabic ? (isPm ? 'م' : 'ص') : (isPm ? 'PM' : 'AM');
        return '$hourStr:$minute $period';
      }
    } catch (_) {}
    return timeStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildNextPrayerCard(context, state),
                  const SizedBox(height: 16),
                  _buildInfoCards(context, state),
                  const SizedBox(height: 24),
                  _buildQuoteCard(context),
                  const SizedBox(height: 28),
                  Text(
                    'home_view.services_title'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  _buildServicesGrid(context),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;

            case 1:
              Navigator.pushReplacementNamed(
                context,
                RoutesName.quran,
              );
              break;

            case 2:
              Navigator.pushReplacementNamed(
                context,
                RoutesName.settings,
              );
              break;

            case 3:
              Navigator.pushReplacementNamed(
                context,
                RoutesName.prayerTracker,
              );
              break;

            case 4:
              Navigator.pushReplacementNamed(
                context,
                RoutesName.myAzkar,
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'home_view.greeting'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text(
                'home_view.welcome_message'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.person_outline,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildNextPrayerCard(BuildContext context, HomeState state) {
    final theme = Theme.of(context);
    final isLoaded = state is HomeLoaded;
    final nextPrayer = isLoaded ? state.nextPrayer : null;

    final prayerName = nextPrayer != null
        ? 'prayers_view.${nextPrayer.prayerKey}'.tr()
        : 'home_view.next_prayer_fallback'.tr();

    final prayerTime = nextPrayer != null
        ? _formatPrayerTime(nextPrayer.prayerTime, context)
        : '—';

    final countdown = nextPrayer != null
        ? nextPrayer.formattedCountdown
        : '—';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC8DD),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFC8DD).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.access_time_filled,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'home_view.next_prayer_title'.tr(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (nextPrayer != null && nextPrayer.isTomorrow)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'home_view.tomorrow_badge'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prayerName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prayerTime,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.black87.withValues(alpha: 0.75),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'home_view.remaining_badge'.tr(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      countdown,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context, HomeState state) {
    final hijriDate = state is HomeLoaded
        ? state.prayerTimings.hijriDate
        : 'home_view.hijri_date_fallback'.tr();

    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            context: context,
            title: 'home_view.hijri_date_title'.tr(),
            value: hijriDate,
            subtitle: 'home_view.hijri_year_suffix'.tr(),
            color: const Color(0xFFCDB4DB),
            icon: Icons.calendar_month_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.black87,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFBDE0FE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.format_quote,
            size: 32,
            color: Colors.black54,
          ),
          const SizedBox(height: 12),
          Text(
            'home_view.quran_verse_quote'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        _buildServiceCard(
          context: context,
          title: 'home_view.service_quran'.tr(),
          icon: Icons.menu_book_outlined,
          color: const Color(0xFFA2D2FF),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesName.quran,
            );
          },
        ),
        _buildServiceCard(
          context: context,
          title: 'home_view.service_azkar'.tr(),
          icon: Icons.auto_awesome_outlined,
          color: const Color(0xFFFFC8DD),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesName.azkar,
            );
          },
        ),
        _buildServiceCard(
          context: context,
          title: 'home_view.service_my_azkar'.tr(),
          icon: Icons.favorite_border,
          color: const Color(0xFFFFAFCC),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesName.myAzkar,
            );
          },
        ),
        _buildServiceCard(
          context: context,
          title: 'home_view.service_prayer_times'.tr(),
          icon: Icons.access_time_outlined,
          color: const Color(0xFFBDE0FE),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesName.prayers,
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.black87,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
