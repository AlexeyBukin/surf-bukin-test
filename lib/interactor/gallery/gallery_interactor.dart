import 'package:surf/domain/product.dart';
import 'package:surf/interactor/gallery/gallery_repository.dart';

class GalleryInteractor {
  final GalleryRepository _galleryRepository;

  GalleryInteractor(this._galleryRepository);

  Future<List<Product>> getProductsPortion({
    required int portionNum,
    required int portionSize,
  }) async {
    return _galleryRepository.getProducts(
      offset: portionNum * portionSize,
      quantity: portionSize,
    );
  }

  Future<List<Product>> getAllProducts() async {
    return _galleryRepository.getProducts();
  }
}
