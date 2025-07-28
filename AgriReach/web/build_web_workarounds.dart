import 'dart:io';

Future<void> main() async {
  // This script ensures the web workarounds are built before the main app
  print('Building web workarounds...');
  
  try {
    // Build the web workarounds
    final result = await Process.run(
      'dart',
      [
        'compile',
        'js',
        '-O4',
        '-o',
        'image_cropper_web_workaround.dart.js',
        'image_cropper_web_workaround.dart',
      ],
      workingDirectory: 'web',
      runInShell: true,
    );
    
    if (result.exitCode != 0) {
      print('Error building web workarounds:');
      print(result.stderr);
      exit(1);
    }
    
    print('Successfully built web workarounds');
  } catch (e) {
    print('Error building web workarounds: $e');
    exit(1);
  }
}
