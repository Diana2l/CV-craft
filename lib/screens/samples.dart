// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, avoid_print

/// CV + Cover Letter Generator
/// 
/// This screen allows users to:
/// - Upload their CV PDF
/// - Add job description for tailored cover letters
/// - Generate AI-powered cover letters
/// - Edit and customize cover letters
/// - Generate combined PDF documents
/// 
/// Requires AI server running on localhost:3000

import 'dart:typed_data';
import 'dart:convert';
import 'package:cv_craft/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart' as sfpdf;
import 'package:printing/printing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cv_craft/screens/cv_editor_screen.dart';
import 'package:cv_craft/screens/settings.dart';
import 'package:cv_craft/screens/report_screen.dart';
import 'package:cv_craft/screens/about.dart';
import 'package:cv_craft/auth/login.dart';
import 'package:cv_craft/models/cv_data.dart' as cv;

class Samples extends StatefulWidget {
  const Samples({super.key});

  @override
  _SamplesState createState() => _SamplesState();
}

class _SamplesState extends State<Samples> {
  Uint8List? _cvBytes;
  String? _cvFileName;
  String? _cvText;
  final TextEditingController _coverLetterController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  bool _loading = false;
  bool _isAIConnected = false;
  String _aiStatus = 'Checking connection...';

  Future<void> _pickCV() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        final bytes = result.files.single.bytes!;
        
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                ),
                SizedBox(width: 12),
                Text('Extracting text from PDF...'),
              ],
            ),
            duration: Duration(seconds: 3),
          ),
        );
        
        final text = await compute(_extractTextFromPdf, bytes);

        setState(() {
          _cvBytes = bytes;
          _cvFileName = result.files.single.name;
          _cvText = text;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('CV loaded successfully: $_cvFileName'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No file selected or invalid PDF'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Now a top-level static function for background processing
  static String _extractTextFromPdf(Uint8List pdfBytes) {
    final document = sfpdf.PdfDocument(inputBytes: pdfBytes);
    final buffer = StringBuffer();
    final extractor = sfpdf.PdfTextExtractor(document);

    for (int i = 0; i < document.pages.count; i++) {
      final pageText = extractor.extractText(startPageIndex: i, endPageIndex: i);
      buffer.writeln(pageText);
    }

    document.dispose();
    return buffer.toString();
  }

  Future<void> _callAIToGenerateCoverLetter() async {
    if (_cvBytes == null || _cvText == null || _cvText!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a valid CV PDF.')),
      );
      return;
    }

    if (!_isAIConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AI Server is not connected. Please check setup.')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final uri = Uri.parse('http://127.0.0.1:3000/generate-cover-letter');
      final requestBody = {
        'cv_text': _cvText,
        'job_description': _jobDescriptionController.text.trim().isNotEmpty 
            ? _jobDescriptionController.text.trim() 
            : null,
      };
      
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _coverLetterController.text = data['cover_letter'] ?? 'No cover letter generated.';
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cover letter generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('API Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _generatePDF() async {
    if (_cvBytes == null || _coverLetterController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a CV and add a cover letter first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final document = sfpdf.PdfDocument();

      // Create cover letter page
      final coverPage = document.pages.add();
      final font = sfpdf.PdfStandardFont(sfpdf.PdfFontFamily.helvetica, 11);
      final boldFont = sfpdf.PdfStandardFont(
        sfpdf.PdfFontFamily.helvetica,
        16,
        style: sfpdf.PdfFontStyle.bold,
      );
      
      // Add title
      coverPage.graphics.drawString(
        'Cover Letter',
        boldFont,
        bounds: const Rect.fromLTWH(50, 50, 500, 30),
      );
      
      // Add cover letter content with proper formatting
      final coverLetterText = _coverLetterController.text;
      coverPage.graphics.drawString(
        coverLetterText,
        font,
        bounds: const Rect.fromLTWH(50, 100, 500, 700),
        format: sfpdf.PdfStringFormat(
          alignment: sfpdf.PdfTextAlignment.left,
          lineAlignment: sfpdf.PdfVerticalAlignment.top,
        ),
      );

      // Append CV pages
      final cvDoc = sfpdf.PdfDocument(inputBytes: _cvBytes!);
      for (int i = 0; i < cvDoc.pages.count; i++) {
        final page = cvDoc.pages[i];
        final newPage = document.pages.add();
        newPage.graphics.drawPdfTemplate(page.createTemplate(), const Offset(0, 0));
      }
      cvDoc.dispose();

      final finalPdf = Uint8List.fromList(await document.save());
      document.dispose();

      // Generate filename with timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'CV_CoverLetter_$timestamp.pdf';

      await Printing.sharePdf(bytes: finalPdf, filename: filename);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF generated and ready to share!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAIConnection();
  }

  Future<void> _checkAIConnection() async {
    try {
      final uri = Uri.parse('http://127.0.0.1:3000/health');
      final response = await http.get(uri).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _isAIConnected = true;
          _aiStatus = data['ai_enabled'] == true ? 'AI Server Connected (OpenAI)' : 'AI Server Connected (Template Mode)';
        });
      } else {
        setState(() {
          _isAIConnected = false;
          _aiStatus = 'AI Server Error (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _isAIConnected = false;
        _aiStatus = 'AI Server Offline - ${e.toString().contains('Connection refused') ? 'Not Running' : 'Connection Error'}';
      });
    }
  }

  // 🔹 Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Text('Welcome!'),
          ),
          _drawerItem(Icons.home, 'Home', () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Home()),
          )),
          _drawerItem(Icons.settings, 'Settings', () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Settings(onThemeChanged: (bool _) {})),
          )),
          _drawerItem(Icons.report, 'Reports', () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ReportScreen(cvData: cv.CVData())),
          )),
          _drawerItem(Icons.type_specimen, 'Samples', () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Samples()),
          )),
          _drawerItem(Icons.info, 'About Us', () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => About()),
          )),
          _drawerItem(Icons.logout, 'Log Out', () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Login()),
          )),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text(
          'CV + Cover Letter',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_document),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CVEditorScreen(
                    fontSize: 16,
                    headerFontSize: 24,
                    fontFamily: 'OpenSans',
                    color: Colors.teal,
                    objective: _cvText ?? '',
                    template: 'modern',
                    templateImage: 'assets/images/Modern.png',
                  ),
                ),
              );
            },
            tooltip: 'Edit in CV Editor',
          ),
          IconButton(
            icon: Icon(
              _isAIConnected ? Icons.cloud_done : Icons.cloud_off,
              color: _isAIConnected ? Colors.green : Colors.red,
            ),
            onPressed: _checkAIConnection,
            tooltip: _aiStatus,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AI Status Card
                _buildStatusCard(),
                const SizedBox(height: 20),
                
                // Instructions Card
                _buildInstructionsCard(),
                const SizedBox(height: 20),
                
                // CV Upload Section
                _buildCVUploadSection(),
                const SizedBox(height: 20),
                
                // Job Description Section
                _buildJobDescriptionSection(),
                const SizedBox(height: 20),
                
                // AI Generation Section
                _buildAIGenerationSection(),
                const SizedBox(height: 20),
                
                // Cover Letter Section
                _buildCoverLetterSection(),
                const SizedBox(height: 20),
                
                // Actions Section
                _buildActionsSection(),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: Colors.teal),
                      const SizedBox(height: 16),
                      Text(
                        'Processing...',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AI is generating your cover letter',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _isAIConnected ? Icons.check_circle : Icons.error,
              color: _isAIConnected ? Colors.green : Colors.red,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Status',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _aiStatus,
                    style: TextStyle(
                      color: _isAIConnected ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: _checkAIConnection,
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Card(
      elevation: 2,
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'How to Use',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '1. Upload your CV PDF\n'
              '2. (Optional) Add job description for tailored cover letter\n'
              '3. Generate AI cover letter\n'
              '4. Edit and customize as needed\n'
              '5. Generate combined PDF',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCVUploadSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload CV',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickCV,
                icon: const Icon(Icons.upload_file),
                label: const Text('Select CV PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (_cvFileName != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Selected: $_cvFileName',
                        style: TextStyle(color: Colors.green.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildJobDescriptionSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Description (Optional)',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add job description to generate a tailored cover letter',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _jobDescriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Paste the job description here...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIGenerationSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Cover Letter Generation',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isAIConnected && _cvBytes != null ? _callAIToGenerateCoverLetter : null,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Cover Letter with AI'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (!_isAIConnected) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade600, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'AI server is offline. Please check setup instructions below.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCoverLetterSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cover Letter',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Edit and customize your cover letter',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _coverLetterController,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: 'Your cover letter will appear here...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generate Documents',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _cvBytes != null && _coverLetterController.text.trim().isNotEmpty
                        ? _generatePDF
                        : null,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Generate PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Clear All Data'),
                          content: const Text('Are you sure you want to clear all data? This action cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _coverLetterController.clear();
                                _jobDescriptionController.clear();
                                setState(() {
                                  _cvBytes = null;
                                  _cvFileName = null;
                                  _cvText = null;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('All data cleared'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: const Text('Clear', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear All'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
