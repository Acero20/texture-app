import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.dark(),
      home: TextureGeneratorApp(),
      debugShowCheckedModeBanner: false,
    ));

class TextureGeneratorApp extends StatefulWidget {
  @override
  _TextureGeneratorAppState createState() => _TextureGeneratorAppState();
}

class _TextureGeneratorAppState extends State<TextureGeneratorApp> {
  int _currentStep = 0;
  double _brightness = 0;
  double _contrast = 100;
  double _hairThreshold = 95;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090412),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentStep == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.purpleAccent),
                onPressed: () => setState(() => _currentStep = 0),
              )
            : null,
        title: Text(
          _currentStep == 0 ? 'OFFLINE UV TEXTURE GENERATOR' : 'TEXTURE INSPECTOR',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      body: _currentStep == 0 ? _buildAdjustScreen() : _buildInspectorScreen(),
    );
  }

  Widget _buildAdjustScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildActionButton(Icons.photo_library, "Gallery")),
              const SizedBox(width: 12),
              Expanded(child: _buildActionButton(Icons.camera_alt, "Camera")),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Upload Images", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    Text("Recommended: 2048 × 2048", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSlot("Front", true),
                    _buildImageSlot("Left", true),
                    _buildImageSlot("Right", true),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text("START", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 6),
          const Text("OFFLINE MODE  |  NO INTERNET REQUIRED",
              style: TextStyle(fontSize: 9, color: Colors.purpleAccent, letterSpacing: 1.1)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildPreviewCard("512 × 512 px", "H1 - NORMAL MAP (RGB8)", Icons.texture)),
              const SizedBox(width: 12),
              Expanded(child: _buildPreviewCard("256 × 256 px", "H1 - SKIN / MATERIAL", Icons.face)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                _buildSlider("Brightness", _brightness, -100, 100, (v) => setState(() => _brightness = v)),
                _buildSlider("Contrast", _contrast, 0, 200, (v) => setState(() => _contrast = v)),
                _buildSlider("Hair Threshold", _hairThreshold, 0, 100, (v) => setState(() => _hairThreshold = v)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _brightness = 0;
                        _contrast = 100;
                        _hairThreshold = 95;
                      });
                    },
                    icon: const Icon(Icons.refresh, size: 14, color: Colors.purpleAccent),
                    label: const Text("Reset", style: TextStyle(color: Colors.purpleAccent, fontSize: 12)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A148C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () => setState(() => _currentStep = 1),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInspectorScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("H1 - FACE DIFFUSE - 512 × 512", style: TextStyle(fontSize: 11, color: Colors.purpleAccent)),
                    Text("512 × 512 px", style: TextStyle(fontSize: 10, color: Colors.greenAccent)),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple.withOpacity(0.3)),
                  ),
                  child: const Center(child: Icon(Icons.portrait, size: 80, color: Colors.purpleAccent)),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildSmallButton("PREVIEW", Icons.visibility)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildSmallButton("EXPORT", Icons.download, color: Colors.purpleAccent)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildSmallButton("REPLACE", Icons.swap_horiz, color: Colors.pinkAccent)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("DETECTED TEXTURES & PNGs (4)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
            children: [
              _buildGridCard("#1", "FACE DIFFUSE", "512 × 512 px", "ETC2_RGBA8"),
              _buildGridCard("#2", "SKIN / MATERIAL", "512 × 512 px", "ETC2_RGB"),
              _buildGridCard("#3", "NORMAL MAP", "512 × 512 px", "RGB8 Normal"),
              _buildGridCard("#4", "SKIN / MATERIAL", "256 × 256 px", "ETC2_RGB"),
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: const Color(0xFF140D26),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.purple.shade900.withOpacity(0.6), width: 1.5),
    );
  }

  Widget _buildActionButton(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: _boxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 18),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildImageSlot(String label, bool isDone) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purpleAccent),
              ),
              child: const Icon(Icons.person, color: Colors.white54, size: 35),
            ),
            if (isDone)
              const Positioned(
                top: 2, right: 2,
                child: Icon(Icons.check_circle, color: Colors.greenAccent, size: 14),
              )
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
      ],
    );
  }

  Widget _buildPreviewCard(String res, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Icon(icon, color: Colors.purpleAccent, size: 30)),
          ),
          const SizedBox(height: 6),
          Text(res, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(fontSize: 8, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildSmallButton("EXPORT", Icons.download, color: Colors.purpleAccent)),
              const SizedBox(width: 4),
              Expanded(child: _buildSmallButton("REPLACE", Icons.swap_horiz, color: Colors.pinkAccent)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double val, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
            Text(val.toInt().toString(), style: const TextStyle(fontSize: 11, color: Colors.white)),
          ],
        ),
        Slider(
          value: val,
          min: min,
          max: max,
          activeColor: Colors.purpleAccent,
          inactiveColor: Colors.purple.shade900,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildGridCard(String num, String title, String res, String format) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$num  $format", style: const TextStyle(fontSize: 9, color: Colors.purpleAccent)),
          const SizedBox(height: 4),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Icon(Icons.image, color: Colors.white30, size: 30)),
            ),
          ),
          const SizedBox(height: 4),
          Text(res, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(fontSize: 8, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSmallButton(String label, IconData icon, {Color color = Colors.purple}) {
    return Container(
      height: 24,
      decoration: BoxDecoration(color: color.withOpacity(0.3), borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 9, color: Colors.white),
          const SizedBox(width: 2),
          Text(label, style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
