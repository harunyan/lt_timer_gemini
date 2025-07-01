// This file is intentionally left empty for web builds.
// Desktop-specific initialization is handled in main_desktop.dart.

// Webビルド時にinitializeDesktopが呼び出されてもエラーにならないように、空の関数を定義
Future<void> initializeDesktop() async {
  // Do nothing for web builds
}