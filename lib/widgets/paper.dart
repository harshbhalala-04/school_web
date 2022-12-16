import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Paper extends pw.StatelessWidget with pw.SpanningWidget {
  final pw.Widget child;

  Paper({
    required this.child,
  });

  @override
  pw.Widget build(pw.Context context) {
    return child;
    
  }
}