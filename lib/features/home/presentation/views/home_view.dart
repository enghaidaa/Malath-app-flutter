import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildInfoCards(context),
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

  Widget _buildInfoCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            context: context,
            title: 'home_view.hijri_date_title'.tr(),
            value: '—',
            subtitle: 'home_view.hijri_year_suffix'.tr(),
            color: const Color(0xFFCDB4DB),
            icon: Icons.calendar_month_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            context: context,
            title: 'home_view.next_prayer_title'.tr(),
            value: '—',
            subtitle: 'home_view.next_prayer_subtitle'.tr(),
            color: const Color(0xFFFFC8DD),
            icon: Icons.access_time,
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
