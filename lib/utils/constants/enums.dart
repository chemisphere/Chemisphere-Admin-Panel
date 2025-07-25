/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

/// Switch of Custom Brand-Text-Size Widget
enum AppRole { admin, user }

enum ProductType { single, variable }

enum ProductVisibility { published, hidden }

enum TextSizes { small, medium, large }

enum ImageType { asset, network, memory, file }

enum Batch { batches, NEET11, NEET12, JEE11, JEE12}

enum MediaCategory { folders, banners, brands, categories, products, users }

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum PaymentMethods { paypal, googlePay, applePay, visa, masterCard, creditCard, paystack, razorPay, paytm }


extension BatchExtension on Batch {
  String get batchString {
    return toString().split('.').last;
  }
}