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

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  LlmProvider _createProvider([List<ChatMessage>? history]) => FirebaseProvider(
        history: history,
        model: FirebaseAI.googleAI().generativeModel(
          model: 'gemini-2.5-flash-lite',
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
            responseSchema: Schema(
              SchemaType.object,
              nullable: false,
              properties: {
                'recipes': Schema(
                  SchemaType.array,
                  nullable: false,
                  items: Schema(
                    SchemaType.object,
                    nullable: false,
                    properties: {
                      'text': Schema(SchemaType.string, nullable: true),
                      'recipe': Schema(
                        SchemaType.object,
                        nullable: true,
                        properties: {
                          'title': Schema(SchemaType.string, nullable: true),
                          'description': Schema(SchemaType.string, nullable: true),
                          'cookingTime': Schema(SchemaType.string, nullable: true),
                          'servings': Schema(SchemaType.string, nullable: true),
                          'ingredients': Schema(
                            SchemaType.array,
                            nullable: true,
                            items: Schema(SchemaType.string, nullable: true),
                          ),
                          'instructions': Schema(
                            SchemaType.array,
                            nullable: true,
                            items: Schema(SchemaType.string, nullable: true),
                          ),
                          'tags': Schema(
                            SchemaType.array,
                            nullable: true,
                            items: Schema(SchemaType.string, nullable: true),
                          ),
                        },
                      ),
                    },
                  ),
                ),
                'text': Schema(SchemaType.string, nullable: true),
              },
            ),
          ),
          systemInstruction: Content.system(systemInstructionContent),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chef Kiss AI'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SplitOrTabs(
            tabs: const [Tab(text: 'My Recipes'), Tab(text: 'Chat')],
            children: [
              Column(
                children: [
                  CustomTextField(
                    controller: textController,
                    hint: 'Search recipes…',
                    label: 'Search',
                    onChanged: (value) {
                      recipeAiController.onChangedText(value);
                    },
                  ).paddingAll(8.h),
                  Expanded(child: RecipeListView()),
                ],
              ),
              LlmChatView(
                provider: _provider,
                welcomeMessage: welcomeMessage,
                responseBuilder: (context, response) =>
                    RecipeResponseView(response),
                onErrorCallback: (context, e) {
                  print('here');
                  printError(info: e.message);
                },
              ),
            ],
          ),
        ),
      );
}
