package no.nordicsemi.android.mcumgr_flutter.utils

/**
 * Checks if the receiver is `null` and if so, executes the `nullClause`, forcing an early exit.
 * @param nullClause A block to be performed if receiver is null.
 * This block must end with a `return` statement, forcing an early exit from surrounding scope on `null`.
 * @return The receiver, now guaranteed not to be null.
 */
inline fun<T> T?.guard(nullClause: () -> Nothing): T {
	return this ?: nullClause()
}