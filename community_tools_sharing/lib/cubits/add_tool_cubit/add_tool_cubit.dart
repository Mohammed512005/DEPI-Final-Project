import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_tools_sharing/cubits/add_tool_cubit/add_tool_states.dart';
import 'package:community_tools_sharing/services/supabase_service.dart';
import 'package:community_tools_sharing/ui/models/tool_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddToolCubit extends Cubit<AddToolState> {
  AddToolCubit() : super(AddToolInitial());

  final SupabaseService _supabaseService = SupabaseService();

  Future<void> addTool(ToolModel model) async {
    try {
      emit(AddToolLoading());

      print("USER: ${Supabase.instance.client.auth.currentUser}");

      final imageUrl = await _supabaseService.uploadToolImage(
        image: model.image,
        toolId: DateTime.now().millisecondsSinceEpoch.toString(),
        fileName: 'main.jpg',
      );

      model.imageUrl = imageUrl;

      await FirebaseFirestore.instance.collection("tools").add({
        "toolName": model.toolName,
        "category": model.category,
        "condition": model.condition,
        "description": model.description,
        "price": model.price,
        "rentalPeriod": model.rentalPeriod,
        "imageUrl": model.imageUrl,
        "createdAt": DateTime.now(),
        "latitude": model.latitude,
        "longitude": model.longitude,
      });

      emit(AddToolSuccess());
    } catch (e) {
      emit(AddToolError(e.toString()));
    }
  }
}
