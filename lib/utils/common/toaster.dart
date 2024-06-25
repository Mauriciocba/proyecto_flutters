import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart' as styled_toast;

mixin Toaster {
  void showToast({
    required BuildContext context,
    required String message,
    bool isNotification = false,
    bool isError = false,
  }) {
    styled_toast.showToastWidget(
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: isNotification
            ? _CustomToastNotification(msg: message)
            : _CustomToast(msg: message, isError: isError),
      ),
      context: context,
      position: const styled_toast.StyledToastPosition(
        align: Alignment.bottomRight,
      ),
      animDuration: Duration.zero,
    );
  }
}

class _CustomToast extends StatefulWidget {
  final String _msg;
  final bool _isError;
  const _CustomToast({required String msg, required bool isError})
      : _isError = isError,
        _msg = msg;

  @override
  State<_CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<_CustomToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(1.2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.elasticOut));

    _animation.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget._isError ? Colors.red : Colors.green;
    return SlideTransition(
      position: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: color.shade50,
          border: Border(left: BorderSide(color: color, width: 2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 8,
              spreadRadius: 4,
              offset: const Offset(4, 6),
            )
          ],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget._isError
                ? Icon(Icons.error_outline_outlined, color: color.shade800)
                : Icon(
                    Icons.check_circle_outline_outlined,
                    color: color.shade800,
                  ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              widget._msg,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomToastNotification extends StatelessWidget {
  final String _msg;
  const _CustomToastNotification({required String msg}) : _msg = msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(255, 214, 214, 214),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline_outlined),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            _msg,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
