import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:knitting_app/controllers/providers/ai_answers_provider.dart';
import 'package:knitting_app/models/ai_answer_model.dart';
import 'package:provider/provider.dart';

class AiView extends StatefulWidget {
  const AiView({super.key});

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  List<AiAnswerModel> aiAnswers = [];

  final TextEditingController _questionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String _imagePath = "";

  String result = "";
  bool isResultLoading = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  // Diyalog açıkken async yapmak UX için kötüdür. Onay önce, işlem sonra yapılsın
  Future<void> _showMyDialog() async {
    final approved = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // kullanıcı
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uyarı!'),
          content: Text(
            'Her bir sorgunuz günlük yapay zeka kotanızdan bir azaltır. Şuanki hakkınız x/20 -> Sonraki hakkınız x-1/20. Göndermrek istediğinze emin imisniz',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Onayla'),
            ),
          ],
        );
      },
    );

    if (approved == true) {
      _sendQuestion();
    }
  }

  Future<void> _sendQuestion() async {
    // ilk setstate yapılır bunu unutma
    setState(() {
      isResultLoading = true;
    });

    try {
      final _aiAnswer = await askGPT(
        question: _questionController.text,
        imageFile: _selectedImage,
      );

      context.read<AiAnswersProvider>().addAiAnswer(
        _questionController.text,
        _aiAnswer,
        _imagePath,
      );

      setState(() {
        result = _aiAnswer;
      });
    } catch (e) {
      setState(() {
        result = "Bir hata olustu: $e";
      });
    } finally {
      setState(() {
        isResultLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiAnswersProvider = context.watch<AiAnswersProvider>();
    aiAnswers = aiAnswersProvider.aiAnswers;

    return Scaffold(
      appBar: AppBarWidget(title: 'Yapay Zekaya Sor'),

      body: Column(
        children: [
          Text('Günlük kullanım kotanız: x/20'),
          Text(
            'Merhaba, bu bölümde yapay zekaya metin bazlı soru sorabilir, Takıldığınız noktada yapmaya çalıştığınız örgünün fotoğrafını çekip yollayabilirsiniz vb vb.',
          ),

          TextField(
            controller: _questionController,
            decoration: InputDecoration(
              labelText: 'Sorunu yaz',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),

          if (_selectedImage != null)
            Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),

          ElevatedButton(
            onPressed: () {
              _pickImage();
            },
            child: Text('Görsel seç'),
          ),

          ElevatedButton(
            onPressed: () {
              _showMyDialog();
            },
            child: Text('Gönder'),
          ),

          if (isResultLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          if (!isResultLoading && result.isNotEmpty)
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: SelectableText(result),
            ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          Text('Önceki sorguların'),

          Expanded(
            child: ListView.builder(
              itemCount: aiAnswers.length,
              itemBuilder: (context, index) {
                final ai = aiAnswers[index];

                return Card(
                  child: ExpansionTile(
                    title: Text(ai.question),
                    subtitle: Text(ai.time.toString()),
                    children: <Widget>[Text(ai.answer)],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
