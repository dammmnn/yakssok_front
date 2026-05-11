import 'package:flutter/material.dart';

import '../../core/theme.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = const [
    _ChatMessage(
      isBot: true,
      text: '안녕하세요! 약쏙 AI 상담사입니다 😊\n약 복용, 부작용, 약 조합 등 궁금한 점을 무엇이든 질문해 보세요.',
      time: '오전 10:00',
    ),
    _ChatMessage(
      isBot: false,
      text: '타이레놀이랑 이부프로펜 같이 먹어도 되나요?',
      time: '오전 10:01',
    ),
    _ChatMessage(
      isBot: true,
      text: '타이레놀(아세트아미노펜)과 이부프로펜은 작용 기전이 달라서 함께 복용 가능합니다.\n\n단, 이부프로펜은 식후에 복용하시고, 위장이 약하신 분은 주의가 필요해요. 정해진 용량을 지켜 드시는 것이 중요합니다!',
      time: '오전 10:01',
    ),
    _ChatMessage(
      isBot: false,
      text: '아, 그렇군요! 혹시 공복에 먹어도 괜찮나요?',
      time: '오전 10:02',
    ),
    _ChatMessage(
      isBot: true,
      text: '타이레놀은 공복에도 복용 가능하지만, 이부프로펜은 반드시 식후에 드셔야 해요. 공복 복용 시 위장 장애나 속 쓰림이 생길 수 있습니다.\n\n정확한 복용법은 복약 설명서를 꼭 확인하시고, 증상이 지속되면 가까운 약국 또는 병원을 방문하세요.',
      time: '오전 10:02',
    ),
    _ChatMessage(
      isBot: false,
      text: '감사합니다! 많은 도움이 됐어요.',
      time: '오전 10:03',
    ),
    _ChatMessage(
      isBot: true,
      text: '도움이 되어 기쁩니다 😊 더 궁금한 점이 있으면 언제든지 질문해 주세요!',
      time: '오전 10:03',
    ),
  ];

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    // 추후 백엔드 연동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.searchChatBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_rounded,
                  color: AppColors.searchChatPrimary, size: 20),
            ),
            const SizedBox(width: AppDimensions.paddingMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '약쏙 AI 상담',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '임시 더미 데이터',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXl,
                vertical: AppDimensions.paddingLg,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _ChatBubble(message: _messages[index]),
            ),
          ),
          _InputBar(
            controller: _inputController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

// ─── 채팅 버블 ─────────────────────────────────────────────
class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});
  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isBot = message.isBot;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingLg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.searchChatBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_rounded,
                  color: AppColors.searchChatPrimary, size: 18),
            ),
            const SizedBox(width: AppDimensions.paddingSm),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLg,
                    vertical: AppDimensions.paddingMd,
                  ),
                  decoration: BoxDecoration(
                    color: isBot
                        ? AppColors.surface
                        : AppColors.searchChatPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppDimensions.radiusXl),
                      topRight: const Radius.circular(AppDimensions.radiusXl),
                      bottomLeft: Radius.circular(
                          isBot ? AppDimensions.radiusSm : AppDimensions.radiusXl),
                      bottomRight: Radius.circular(
                          isBot ? AppDimensions.radiusXl : AppDimensions.radiusSm),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: isBot ? AppColors.textPrimary : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (!isBot) const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ─── 입력창 ────────────────────────────────────────────────
class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.paddingXl,
        AppDimensions.paddingMd,
        AppDimensions.paddingMd,
        AppDimensions.paddingMd + bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: '약에 대해 무엇이든 물어보세요...',
                  hintStyle: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLg,
                    vertical: AppDimensions.paddingMd,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusPill),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSm),
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.searchChatPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 모델 ──────────────────────────────────────────────────
class _ChatMessage {
  const _ChatMessage({
    required this.isBot,
    required this.text,
    required this.time,
  });
  final bool isBot;
  final String text;
  final String time;
}
