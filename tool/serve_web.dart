// Minimal static server for play-testing the web build:
//   flutter build web --release
//   dart run tool/serve_web.dart [port]
import 'dart:io';

const _types = {
  'html': 'text/html; charset=utf-8',
  'js': 'application/javascript',
  'mjs': 'application/javascript',
  'json': 'application/json',
  'wasm': 'application/wasm',
  'css': 'text/css',
  'png': 'image/png',
  'ico': 'image/x-icon',
  'wav': 'audio/wav',
  'ttf': 'font/ttf',
  'otf': 'font/otf',
  'bin': 'application/octet-stream',
  'frag': 'application/octet-stream',
};

Future<void> main(List<String> args) async {
  final port = args.isNotEmpty ? int.parse(args.first) : 8765;
  final root = Directory('build/web').absolute.path;
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  stdout.writeln('Serving $root on http://localhost:$port');
  await for (final req in server) {
    var path = Uri.decodeComponent(req.uri.path);
    if (path == '/' || path.isEmpty) path = '/index.html';
    final file = File('$root$path');
    if (!path.contains('..') && await file.exists()) {
      final ext = path.split('.').last.toLowerCase();
      req.response.headers
        ..set(HttpHeaders.contentTypeHeader, _types[ext] ?? 'application/octet-stream')
        ..set(HttpHeaders.cacheControlHeader, 'no-cache');
      await req.response.addStream(file.openRead());
    } else {
      req.response.statusCode = HttpStatus.notFound;
    }
    await req.response.close();
  }
}
