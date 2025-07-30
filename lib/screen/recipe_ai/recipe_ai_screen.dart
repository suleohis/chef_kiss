
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:recipe_app/controllers/recipe_ai/recipe_ai_controller.dart';
import 'package:recipe_app/screen/recipe_ai/widgets/recipe_list_view.dart';
import 'package:recipe_app/screen/recipe_ai/split_or_tabs.dart';
import 'package:recipe_app/screen/recipe_ai/widgets/recipe_response_view.dart';

import '../../util/app_export.dart';
import '../../util/app_util.dart';

class RecipeAIScreen extends StatefulWidget {
  const RecipeAIScreen({super.key});

  @override
  State<RecipeAIScreen> createState() => _RecipeAIScreenState();
}

class _RecipeAIScreenState extends State<RecipeAIScreen> {

  late final LlmProvider _provider = _createProvider();
  final textController = TextEditingController();
  RecipeAiController recipeAiController = Get.put(RecipeAiController());

  // create a new provider with the given history and the current settings
  LlmProvider _createProvider([List<ChatMessage>? history]) => FirebaseProvider(
    history: history,
    model: FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          properties: {
            'recipes': Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                properties: {
                  'text': Schema(SchemaType.string),
                  'recipe': Schema(
                    SchemaType.object,
                    properties: {
                      'title': Schema(SchemaType.string),
                      'description': Schema(SchemaType.string),
                      'ingredients': Schema(
                        SchemaType.array,
                        items: Schema(SchemaType.string),
                      ),
                      'instructions': Schema(
                        SchemaType.array,
                        items: Schema(SchemaType.string),
                      ),
                    },
                  ),
                },
              ),
            ),
            'text': Schema(SchemaType.string),
          },
        ),
      ),
      systemInstruction: Content.system(systemInstructionContent),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(

    body: SafeArea(
      child: SplitOrTabs(
        tabs: const [Tab(text: 'Recipes'), Tab(text: 'Chat')],
        children: [
          Column(
            children: [
              CustomTextField(controller: textController, onChanged: (value) {
                recipeAiController.onChangedText(value);
              },).paddingAll(8.h),
              Expanded(child: RecipeListView()),
            ],
          ),
          LlmChatView(
            provider: _provider,
            welcomeMessage: welcomeMessage,
            responseBuilder: (context, response) => RecipeResponseView(response),
            onErrorCallback: (context, e) => printError(info: e.message),
          )
        ],
      ),
    ),
  );

}
