import 'package:flutter/material.dart';

class Sort extends StatefulWidget {
  const Sort({super.key});

  @override
  State<Sort> createState() => _SortState();
}

enum Option { like, save, view }

class _SortState extends State<Sort> {
  Option? _option = Option.like;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        myModalBottomSheet(context);
      },
      icon: const Icon(Icons.category),
      color: Colors.white,
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFFFF5722),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Future<dynamic> myModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    'Sıralama Seçenekleri',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                _buildRadioItem(
                  'En Çok Beğenilenler',
                  Option.like,
                  setModalState,
                ),
                _buildRadioItem(
                  'En Çok Yorumlananlar',
                  Option.save,
                  setModalState,
                ),
                _buildRadioItem(
                  'En Çok Görüntülenenler',
                  Option.view,
                  setModalState,
                ),
                _buildRadioItem('Yeniden Eskiye', Option.view, setModalState),
                _buildRadioItem('Eskiden Yeniye', Option.view, setModalState),
              ],
            );
          },
        );
      },
    );
  }

  // --- YARDIMCI METOD ---
  Widget _buildRadioItem(
    String title,
    Option value,
    StateSetter setModalState,
  ) {
    return RadioListTile<Option>(
      fillColor: const WidgetStatePropertyAll(Color(0xFFFF5722)),
      title: Text(title),
      value: value,
      groupValue: _option,
      onChanged: (Option? newValue) {
        setModalState(() => _option = newValue);
        setState(() => _option = newValue);
      },
    );
  }
}
