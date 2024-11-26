// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:my_peopler/src/repository/sfa/estimatedCustomerReportRepository.dart' as _i27;
import 'package:my_peopler/src/repository/sfa/sfaLocationTrackRepository.dart' as _i26;

import '../../repository/attendanceRepository.dart' as _i10;
import '../../repository/authRepository.dart' as _i7;
import '../../repository/awardRepository.dart' as _i14;
import '../../repository/customer/customerProductRespository.dart' as _i9;
import '../../repository/documentRepository.dart' as _i16;
import '../../repository/expense/expenseRepository.dart' as _i12;
import '../../repository/holidayRepository.dart' as _i19;
import '../../repository/leaveRepository.dart' as _i15;
import '../../repository/noticeRepository.dart' as _i18;
import '../../repository/payrollRepository.dart' as _i21;
import '../../repository/profileRepository.dart' as _i13;
import '../../repository/projectRepository.dart' as _i17;
import '../../repository/sfa/sfaCustomerListRepository.dart' as _i22;
import '../../repository/sfa/sfaPaymentListRepository.dart' as _i23;
import '../../repository/sfa/sfaPaymentRepository.dart' as _i8;
import '../../repository/sfa/sfaProductListRepository.dart' as _i25;
import '../../repository/sfa/sfaTourPlanRepository.dart' as _i24;
import '../../repository/surveyPollRepository.dart' as _i20;
import '../../services/devHttpService.dart' as _i4;
import '../../services/iHttpService.dart' as _i3;
import '../../services/prodHttpService.dart' as _i6;
import '../../services/services.dart' as _i11;
import '../../services/sfaHttpService.dart' as _i5;

const String _dev = 'dev';
const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.IHttpService>(
    () => _i4.DevHttpService(),
    registerFor: {_dev},
  );
  gh.factory<_i5.SfaHttpService>(
    () => _i5.SfaHttpService(),
    registerFor: {_prod},
  );
  gh.factory<_i3.IHttpService>(
    () => _i6.ProdHttpService(),
    registerFor: {_prod},
  );
  gh.factory<_i7.AuthRepository>(
    () => _i7.AuthRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i8.SfaPaymentScheduleRepository>(
    () => _i8.SfaPaymentScheduleRepository(gh<_i5.SfaHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i9.CustomerProductListRepository>(
    () => _i9.CustomerProductListRepository(gh<_i3.IHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i10.AttendanceRepository>(
    () => _i10.AttendanceRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i12.ExpenseRepository>(
    () => _i12.ExpenseRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i13.ProfileRepository>(
    () => _i13.ProfileRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i14.AwardRepository>(
    () => _i14.AwardRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i15.LeaveRepository>(
    () => _i15.LeaveRepository(gh<_i3.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i16.DocumentRepository>(
    () => _i16.DocumentRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i17.ProjectRepository>(
    () => _i17.ProjectRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i18.NoticeRepository>(
    () => _i18.NoticeRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i19.HolidayRepository>(
    () => _i19.HolidayRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i20.SurveyPollRespository>(
    () => _i20.SurveyPollRespository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i21.PayrollRepository>(
    () => _i21.PayrollRepository(gh<_i11.IHttpService>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i22.SfaCustomerListRepository>(
    () => _i22.SfaCustomerListRepository(gh<_i5.SfaHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i23.SfaPaymentListRepository>(
    () => _i23.SfaPaymentListRepository(gh<_i5.SfaHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i24.SfaTourPlanRepository>(
    () => _i24.SfaTourPlanRepository(gh<_i5.SfaHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i25.SfaProductListRepository>(
    () => _i25.SfaProductListRepository(gh<_i5.SfaHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i26.SfaLocationTrackRepository>(
    () => _i26.SfaLocationTrackRepository(gh<_i3.IHttpService>()),
    registerFor: {_prod},
  );
  gh.factory<_i27.SfaEstimatedCustomerRepository>(
    () => _i27.SfaEstimatedCustomerRepository(gh<_i3.IHttpService>()),
    registerFor: {_prod},
  );
  return getIt;
}
