import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../bloc/verification/verification_bloc.dart';
import '../bloc/verification/verification_event.dart';
import '../bloc/verification/verification_state.dart';
import '../../domain/entities/verification_request.dart';

class VerificationRequestsPage extends StatelessWidget {
  const VerificationRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final profileBloc = context.read<ProfileBloc>();
        final user = (profileBloc.state as ProfileLoaded).user;
        final bloc = getIt<VerificationBloc>();
        bloc.add(VerificationRequestsLoadRequested(
          isFoodSaver: user.isFoodSaver,
        ));
        return bloc;
      },
      child: const VerificationRequestsView(),
    );
  }
}

class VerificationRequestsView extends StatefulWidget {
  const VerificationRequestsView({super.key});

  @override
  State<VerificationRequestsView> createState() =>
      _VerificationRequestsViewState();
}

class _VerificationRequestsViewState extends State<VerificationRequestsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final profileBloc = context.read<ProfileBloc>();
      final user = (profileBloc.state as ProfileLoaded).user;
      context.read<VerificationBloc>().add(
            VerificationRequestsLoadMoreRequested(isFoodSaver: user.isFoodSaver),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAF9).withValues(alpha: 0.8),
          ),
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
                        color: const Color(0xFF131615),
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: Text(
                          'Verification Requests',
                          style: TextStyle(
                            color: const Color(0xFF131615),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
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
                  backgroundColor: const Color(0xFF2D6C50),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<VerificationBloc>().add(const VerificationMessageCleared());
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<VerificationBloc>().add(const VerificationMessageCleared());
            }
          }
        },
        builder: (context, state) {
          if (state is VerificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VerificationError) {
            return Center(child: Text(state.message));
          }

          if (state is VerificationLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                final profileBloc = context.read<ProfileBloc>();
                final user = (profileBloc.state as ProfileLoaded).user;
                context.read<VerificationBloc>().add(
                      VerificationRequestsLoadRequested(
                        isFoodSaver: user.isFoodSaver,
                      ),
                    );
              },
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.all(16.w),
                children: [
                  // Trust Badge Hero Card
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(32.r),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user,
                              size: 16.sp,
                              color: const Color(0xFF006C49),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'TRUSTED CONTRIBUTOR',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF006C49),
                                letterSpacing: 0.5.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "You're a Community Pillar",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF00422B),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "You've been asked to verify these neighbors based on your high Trust Score. Help us grow a sustainable community.",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF3C4A42),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'PENDING REQUESTS (${state.totalCount})',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6C7A71),
                      letterSpacing: 1.3.w,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (state.requests.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Text(
                          'No pending requests',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF6C7A71),
                          ),
                        ),
                      ),
                    ),
                  ...state.requests.map((request) {
                    final profileBloc = context.read<ProfileBloc>();
                    final user = (profileBloc.state as ProfileLoaded).user;
                    // If I am food saver, I see requester details.
                    // If I am requester, I see food saver details.
                    final displayUser = user.isFoodSaver
                        ? request.requester
                        : request.targetFoodSaver;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.r),
                          border: Border.all(
                            color: const Color(0xFFBBCABF).withValues(alpha: 0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 24,
                              offset: const Offset(0, 4),
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
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: const Color(0xFFF0F1F2),
                                    image: displayUser?.avatarUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              displayUser!.avatarUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: displayUser?.avatarUrl == null
                                      ? Center(
                                          child: Icon(
                                            Icons.person,
                                            color: const Color(0xFFBBCABF),
                                            size: 24.sp,
                                          ),
                                        )
                                      : null,
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    displayUser?.name ?? 'Unknown User',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF191C1D),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (user.isFoodSaver) ...[
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: state.updatingRequestId != null
                                          ? null
                                          : () {
                                              context.read<VerificationBloc>().add(
                                                    VerificationRequestStatusUpdateRequested(
                                                      requestId: request.id,
                                                      status: VerificationRequestStatus.approved,
                                                    ),
                                                  );
                                            },
                                      child: Container(
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2D6C50),
                                          borderRadius:
                                              BorderRadius.circular(9999.r),
                                        ),
                                        child: Center(
                                          child: state.updatingRequestId ==
                                                  request.id
                                              ? SizedBox(
                                                  width: 20.w,
                                                  height: 20.w,
                                                  child: const CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Text(
                                                  'Verify Member',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    letterSpacing: 0.65.w,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<VerificationBloc>().add(
                                              VerificationRequestDismissed(
                                                requestId: request.id,
                                              ),
                                            );
                                      },
                                      child: Container(
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9999.r),
                                          border: Border.all(
                                            color: const Color(0xFFBBCABF),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Not Now',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF3C4A42),
                                              letterSpacing: 0.65.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              SizedBox(height: 12.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(request.status)
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(99.r),
                                  ),
                                  child: Text(
                                    request.status.name.toUpperCase(),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor(request.status),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                  if (state.isLoadingMore)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Color _getStatusColor(VerificationRequestStatus status) {
    switch (status) {
      case VerificationRequestStatus.approved:
        return const Color(0xFF10B981);
      case VerificationRequestStatus.rejected:
        return const Color(0xFFEF4444);
      case VerificationRequestStatus.pending:
        return const Color(0xFFF59E0B);
    }
  }
}
