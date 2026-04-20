import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_icons.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_error_state.dart';
import '../../domain/entities/donation.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';
import '../widgets/donation_card_skeleton.dart';
import '../widgets/featured_donation_card.dart';
import '../widgets/standard_donation_card.dart';
import '../../../../shared/theme/app_colors.dart';

class DonationsListPage extends StatefulWidget {
  const DonationsListPage({super.key});

  @override
  State<DonationsListPage> createState() => _DonationsListPageState();
}

class _DonationsListPageState extends State<DonationsListPage> {
  static const String _filterAll = 'ALL';
  static const String _filterPublished = 'PUBLISHED';
  static const String _filterReserved = 'RESERVED';
  static const String _filterCompleted = 'COMPLETED';

  String _selectedFilter = _filterAll;
  String _searchQuery = '';
  double? _userLatitude;
  double? _userLongitude;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;

      setState(() {
        _userLatitude = position.latitude;
        _userLongitude = position.longitude;
      });

      context.read<DonationsBloc>().add(
        LoadDonationsEvent(
          latitude: _userLatitude,
          longitude: _userLongitude,
          radius: 10,
        ),
      );
    } catch (_) {
      // Keep browsing available even when location is unavailable.
    }
  }

  void _loadDonations() {
    context.read<DonationsBloc>().add(
      LoadDonationsEvent(
        latitude: _userLatitude,
        longitude: _userLongitude,
        radius: 10,
      ),
    );
  }

  List<Donation> _applyFilters(List<Donation> source) {
    final statusFiltered = _selectedFilter == _filterAll
        ? source
        : source
              .where(
                (donation) =>
                    donation.status.trim().toUpperCase() == _selectedFilter,
              )
              .toList();

    if (_searchQuery.trim().isEmpty) {
      return statusFiltered;
    }

    final query = _searchQuery.trim().toLowerCase();
    return statusFiltered
        .where(
          (donation) =>
              donation.title.toLowerCase().contains(query) ||
              donation.description.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => getIt<DonationsBloc>()
        ..add(
          LoadDonationsEvent(
            latitude: _userLatitude,
            longitude: _userLongitude,
            radius: 10,
          ),
        ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAF8),
        body: SafeArea(
          child: BlocBuilder<DonationsBloc, DonationsState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  _loadDonations();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPageHeader(),
                            _buildSearchField(),
                            SizedBox(height: 12.h),
                            _buildFilters(),
                          ],
                        ),
                      ),
                    ),
                    if (state is DonationsInitial || state is DonationsLoading)
                      _buildLoadingContent()
                    else if (state is DonationsError)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: AppErrorState(
                          message: state.message,
                          retryLabel: l10n.browseErrorRetry,
                          onRetry: _loadDonations,
                        ),
                      )
                    else if (state is DonationsLoaded)
                      ..._buildLoadedContent(state)
                    else
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Browse donations',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.primary,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AuthColors.primary,
            size: AppDimensions.iconSize.sp,
          ),
          style: IconButton.styleFrom(
            backgroundColor: AuthColors.lightGrayBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () {
            context.push('/notifications');
          },
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    final l10n = AppLocalizations.of(context);

    return TextField(
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: l10n.browseSearchHint,
        prefixIcon: const Icon(AppIcons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    final l10n = AppLocalizations.of(context);

    final filters = [
      (_filterAll, l10n.browseFilterAll),
      (_filterPublished, l10n.browseFilterPublished),
      (_filterReserved, l10n.browseFilterReserved),
      (_filterCompleted, l10n.browseFilterCompleted),
    ];

    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        itemCount: filters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = _selectedFilter == filter.$1;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ChoiceChip(
              showCheckmark: false,
              selected: selected,
              label: Text(filter.$2),
              onSelected: (_) {
                setState(() {
                  _selectedFilter = filter.$1;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary.withValues(alpha: 0.12),
              side: BorderSide(
                color: selected ? AppColors.primary : const Color(0xFFE2E8F0),
              ),
              labelStyle: TextStyle(
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  SliverList _buildLoadingContent() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
          child: SizedBox(
            height: 186.h,
            child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) =>
                  const DonationCardSkeleton(featured: true),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 90.h),
          child: Column(
            children: List.generate(4, (_) => const DonationCardSkeleton()),
          ),
        ),
      ]),
    );
  }

  List<Widget> _buildLoadedContent(DonationsLoaded state) {
    final l10n = AppLocalizations.of(context);
    final featured = _applyFilters(state.featuredDonations);
    final standard = _applyFilters(state.standardDonations);

    if (featured.isEmpty && standard.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: AppEmptyState(
            title: l10n.browseEmptyTitle,
            description: l10n.browseEmptyDescription,
          ),
        ),
      ];
    }

    return [
      if (featured.isNotEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 6.h),
            child: _buildSectionHeader(
              l10n.browseFeaturedSectionTitle,
              l10n.browseFeaturedSectionSubtitle,
            ),
          ),
        ),
      if (featured.isNotEmpty)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 210.h,
            child: ListView.builder(
              itemCount: featured.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16.w, right: 4.w),
              itemBuilder: (context, index) {
                final donation = featured[index];
                return FeaturedDonationCard(
                  donation: donation,
                  userLatitude: _userLatitude,
                  userLongitude: _userLongitude,
                  onTap: () {
                    context.push('/donation-details', extra: donation);
                  },
                );
              },
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
          child: _buildSectionHeader(
            l10n.browseStandardSectionTitle,
            l10n.browseStandardSectionSubtitle,
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 92.h),
        sliver: SliverList.builder(
          itemCount: standard.length,
          itemBuilder: (context, index) {
            final donation = standard[index];
            return StandardDonationCard(
              donation: donation,
              userLatitude: _userLatitude,
              userLongitude: _userLongitude,
              onTap: () {
                context.push('/donation-details', extra: donation);
              },
            );
          },
        ),
      ),
    ];
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
