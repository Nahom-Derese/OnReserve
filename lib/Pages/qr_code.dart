import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/qr_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    if (mounted) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
      )..repeat(reverse: true);
      _animation = Tween<Offset>(
        begin: Offset(0, -30),
        end: Offset(0, 30),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }
  }

  @override
  void reassemble() {
    super.reassemble();

    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    if (mounted) {
      controller.scannedDataStream.listen((scanData) async {
        final validCode = await _isValidCode(scanData.code);
        // check if state is mounted

        if (validCode) {
          controller.pauseCamera();
          _showSuccessSnackbar();
        } else {
          controller.pauseCamera();
          _showErrorSnackbar();
        }
      });
    }
  }

  Future<bool> _isValidCode(String? code) async {
    // Here you can add your own code validation logic
    var controller = Get.find<QRController>();
    print(code);
    try {
      var codes = jsonDecode(code ?? "");
      return await controller.isValidCode(codes['bookingToken']);
    } catch (e) {}
    return code != null && code.startsWith('{"bookingToken":');
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text('QR code scanned successfully'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ))
        .closed
        .then((_) {
      Navigator.of(context).pop();
    });
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text('QR code not valid'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ))
        .closed
        .then((_) {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: SafeArea(
          child: Text(
            "Scan QR Code",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 65.sp,
              fontFamily: "Inter",
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).colorScheme.primary,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SlideTransition(
                  position: _animation,
                  child: Container(
                    width: 200,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
