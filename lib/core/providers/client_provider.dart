import 'package:appwrite/appwrite.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final clientProvider = Provider(
  (ref) => Client()
      .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
      .setProject('64bcc2ef5395eb345c92')
          .setSelfSigned(status: true) // For self signed certificates, only use for development

);
