import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const PulsarAzulApp());

class PulsarAzulApp extends StatelessWidget {
  const PulsarAzulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ComingSoonPage(),
      ),
    );
  }
}

class ComingSoonPage extends StatefulWidget {
  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  final DateTime _launchDate = DateTime.now().add(const Duration(days: 30));
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(_calculateRemainingTime);
    });
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    setState(() {
      _remaining = _launchDate.difference(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0E21),
            Color(0xFF1D2671),
            Color(0xFF0C1445),
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Identidade visual
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/logo.png'), // Substituir pelo seu asset
                child: Icon(
                  Icons.star,
                  size: 60,
                  color: Color(0xFF64FFDA),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Título principal
              const Text(
                'Pulsar Azul',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Mensagem de status
              const Text(
                'ESTAMOS CHEGANDO EM BREVE',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF64FFDA),
                  letterSpacing: 3,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Contador regressivo
              CountdownTimer(remaining: _remaining),
              
              const SizedBox(height: 50),
              
              // Mensagem motivadora
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Estamos preparando algo extraordinário para você. '
                  'Enquanto isso, respire fundo e prepare-se para uma nova jornada. '
                  'Grandes conquistas estão a caminho ...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.6,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Botão de contato
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF64FFDA)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                icon: const Icon(Icons.email, color: Color(0xFF64FFDA)),
                label: const Text(
                  'Contate-nos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownTimer extends StatelessWidget {
  final Duration remaining;
  
  const CountdownTimer({super.key, required this.remaining});
  
  String _twoDigits(int n) => n.toString().padLeft(2, '0');
  
  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours.remainder(24);
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TimeBlock(value: days, label: 'DIAS'),
        const _TimeSeparator(),
        _TimeBlock(value: hours, label: 'HORAS'),
        const _TimeSeparator(),
        _TimeBlock(value: minutes, label: 'MIN'),
        const _TimeSeparator(),
        _TimeBlock(value: seconds, label: 'SEG'),
      ],
    );
  }
}

class _TimeBlock extends StatelessWidget {
  final int value;
  final String label;
  
  const _TimeBlock({required this.value, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0x1520B2AA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value.toString().padLeft(2, '0'),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64FFDA),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeSeparator extends StatelessWidget {
  const _TimeSeparator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64FFDA),
        ),
      ),
    );
  }
}