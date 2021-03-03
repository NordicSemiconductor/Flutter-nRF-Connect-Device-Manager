package no.nordicsemi.android.mcumgr_flutter.utils

import java.lang.Exception

sealed class FlutterError(val code: String, message: String): Exception(message) {}

class WrongArguments(message: String): FlutterError("WrongArguments", message)
class UpdateManagerExists(message: String): FlutterError("UpdateManagerExists", message)
class UpdateManagerDoesNotExist(message: String): FlutterError("UpdateManagerDoesNotExist", message)