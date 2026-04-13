# Reservation Feature Documentation

## Overview

The Reservation feature manages the flow between donors and beneficiaries for food donations. It includes tracking reservations, managing donation statuses, and providing a timeline interface for pickups.

## Project Structure

### Domain Layer

- **Entities**:
  - `Reservation` - Represents a reservation with status, timestamps, and related donation/beneficiary info
  - `DonationStatus` - Enum for donation statuses (DRAFT, PUBLISHED, RESERVED, COMPLETED, EXPIRED)
- **Repositories** (Abstract):
  - `ReservationRepository` - Interface for reservation-related operations
- **Use Cases**:
  - `GetUserDonationsUseCase` - Fetch donations where user is the donor
  - `GetUserReservationsUseCase` - Fetch donations where user is the beneficiary
  - `CreateReservationUseCase` - Create a new reservation

### Data Layer

- **Models**:
  - `ReservationModel` - Data model for reservations from API
- **Repositories** (Implementation):
  - `ReservationRepositoryImpl` - Implements ReservationRepository with placeholder data
- **Data Sources**:
  - Currently using placeholder data for UI development
  - Will be connected to GraphQL API later

### Presentation Layer

#### Pages

1. **MyActivitiesPage** (`/my-activities`)
   - Shows donations where the current user is the donor
   - Filterable by status: All, Active, Reserved, Completed, Expired
   - Displays a list of donation cards
   - Navigates to donation details

2. **MyReservationsPage** (`/my-reservations`)
   - Shows donations where the current user is the beneficiary (reservations)
   - Filterable by status: All, Reserved, Completed
   - Displays a list of donation cards with reservation status
   - Navigates to reservation details

3. **DonationDetailsFullPage** (`/donation-details-full`)
   - Shows complete details of a donation
   - Includes title, description, category, quantity, condition
   - Shows donor information
   - "Reserve Now" button that triggers confirmation dialog

4. **ReservationDetailsPage** (`/reservation-details`)
   - Shows pickup location with map placeholder
   - Displays order progress timeline (Reserved → Confirmed → Picked up)
   - Donor contact card with chat/call functionality
   - "Mark as Picked Up" button for completing reservations

#### Widgets

- **StatusBadge** - Displays donation/reservation status with color coding
- **DonationCard** - List item showing donation summary with image and status
- **StatusFilterChip** - Filter chips for status filtering
- **ReservationTimeline** - Visual timeline of reservation progress
- **UserContactCard** - Displays donor/beneficiary info with contact actions
- **ReservationConfirmedDialog** (Popup) - Confirmation dialog after reserve button

#### BLoC

- **ReservationBloc** - State management for all reservation operations
  - Events: FetchUserDonations, FetchUserReservations, CreateReservation, etc.
  - States: Various loading, loaded, and error states for each operation

## Color Scheme

New status colors added to `AppColors`:

- **Active/Published**: Light green background (#D1FAE5) with dark green text (#065F46)
- **Reserved**: Light orange background (#FEF3C7) with dark orange text (#92400E)
- **Completed**: Light green background (#D1FAE5) with dark green text (#065F46)
- **Expired/Draft**: Light gray background (#E5E7EB) with dark gray text (#6B7280)

## Navigation Routes

- `/my-activities` - User's donated items
- `/my-reservations` - User's reserved items (as beneficiary)
- `/donation-details-full` - Full donation details
- `/reservation-details` - Reservation pickup status and timeline

## UI Integration Points

1. **Profile Page**: Added "My Activities" button in preferences section
2. **Browse Donations Page**: Added shopping bag icon in header for "My Reservations"

## Placeholder Data

Currently using mock data with:

- 4 sample donations with different statuses
- Placeholder images from Unsplash
- Mock user and beneficiary data
- Simulated API delays for testing

## Next Steps for API Integration

1. Implement `ReservationRemoteDataSource` for GraphQL queries
2. Update models to handle actual API responses
3. Connect use cases to real GraphQL operations
4. Implement file upload for donation images
5. Add real-time updates for reservation status changes
6. Connect donation details page to actual donor information

## Dependencies

- `flutter_bloc` - State management
- `go_router` - Navigation
- `fpdart` - Functional programming (Either type for error handling)
- `flutter_screenutil` - Responsive design
- `cached_network_image` - Image caching (for future implementation)

## File Locations

```
lib/features/reservation/
├── domain/
│   ├── entities/
│   │   ├── reservation.dart
│   │   └── donation_status.dart
│   ├── repositories/
│   │   └── reservation_repository.dart
│   └── usecases/
│       ├── create_reservation_usecase.dart
│       ├── get_user_donations_usecase.dart
│       └── get_user_reservations_usecase.dart
├── data/
│   ├── models/
│   │   └── reservation_model.dart
│   ├── repositories/
│   │   └── reservation_repository_impl.dart
│   └── datasources/ (ready for implementation)
└── presentation/
    ├── bloc/
    │   ├── reservation_bloc.dart
    │   ├── reservation_event.dart
    │   └── reservation_state.dart
    ├── pages/
    │   ├── my_activities_page.dart
    │   ├── my_reservations_page.dart
    │   ├── donation_details_full_page.dart
    │   └── reservation_details_page.dart
    └── widgets/
        ├── status_badge.dart
        ├── donation_card.dart
        ├── status_filter_chip.dart
        ├── reservation_timeline.dart
        ├── user_contact_card.dart
        └── reservation_confirmed_dialog.dart
```
