import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class Offline extends StatelessWidget {
  const Offline({super.key, required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => _Message(
        icon: Icons.wifi_off,
        title: 'No connection',
        subtitle: 'Check your network and try again.',
        onRetry: onRetry,
      );
}

class ServerError extends StatelessWidget {
  const ServerError(this.status, {super.key, required this.onRetry});
  final int status;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => _Message(
        icon: Icons.cloud_off,
        title: 'Server error ($status)',
        subtitle: 'Their side, not yours. Try again in a moment.',
        onRetry: onRetry,
      );
}

class NotAllowed extends StatelessWidget {
  const NotAllowed({super.key});

  @override
  Widget build(BuildContext context) => const _Message(
        icon: Icons.lock_outline,
        title: 'Not available',
        subtitle: 'This request was refused. Retrying will not help.',
      );
}

class GenericError extends StatelessWidget {
  const GenericError({super.key, this.detail});
  final String? detail;

  @override
  Widget build(BuildContext context) => _Message(
        icon: Icons.bug_report_outlined,
        title: 'Unexpected response',
        subtitle: detail ?? 'The server answered with data we cannot read.',
      );
}

// A ListView, so pull-to-refresh also works on the error screens.
class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 480,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 56),
                  const SizedBox(height: 16),
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(subtitle, textAlign: TextAlign.center),
                  if (onRetry != null) ...[
                    const SizedBox(height: 16),
                    FilledButton(onPressed: onRetry, child: const Text('Retry')),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
