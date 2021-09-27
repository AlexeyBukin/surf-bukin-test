import 'package:surf/domain/profile.dart';
import 'package:surf/interactor/profile/profile_repository.dart';

class ProfileInteractor {
  final ProfileRepository _profileRepository;

  ProfileInteractor(this._profileRepository);

  Future<ProfileInfo> loadProfileInfo() async {
    final name = _profileRepository.getName();
    final address = _profileRepository.getShippingAddress();
    final shapes = _profileRepository.getBodyShapesInfo();
    final image = _profileRepository.getProfileImageProvider();
    final email = _profileRepository.getEmail();
    final zipCode = _profileRepository.getZipCode();
    return ProfileInfo(
      name: await name,
      profileImageProvider: await image,
      bodyShapes: await shapes,
      shippingAddress: await address,
      email: await email,
      zipCode: await zipCode,
    );
  }
}
