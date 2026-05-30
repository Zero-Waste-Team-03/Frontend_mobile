import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection.dart';
import '../bloc/verification/verification_bloc.dart';
import '../bloc/verification/verification_event.dart';
import '../bloc/verification/verification_state.dart';
import '../../../../shared/theme/app_colors.dart';

class FindVerifierPage extends StatelessWidget {
  const FindVerifierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<VerificationBloc>();
        bloc.add(const VerificationSearchRequested());
        return bloc;
      },
      child: const FindVerifierView(),
    );
  }
}

class FindVerifierView extends StatefulWidget {
  const FindVerifierView({super.key});

  @override
  State<FindVerifierView> createState() => _FindVerifierViewState();
}

class _FindVerifierViewState extends State<FindVerifierView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<VerificationBloc>().add(
        VerificationSearchLoadMoreRequested(search: _searchController.text),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: Container(
          color: colors.background,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: colors.textPrimary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: Text(
                          'Verification',
                          style: GoogleFonts.inter(
                            color: colors.primary,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerificationLoaded) {
            if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: colors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<VerificationBloc>().add(
                const VerificationMessageCleared(),
              );
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: colors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<VerificationBloc>().add(
                const VerificationMessageCleared(),
              );
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        'Find Members to verify you',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          context.read<VerificationBloc>().add(
                            VerificationSearchRequested(search: value),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by name or badge ID...',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: colors.inputBorder,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 12.w),
                            child: Icon(
                              Icons.search,
                              color: colors.inputText,
                              size: 18.sp,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 46.w),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 17.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(VerificationState state) {
    final colors = context.themeColors;
    if (state is VerificationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is VerificationLoaded) {
      if (state.searchResults.isEmpty && !state.isSearching) {
        return _buildEmptyState();
      }

      return ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 128.h),
        itemCount: state.searchResults.length + (state.isSearching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.searchResults.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          final user = state.searchResults[index];
          final isCreating = state.creatingRequestId == user.id;

          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: colors.inputBorder.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.background,
                        image: user.avatarUrl != null
                            ? DecorationImage(
                                image: NetworkImage(user.avatarUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: user.avatarUrl == null
                          ? Center(
                              child: Icon(
                                Icons.person,
                                color: colors.inputBorder,
                                size: 28.sp,
                              ),
                            )
                          : null,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name ?? 'Unknown',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'SCORE: ${user.reputationScore}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.primary,
                              letterSpacing: 0.6.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: isCreating
                      ? null
                      : () {
                          context.read<VerificationBloc>().add(
                            VerificationRequestCreationRequested(
                              targetFoodSaverId: user.id,
                            ),
                          );
                        },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: isCreating
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Request Connection',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyState() {
    final colors = context.themeColors;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.lightGreenBackground.withValues(alpha: 0.3),
              ),
              child: Center(
                child: Icon(
                  Icons.search_off,
                  size: 40.sp,
                  color: colors.primary,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Ready to Apply?',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Search for friends or food savers to request to verify you.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
