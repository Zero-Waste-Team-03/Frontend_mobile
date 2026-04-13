import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../donations/domain/entities/donation.dart';
import '../../../donations/domain/entities/category.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/reservation_remote_data_source.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource? remoteDataSource;

  ReservationRepositoryImpl({this.remoteDataSource});

  // Placeholder data - will be replaced with actual GraphQL/API calls
  static final _placeholderDonations = [
    Donation(
      id: '1',
      title: '3x Sesame Bagels',
      description: 'Fresh sesame bagels from local bakery',
      quantity: 3,
      categoryId: 'category-1',
      category: const Category(id: 'category-1', name: 'Bakery Items'),
      condition: 'EXCELLENT',
      status: 'PUBLISHED',
      author: 'John Doe',
      imageUrl:
          'https://images.unsplash.com/photo-1585080876519-f21cc028cb53?w=400&h=400&fit=crop',
      latitude: 40.7128,
      longitude: -74.0060,
    ),
    Donation(
      id: '2',
      title: 'Fresh Salads',
      description: 'Assorted fresh salads, vegetables included',
      quantity: 5,
      categoryId: 'category-2',
      category: const Category(id: 'category-2', name: 'Vegetables'),
      condition: 'GOOD',
      status: 'RESERVED',
      author: 'Jane Smith',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=400&fit=crop',
      latitude: 40.7150,
      longitude: -74.0090,
    ),
    Donation(
      id: '3',
      title: 'Organic Apples',
      description: 'Organic red apples from local farm',
      quantity: 10,
      categoryId: 'category-3',
      category: const Category(id: 'category-3', name: 'Fruits'),
      condition: 'EXCELLENT',
      status: 'COMPLETED',
      author: 'Robert Johnson',
      imageUrl:
          'https://images.unsplash.com/photo-1560806674-9a308e375a00?w=400&h=400&fit=crop',
      latitude: 40.7100,
      longitude: -74.0080,
    ),
    Donation(
      id: '4',
      title: 'Milk Cartons',
      description: 'Unopened milk cartons, expires next week',
      quantity: 2,
      categoryId: 'category-4',
      category: const Category(id: 'category-4', name: 'Dairy'),
      condition: 'GOOD',
      status: 'EXPIRED',
      author: 'Maria Garcia',
      imageUrl:
          'https://images.unsplash.com/photo-1553531889-e6cf889fefee?w=400&h=400&fit=crop',
      latitude: 40.7160,
      longitude: -74.0100,
    ),
  ];

  @override
  Future<Either<Failure, List<Donation>>> getUserDonations({
    required String userId,
    String? status,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      var donations = _placeholderDonations;

      if (status != null && status.isNotEmpty) {
        donations = donations.where((d) => d.status == status).toList();
      }

      return Right(donations);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Donation>>> getUserReservations({
    required String userId,
    String? status,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Filter only reserved donations as reservations
      var donations = _placeholderDonations
          .where((d) => d.status == 'RESERVED' || d.status == 'COMPLETED')
          .toList();

      if (status != null && status.isNotEmpty) {
        donations = donations.where((d) => d.status == status).toList();
      }

      return Right(donations);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Donation>> getDonationDetails(
    String donationId,
  ) async {
    try {
      final donation = _placeholderDonations.firstWhere(
        (d) => d.id == donationId,
        orElse: () => throw ServerException('Donation not found'),
      );
      return Right(donation);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Reservation>> getReservationDetails(
    String reservationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final now = DateTime.now();
      final reservation = Reservation(
        id: reservationId,
        donationId: '2',
        beneficiaryId: 'beneficiary-1',
        donation: _placeholderDonations.firstWhere((d) => d.id == '2'),
        beneficiary: const User(
          id: 'beneficiary-1',
          name: 'Marcus',
          email: 'marcus@example.com',
          phoneNumber: '+1234567890',
          avatarUrl:
              'https://ui-avatars.com/api/?name=Marcus&background=random',
        ),
        status: ReservationStatus.confirmed,
        createdAt: now.subtract(const Duration(hours: 2)),
        confirmedAt: now.subtract(const Duration(hours: 1)),
        pickedUpAt: null,
        expiresAt: now.add(const Duration(hours: 1)),
      );
      return Right(reservation);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Reservation>> createReservation({
    required String donationId,
  }) async {
    // Try to use actual API if remote data source is available and endpoint is configured
    if (remoteDataSource != null) {
      try {
        final result = await remoteDataSource!.createReservation(
          donationId: donationId,
        );
        return Right(result.toEntity());
      } on ServerException catch (e) {
        // Log API error but fallback to placeholder data
        print('API Error: ${e.message}');
        // Continue to fallback instead of returning error
      } catch (e) {
        // Log any other error and fallback
        print('Unexpected error during API call: ${e.toString()}');
        // Continue to fallback instead of returning error
      }
    }

    // Fallback to placeholder data (always works)
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final donation = await getDonationDetails(donationId);

      return donation.fold((failure) => Left(failure), (donationData) {
        final reservation = Reservation(
          id: 'res-${DateTime.now().millisecondsSinceEpoch}',
          donationId: donationId,
          donation: donationData,
          status: ReservationStatus.reserved,
          createdAt: DateTime.now(),
        );
        return Right(reservation);
      });
    } catch (e) {
      return Left(
        ServerFailure('Failed to create reservation: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Reservation>> updateReservationStatus({
    required String reservationId,
    required String newStatus,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Placeholder: would update via API
      return Right(
        Reservation(
          id: reservationId,
          donationId: 'donation-1',
          beneficiaryId: 'beneficiary-1',
          status: ReservationStatus.confirmed,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getDonationReservations(
    String donationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final reservation = Reservation(
        id: 'res-1',
        donationId: donationId,
        beneficiaryId: 'beneficiary-1',
        status: ReservationStatus.confirmed,
        createdAt: DateTime.now(),
        confirmedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      );

      return Right([reservation]);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
