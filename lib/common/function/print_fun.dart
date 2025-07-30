import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void printError(dynamic data) {
    FirebaseCrashlytics.instance.log(data);
    logger.e(data);
}

void printInfo(dynamic data) {
    logger.i(data);
}

void printWarning(dynamic data) {
    FirebaseCrashlytics.instance.log(data,);
    logger.w(data);
}